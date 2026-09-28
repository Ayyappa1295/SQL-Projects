USE supermarket_sales;

-- 1. Revenue by branch
SELECT
    branch,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY branch
ORDER BY revenue DESC;


-- 2. Revenue by city
SELECT
    city,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;


-- 3. Quantity sold by branch
SELECT
    branch,
    SUM(quantity) AS quantity_sold
FROM sales
GROUP BY branch
ORDER BY quantity_sold DESC;


-- 4. Average transaction by branch
SELECT
    branch,
    ROUND(AVG(total),2) AS average_transaction
FROM sales
GROUP BY branch;


-- 5. Gross income by branch
SELECT
    branch,
    ROUND(SUM(gross_income),2) AS gross_income
FROM sales
GROUP BY branch
ORDER BY gross_income DESC;


-- 6. Revenue by payment method
SELECT
    payment_method,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY payment_method
ORDER BY revenue DESC;


-- 7. Transactions by payment method
SELECT
    payment_method,
    COUNT(*) AS transactions
FROM sales
GROUP BY payment_method
ORDER BY transactions DESC;


-- 8. Daily revenue
SELECT
    sale_date,
    ROUND(SUM(total),2) AS daily_revenue
FROM sales
GROUP BY sale_date
ORDER BY sale_date;


-- 9. Highest transaction
SELECT *
FROM sales
ORDER BY total DESC
LIMIT 1;


-- 10. Top 5 transactions
SELECT
    invoice_id,
    branch,
    product_line,
    total
FROM sales
ORDER BY total DESC
LIMIT 5;


-- 11. Transactions above average
SELECT *
FROM sales
WHERE total > (
    SELECT AVG(total)
    FROM sales
)
ORDER BY total DESC;


-- 12. Transactions below average
SELECT *
FROM sales
WHERE total < (
    SELECT AVG(total)
    FROM sales
)
ORDER BY total;


-- 13. Revenue by month
SELECT
    MONTH(sale_date) AS month_number,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY MONTH(sale_date)
ORDER BY month_number;


-- 14. Sales by hour
SELECT
    HOUR(sale_time) AS sale_hour,
    COUNT(*) AS transactions,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY HOUR(sale_time)
ORDER BY revenue DESC;


-- 15. Weekend vs weekday sales
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
