WITH user_totals AS( 
SELECT
  user_id,
  COUNT(DISTINCT session_id) AS total_sessions
FROM user_sessions
GROUP BY user_id
)
SELECT 
  user_id,
  total_sessions
FROM user_totals
WHERE total_sessions > (
    SELECT AVG(total_sessions)
    FROM user_totals
)
ORDER BY total_sessions DESC, user_id ASC;
