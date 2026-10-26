SELECT 
  u.username,
  COUNT(t.transaction_id) AS transactions
FROM users as u
LEFT JOIN transactions as t ON u.user_id = t.user_id
GROUP BY u.username
ORDER BY u.username ASC;
