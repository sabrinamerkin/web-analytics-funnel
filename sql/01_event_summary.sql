-- 01_event_summary.sql
-- Purpose: Basic dataset health + event mix (events, sessions, users)

SELECT
  event_type,
  COUNT(*) AS events,
  COUNT(DISTINCT user_session) AS sessions,
  COUNT(DISTINCT user_id) AS users
FROM events
GROUP BY event_type
ORDER BY events DESC;
