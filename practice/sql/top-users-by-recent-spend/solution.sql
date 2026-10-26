WITH recent_transactions AS (
  SELECT
    transaction_id,
    user_id,
    CAST(transaction_date AS DATE) AS t_date,
    total_amount
  FROM transactions
  WHERE CAST(transaction_date AS DATE) BETWEEN CURRENT_DATE - INTERVAL '30 days' AND CURRENT_DATE
)
SELECT 
  user_id,
  COUNT(transaction_id) AS purchases,
  AVG(total_amount) AS avg_spend
FROM recent_transactions
GROUP BY user_id
HAVING COUNT(transaction_id) > 1 
ORDER BY avg_spend DESC
LIMIT 3;
