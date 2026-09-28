USE supermarket_sales;

-- 1. Rank transactions by revenue
SELECT
    invoice_id,
    branch,
    total,
    RANK() OVER (ORDER BY total DESC) AS revenue_rank
FROM sales;


-- 2. Rank product lines by revenue
SELECT
    product_line,
    ROUND(SUM(total),2) AS revenue,
    RANK() OVER (ORDER BY SUM(total) DESC) AS revenue_rank
FROM sales
GROUP BY product_line;


-- 3. Rank branches by revenue
SELECT
    branch,
    ROUND(SUM(total),2) AS revenue,
    RANK() OVER (ORDER BY SUM(total) DESC) AS branch_rank
FROM sales
GROUP BY branch;


-- 4. Running revenue
SELECT
    sale_date,
    total,
    SUM(total) OVER (
        ORDER BY sale_date, sale_time
    ) AS running_revenue
FROM sales;


-- 5. Overall average transaction
SELECT
    invoice_id,
    total,
    ROUND(AVG(total) OVER (),2) AS overall_average
FROM sales;


-- 6. Difference from average
SELECT
    invoice_id,
    total,
    ROUND(
        total - AVG(total) OVER (),
        2
    ) AS difference_from_average
FROM sales;


-- 7. Product revenue percentage
SELECT
    product_line,
    ROUND(SUM(total),2) AS revenue,
    ROUND(
        SUM(total) * 100 /
        SUM(SUM(total)) OVER (),
        2
    ) AS revenue_percentage
FROM sales
GROUP BY product_line;


-- 8. Branch revenue percentage
SELECT
    branch,
    ROUND(SUM(total),2) AS revenue,
    ROUND(
        SUM(total) * 100 /
        SUM(SUM(total)) OVER (),
        2
    ) AS revenue_percentage
FROM sales
GROUP BY branch;


-- 9. High-value sales using CTE
WITH high_value_sales AS (
    SELECT *
    FROM sales
    WHERE total > 500
)
SELECT
    branch,
    COUNT(*) AS high_value_transactions,
    ROUND(SUM(total),2) AS revenue
FROM high_value_sales
GROUP BY branch
ORDER BY revenue DESC;


-- 10. Product sales using CTE
WITH product_sales AS (
    SELECT
        product_line,
        SUM(total) AS revenue
    FROM sales
    GROUP BY product_line
)
SELECT
    product_line,
    ROUND(revenue,2) AS revenue
FROM product_sales
ORDER BY revenue DESC;


-- 11. Top 3 product lines
WITH product_sales AS (
    SELECT
        product_line,
        SUM(total) AS revenue
    FROM sales
    GROUP BY product_line
)
SELECT
    product_line,
    ROUND(revenue,2) AS revenue
FROM product_sales
ORDER BY revenue DESC
LIMIT 3;


-- 12. Top 5 transactions using window function
WITH ranked_sales AS (
    SELECT
        invoice_id,
        branch,
        product_line,
        total,
        RANK() OVER (ORDER BY total DESC) AS sales_rank
    FROM sales
)
SELECT *
FROM ranked_sales
WHERE sales_rank <= 5;


-- 13. Sales by hour
SELECT
    HOUR(sale_time) AS sale_hour,
    COUNT(*) AS transactions,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY HOUR(sale_time)
ORDER BY revenue DESC;


-- 14. Weekend vs weekday
SELECT
    CASE
        WHEN DAYOFWEEK(sale_date) IN (1,7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS transactions,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY day_type;


-- 15. High-rated transactions
SELECT *
FROM sales
WHERE rating >= 9
ORDER BY rating DESC;


-- 16. Low-rated transactions
SELECT *
FROM sales
WHERE rating < 6
ORDER BY rating;


-- 17. Revenue by month
SELECT
    DATE_FORMAT(sale_date,'%Y-%m') AS sales_month,
    ROUND(SUM(total),2) AS monthly_revenue
FROM sales
GROUP BY DATE_FORMAT(sale_date,'%Y-%m')
ORDER BY sales_month;


-- 18. Average quantity per transaction
SELECT
    ROUND(AVG(quantity),2) AS average_quantity
FROM sales;


-- 19. Transactions with quantity above average
SELECT *
FROM sales
WHERE quantity > (
    SELECT AVG(quantity)
    FROM sales
)
ORDER BY quantity DESC;


-- 20. Product lines with revenue above average
WITH product_sales AS (
    SELECT
        product_line,
        SUM(total) AS revenue
    FROM sales
    GROUP BY product_line
)
SELECT
    product_line,
    ROUND(revenue,2) AS revenue
FROM product_sales
WHERE revenue > (
    SELECT AVG(revenue)
    FROM product_sales
)
ORDER BY revenue DESC;
