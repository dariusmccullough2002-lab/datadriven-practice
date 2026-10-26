SELECT
  CAST(transaction_date AS DATE) AS transaction_day,
  SUM(total_amount) AS net_revenue
FROM transactions 
WHERE
  (total_amount > 0 
  AND CAST(transaction_date AS DATE) BETWEEN '2026-04-01' AND '2026-06-30'
  ) 
  OR total_amount < 0
GROUP BY CAST(transaction_date AS DATE)
ORDER BY transaction_day ASC;
