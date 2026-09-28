USE supermarket_sales;

-- 1. Revenue by customer type
SELECT
    customer_type,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;


-- 2. Transactions by customer type
SELECT
    customer_type,
    COUNT(*) AS transactions
FROM sales
GROUP BY customer_type;


-- 3. Average spending by customer type
SELECT
    customer_type,
    ROUND(AVG(total),2) AS average_spending
FROM sales
GROUP BY customer_type;


-- 4. Quantity purchased by customer type
SELECT
    customer_type,
    SUM(quantity) AS quantity_purchased
FROM sales
GROUP BY customer_type;


-- 5. Revenue by gender
SELECT
    gender,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY gender
ORDER BY revenue DESC;


-- 6. Transactions by gender
SELECT
    gender,
    COUNT(*) AS transactions
FROM sales
GROUP BY gender;


-- 7. Average spending by gender
SELECT
    gender,
    ROUND(AVG(total),2) AS average_spending
FROM sales
GROUP BY gender;


-- 8. Member customers with high-value purchases
SELECT *
FROM sales
WHERE customer_type = 'Member'
AND total > 500
ORDER BY total DESC;


-- 9. Female customer revenue
SELECT
    ROUND(SUM(total),2) AS female_revenue
FROM sales
WHERE gender = 'Female';


-- 10. Male customer revenue
SELECT
    ROUND(SUM(total),2) AS male_revenue
FROM sales
WHERE gender = 'Male';


-- 11. Customer type and product analysis
SELECT
    customer_type,
    product_line,
    COUNT(*) AS transactions,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY customer_type, product_line
ORDER BY customer_type, revenue DESC;


-- 12. Gender and product analysis
SELECT
    gender,
    product_line,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY gender, product_line
ORDER BY gender, revenue DESC;


-- 13. Customers spending above average
SELECT *
FROM sales
WHERE total > (
    SELECT AVG(total)
    FROM sales
)
ORDER BY total DESC;


-- 14. Highest spending customer transactions
SELECT
    invoice_id,
    customer_type,
    gender,
    total
FROM sales
ORDER BY total DESC
LIMIT 10;


-- 15. Customer rating by customer type
SELECT
    customer_type,
    ROUND(AVG(rating),2) AS average_rating
FROM sales
GROUP BY customer_type;
