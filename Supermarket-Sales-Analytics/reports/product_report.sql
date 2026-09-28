USE supermarket_sales;

-- ==========================================
-- PRODUCT PERFORMANCE REPORT
-- ==========================================

-- 1. Product Line Summary
SELECT
    product_line,
    COUNT(*) AS transactions,
    SUM(quantity) AS quantity_sold,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(AVG(unit_price), 2) AS average_unit_price,
    ROUND(SUM(gross_income), 2) AS gross_income,
    ROUND(AVG(rating), 2) AS average_rating
FROM sales
GROUP BY product_line
ORDER BY revenue DESC;


-- 2. Product Line Ranking
SELECT
    product_line,
    ROUND(SUM(total), 2) AS revenue,
    RANK() OVER (
        ORDER BY SUM(total) DESC
    ) AS revenue_rank
FROM sales
GROUP BY product_line;


-- 3. Product Quantity Ranking
SELECT
    product_line,
    SUM(quantity) AS quantity_sold,
    RANK() OVER (
        ORDER BY SUM(quantity) DESC
    ) AS quantity_rank
FROM sales
GROUP BY product_line;


-- 4. Product Line by Branch
SELECT
    branch,
    product_line,
    SUM(quantity) AS quantity_sold,
    ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY branch, product_line
ORDER BY branch, revenue DESC;


-- 5. Product Line by Payment Method
SELECT
    product_line,
    payment_method,
    COUNT(*) AS transactions,
    ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY product_line, payment_method
ORDER BY product_line, revenue DESC;


-- 6. Product Line by Customer Type
SELECT
    product_line,
    customer_type,
    COUNT(*) AS transactions,
    ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY product_line, customer_type
ORDER BY product_line, revenue DESC;


-- 7. Highest Revenue Product Line
SELECT
    product_line,
    ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY product_line
ORDER BY revenue DESC
LIMIT 1;


-- 8. Lowest Revenue Product Line
SELECT
    product_line,
    ROUND(SUM(total), 2) AS revenue
FROM sales
GROUP BY product_line
ORDER BY revenue
LIMIT 1;


-- 9. Highest Rated Product Line
SELECT
    product_line,
    ROUND(AVG(rating), 2) AS average_rating
FROM sales
GROUP BY product_line
ORDER BY average_rating DESC
LIMIT 1;


-- 10. Product Revenue Contribution
SELECT
    product_line,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(
        SUM(total) * 100 /
        SUM(SUM(total)) OVER (),
        2
    ) AS revenue_percentage
FROM sales
GROUP BY product_line
ORDER BY revenue DESC;
