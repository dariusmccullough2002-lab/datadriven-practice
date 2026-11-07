SELECT 
  query_id,
  CASE 
  WHEN clicked_result IN (1,2,3) THEN 3 
  WHEN clicked_result > 3 THEN 2 
  ELSE 1 END AS rating
FROM search_queries
GROUP BY query_id;
