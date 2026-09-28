USE supermarket_sales;

-- ==========================================
-- CUSTOMER ANALYSIS REPORT
-- ==========================================

-- 1. Customer Type Summary
SELECT
    customer_type,
    COUNT(*) AS transactions,
    SUM(quantity) AS items_purchased,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(AVG(total), 2) AS average_spending,
    ROUND(AVG(rating), 2) AS average_rating
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;


-- 2. Gender Analysis
SELECT
    gender,
    COUNT(*) AS transactions,
    SUM(quantity) AS items_purchased,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(AVG(total), 2) AS average_spending,
    ROUND(AVG(rating), 2) AS average_rating
FROM sales
GROUP BY gender
ORDER BY revenue DESC;


-- 3. Customer Type + Gender
SELECT
    customer_type,
    gender,
    COUNT(*) AS transactions,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(AVG(total), 2) AS average_spending
FROM sales
GROUP BY customer_type, gender
ORDER BY customer_type, revenue DESC;


-- 4. Customer Type + Product Line
SELECT
    customer_type,
    product_line,
    COUNT(*) AS transactions,
    ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY customer_type, product_line
ORDER BY customer_type, revenue DESC;


-- 5. High Value Transactions
SELECT
    invoice_id,
    customer_type,
    gender,
    product_line,
    total
FROM sales
WHERE total > 500
ORDER BY total DESC;


-- 6. Customers Above Average Spending
SELECT
    invoice_id,
    customer_type,
    gender,
    total
FROM sales
WHERE total > (
    SELECT AVG(total)
    FROM sales
)
ORDER BY total DESC;


-- 7. Customer Rating Analysis
SELECT
    customer_type,
    ROUND(AVG(rating), 2) AS average_rating,
    MIN(rating) AS lowest_rating,
    MAX(rating) AS highest_rating
FROM sales
GROUP BY customer_type;


-- 8. Gender-wise Product Analysis
SELECT
    gender,
    product_line,
    COUNT(*) AS transactions,
    ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY gender, product_line
ORDER BY gender, revenue DESC;
