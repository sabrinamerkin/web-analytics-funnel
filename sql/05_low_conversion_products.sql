-- 05_low_conversion_products.sql
-- Purpose: Find products with many views but weak/zero purchases

WITH product_views AS (
  SELECT product_id, COUNT(*) AS views
  FROM events
  WHERE event_type = 'view'
  GROUP BY product_id
),
product_purchases AS (
  SELECT product_id, COUNT(*) AS purchases
  FROM events
  WHERE event_type = 'purchase'
  GROUP BY product_id
)
SELECT
  v.product_id,
  views,
  COALESCE(purchases, 0) AS purchases,
  ROUND(COALESCE(purchases, 0) * 1.0 / NULLIF(views, 0), 4) AS view_to_purchase_rate
FROM product_views v
LEFT JOIN product_purchases p USING(product_id)
WHERE views >= 100
ORDER BY view_to_purchase_rate ASC
LIMIT 20;
