-- 02_funnel.sql
-- Purpose: Session-level funnel + conversion rates (view → cart → purchase)

WITH session_steps AS (
  SELECT
    user_session,
    MAX(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS did_view,
    MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS did_cart,
    MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS did_purchase
  FROM events
  GROUP BY user_session
)
SELECT
  SUM(did_view)     AS sessions_viewed,
  SUM(did_cart)     AS sessions_carted,
  SUM(did_purchase) AS sessions_purchased,
  ROUND(SUM(did_cart) * 1.0 / NULLIF(SUM(did_view),0), 4) AS view_to_cart_rate,
  ROUND(SUM(did_purchase) * 1.0 / NULLIF(SUM(did_cart),0), 4) AS cart_to_purchase_rate,
  ROUND(SUM(did_purchase) * 1.0 / NULLIF(SUM(did_view),0), 4) AS view_to_purchase_rate
FROM session_steps;
