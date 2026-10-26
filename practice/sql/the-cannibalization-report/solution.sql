WITH launch_dates AS (
  SELECT 
    p.product_id,
    p.product_name,
    p.category,
    MIN(CAST(t.transaction_date AS DATE)) AS launch_date
  FROM products as p
  INNER JOIN transactions as t ON p.product_id = t.product_id
  GROUP BY p.product_id, p.product_name,p.category
),
category_sales AS(
  SELECT
        l.product_id,
        l.product_name,
        l.category,
        l.launch_date,
        SUM(
            CASE
                WHEN CAST(t.transaction_date AS DATE) >= l.launch_date - INTERVAL '30 days'
                 AND CAST(t.transaction_date AS DATE) < l.launch_date
                THEN t.total_amount
                ELSE 0
            END
        ) AS pre_entry_sales,

        SUM(
            CASE
                WHEN CAST(t.transaction_date AS DATE) >= l.launch_date
                 AND CAST(t.transaction_date AS DATE) < l.launch_date + INTERVAL '30 days'
                THEN t.total_amount
                ELSE 0
            END
        ) AS post_entry_sales

    FROM launch_dates AS l

    INNER JOIN products AS p
        ON l.category = p.category

    INNER JOIN transactions AS t
        ON p.product_id = t.product_id

    WHERE l.launch_date BETWEEN
        CURRENT_DATE - INTERVAL '9 months'
        AND CURRENT_DATE

    GROUP BY
        l.product_id,
        l.product_name,
        l.category,
        l.launch_date
)
SELECT
    product_name,
    category,
    pre_entry_sales,
    post_entry_sales,
    ROUND(CASE
        WHEN pre_entry_sales = 0 THEN 100
        ELSE (post_entry_sales - pre_entry_sales)
             * 100.0 / pre_entry_sales
    END, 2) AS pct_change
FROM category_sales;
