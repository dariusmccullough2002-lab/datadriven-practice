SELECT 
  user_id,
  SUM(total_amount) AS march_total
FROM transactions
WHERE EXTRACT(MONTH FROM CAST(transaction_date AS DATE)) = 3
GROUP BY user_id
ORDER BY march_total DESC;
