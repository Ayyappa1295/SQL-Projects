USE supermarket_sales;

-- 1. Branch revenue
SELECT
    branch,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY branch
ORDER BY revenue DESC;


-- 2. Branch quantity sold
SELECT
    branch,
    SUM(quantity) AS quantity_sold
FROM sales
GROUP BY branch
ORDER BY quantity_sold DESC;


-- 3. Branch average transaction
SELECT
    branch,
    ROUND(AVG(total),2) AS average_transaction
FROM sales
GROUP BY branch;


-- 4. Branch gross income
SELECT
    branch,
    ROUND(SUM(gross_income),2) AS gross_income
FROM sales
GROUP BY branch
ORDER BY gross_income DESC;


-- 5. Branch average rating
SELECT
    branch,
    ROUND(AVG(rating),2) AS average_rating
FROM sales
GROUP BY branch
ORDER BY average_rating DESC;


-- 6. Branch payment method analysis
SELECT
    branch,
    payment_method,
    COUNT(*) AS transactions,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY branch, payment_method
ORDER BY branch, revenue DESC;


-- 7. Branch product performance
SELECT
    branch,
    product_line,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY branch, product_line
ORDER BY branch, revenue DESC;


-- 8. Branch customer analysis
SELECT
    branch,
    customer_type,
    COUNT(*) AS transactions,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY branch, customer_type
ORDER BY branch, revenue DESC;


-- 9. Branch gender analysis
SELECT
    branch,
    gender,
    COUNT(*) AS transactions,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY branch, gender
ORDER BY branch, revenue DESC;


-- 10. Branch with highest revenue
SELECT
    branch,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY branch
ORDER BY revenue DESC
LIMIT 1;
