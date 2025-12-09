-- 06_cart_abandonment.sql
-- Purpose: Cart abandonment rate at session level

WITH session_steps AS (
  SELECT
    user_session,
    MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS did_cart,
    MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS did_purchase
  FROM events
  GROUP BY user_session
)
SELECT
  SUM(did_cart) AS cart_sessions,
  SUM(CASE WHEN did_cart = 1 AND did_purchase = 0 THEN 1 ELSE 0 END) AS abandoned_carts,
  ROUND(
    SUM(CASE WHEN did_cart = 1 AND did_purchase = 0 THEN 1 ELSE 0 END) * 1.0
    / NULLIF(SUM(did_cart), 0),
    4
  ) AS cart_abandon_rate
FROM session_steps;
