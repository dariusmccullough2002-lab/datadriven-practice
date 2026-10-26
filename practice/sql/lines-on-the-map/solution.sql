SELECT 
  COUNT(order_id) AS order_count,
  region,
  SUM(profit) AS total_profit
FROM orders
WHERE region IS NOT NULL
GROUP BY region
HAVING AVG(profit) > 740;
