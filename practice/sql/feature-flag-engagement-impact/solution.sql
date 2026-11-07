WITH displays AS (
SELECT 
  flag_name, 
  REPLACE(flag_name, '_', ' ') AS display_name,
  enabled,
  created
FROM feat_flags
)
SELECT 
  d.flag_name,
  d.display_name,
  d.enabled,
  COUNT(s.session_id) AS launch_window_sessions
FROM displays d
LEFT JOIN user_sessions s
    ON s.session_start >= d.created
    AND s.session_start < DATE(d.created, '+30 days')
GROUP BY 
  d.flag_name,
  d.display_name,
  d.enabled,
  d.created
ORDER BY flag_name ASC;
