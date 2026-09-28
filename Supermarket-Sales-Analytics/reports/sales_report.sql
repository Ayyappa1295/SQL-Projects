USE supermarket_sales;

-- ==========================================
-- SUPERMARKET SALES REPORT
-- ==========================================

-- 1. Overall Sales Summary
SELECT
    COUNT(*) AS total_transactions,
    SUM(quantity) AS total_items_sold,
    ROUND(SUM(total), 2) AS total_revenue,
    ROUND(AVG(total), 2) AS average_transaction,
    ROUND(SUM(gross_income), 2) AS total_gross_income,
    ROUND(AVG(rating), 2) AS average_customer_rating
FROM sales;


-- 2. Branch Performance Report
SELECT
    branch,
    COUNT(*) AS transactions,
    SUM(quantity) AS items_sold,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(AVG(total), 2) AS average_transaction,
    ROUND(SUM(gross_income), 2) AS gross_income,
    ROUND(AVG(rating), 2) AS average_rating
FROM sales
GROUP BY branch
ORDER BY revenue DESC;


-- 3. City Performance Report
SELECT
    city,
    COUNT(*) AS transactions,
    SUM(quantity) AS items_sold,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(SUM(gross_income), 2) AS gross_income
FROM sales
GROUP BY city
ORDER BY revenue DESC;


-- 4. Payment Method Report
SELECT
    payment_method,
    COUNT(*) AS transactions,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(AVG(total), 2) AS average_transaction
FROM sales
GROUP BY payment_method
ORDER BY revenue DESC;


-- 5. Daily Sales Report
SELECT
    sale_date,
    COUNT(*) AS transactions,
    SUM(quantity) AS items_sold,
    ROUND(SUM(total), 2) AS daily_revenue
FROM sales
GROUP BY sale_date
ORDER BY sale_date;


-- 6. Sales by Hour
SELECT
    HOUR(sale_time) AS sale_hour,
    COUNT(*) AS transactions,
    ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY HOUR(sale_time)
ORDER BY revenue DESC;


-- 7. Weekend vs Weekday Report
SELECT
    CASE
        WHEN DAYOFWEEK(sale_date) IN (1, 7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS transactions,
    SUM(quantity) AS items_sold,
    ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY day_type
ORDER BY revenue DESC;


-- 8. Top 10 Sales Transactions
SELECT
    invoice_id,
    branch,
    city,
    product_line,
    customer_type,
    payment_method,
    total
FROM sales
ORDER BY total DESC
LIMIT 10;
