USE supermarket_sales;

-- 1. Revenue by product line
SELECT
    product_line,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY product_line
ORDER BY revenue DESC;


-- 2. Quantity sold by product line
SELECT
    product_line,
    SUM(quantity) AS quantity_sold
FROM sales
GROUP BY product_line
ORDER BY quantity_sold DESC;


-- 3. Transactions by product line
SELECT
    product_line,
    COUNT(*) AS transactions
FROM sales
GROUP BY product_line
ORDER BY transactions DESC;


-- 4. Average unit price
SELECT
    product_line,
    ROUND(AVG(unit_price),2) AS average_unit_price
FROM sales
GROUP BY product_line;


-- 5. Average rating
SELECT
    product_line,
    ROUND(AVG(rating),2) AS average_rating
FROM sales
GROUP BY product_line
ORDER BY average_rating DESC;


-- 6. Gross income by product line
SELECT
    product_line,
    ROUND(SUM(gross_income),2) AS gross_income
FROM sales
GROUP BY product_line
ORDER BY gross_income DESC;


-- 7. Highest revenue product line
SELECT
    product_line,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY product_line
ORDER BY revenue DESC
LIMIT 1;


-- 8. Lowest revenue product line
SELECT
    product_line,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY product_line
ORDER BY revenue
LIMIT 1;


-- 9. Product line and payment method
SELECT
    product_line,
    payment_method,
    COUNT(*) AS transactions
FROM sales
GROUP BY product_line, payment_method
ORDER BY product_line, transactions DESC;


-- 10. Product line and customer type
SELECT
    product_line,
    customer_type,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY product_line, customer_type
ORDER BY product_line, revenue DESC;


-- 11. Product line with rating above 8
SELECT
    product_line,
    ROUND(AVG(rating),2) AS average_rating
FROM sales
GROUP BY product_line
HAVING AVG(rating) > 8;


-- 12. Product lines selling more than 30 units
SELECT
    product_line,
    SUM(quantity) AS quantity_sold
FROM sales
GROUP BY product_line
HAVING SUM(quantity) > 30;


-- 13. Product line revenue and quantity
SELECT
    product_line,
    SUM(quantity) AS quantity_sold,
    ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY product_line
ORDER BY revenue DESC;
