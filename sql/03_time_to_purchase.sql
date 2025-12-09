-- 03_time_to_purchase.sql
-- Purpose: Time from first view to purchase (median + average minutes)

WITH purchases AS (
  SELECT user_session, MIN(event_time) AS purchase_time
  FROM events
  WHERE event_type = 'purchase'
  GROUP BY user_session
),
views AS (
  SELECT user_session, MIN(event_time) AS first_view_time
  FROM events
  WHERE event_type = 'view'
  GROUP BY user_session
)
SELECT
  AVG(DATE_DIFF('minute', first_view_time, purchase_time)) AS avg_minutes_to_purchase,
  APPROX_QUANTILE(DATE_DIFF('minute', first_view_time, purchase_time), 0.5) AS median_minutes_to_purchase
FROM purchases p
JOIN views v USING(user_session);
