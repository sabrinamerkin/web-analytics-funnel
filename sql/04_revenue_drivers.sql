-- 04_revenue_drivers.sql
-- Purpose: Identify top products, brands, and categories by purchases and revenue

-- Top products by revenue
SELECT
  product_id,
  COUNT(*) AS purchases,
  ROUND(SUM(price), 2) AS revenue
FROM events
WHERE event_type = 'purchase'
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;

-- Top brands by revenue
SELECT
  brand,
  COUNT(*) AS purchases,
  ROUND(SUM(price), 2) AS revenue,
  ROUND(AVG(price), 2) AS avg_price
FROM events
WHERE event_type = 'purchase'
  AND brand IS NOT NULL
GROUP BY brand
ORDER BY revenue DESC
LIMIT 10;

-- Top categories by revenue
SELECT
  category_code,
  COUNT(*) AS purchases,
  ROUND(SUM(price), 2) AS revenue
FROM events
WHERE event_type = 'purchase'
  AND category_code IS NOT NULL
GROUP BY category_code
ORDER BY revenue DESC
LIMIT 10;
