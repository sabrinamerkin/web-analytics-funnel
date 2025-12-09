-- 07_rfm_segmentation.sql
-- Purpose: RFM scoring + segment summary (VIP / New / Churn Risk)

WITH purchases AS (
  SELECT
    user_id,
    MAX(DATE(event_time)) AS last_purchase_date,
    COUNT(*) AS frequency,
    SUM(price) AS monetary
  FROM events
  WHERE event_type = 'purchase'
  GROUP BY user_id
),
scored AS (
  SELECT
    user_id,
    DATE_DIFF(
      'day',
      last_purchase_date,
      (SELECT MAX(DATE(event_time)) FROM events)
    ) AS recency_days,
    frequency,
    monetary
  FROM purchases
),
segmented AS (
  SELECT
    user_id,
    recency_days,
    frequency,
    monetary,
    CASE
      WHEN recency_days <= 30 AND frequency >= 5 THEN 'VIP / Loyal'
      WHEN recency_days <= 30 AND frequency < 5 THEN 'New / Promising'
      WHEN recency_days > 30 THEN 'Churn Risk'
    END AS segment
  FROM scored
)
SELECT
  segment,
  COUNT(*) AS users,
  ROUND(AVG(frequency), 2) AS avg_orders,
  ROUND(AVG(monetary), 2) AS avg_spend
FROM segmented
GROUP BY segment
ORDER BY users DESC;
