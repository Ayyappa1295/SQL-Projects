USE supermarket_sales;

-- 1. Display all records
SELECT *
FROM sales;

-- 2. Display invoice ID and total
SELECT invoice_id, total
FROM sales;

-- 3. Unique branches
SELECT DISTINCT branch
FROM sales;

-- 4. Unique cities
SELECT DISTINCT city
FROM sales;

-- 5. Unique customer types
SELECT DISTINCT customer_type
FROM sales;

-- 6. Unique product lines
SELECT DISTINCT product_line
FROM sales;

-- 7. Unique payment methods
SELECT DISTINCT payment_method
FROM sales;

-- 8. Total number of transactions
SELECT COUNT(*) AS total_transactions
FROM sales;

-- 9. Total quantity sold
SELECT SUM(quantity) AS total_quantity
FROM sales;

-- 10. Total revenue
SELECT ROUND(SUM(total),2) AS total_revenue
FROM sales;

-- 11. Average transaction value
SELECT ROUND(AVG(total),2) AS average_transaction
FROM sales;

-- 12. Highest transaction
SELECT MAX(total) AS highest_transaction
FROM sales;

-- 13. Lowest transaction
SELECT MIN(total) AS lowest_transaction
FROM sales;

-- 14. Total gross income
SELECT ROUND(SUM(gross_income),2) AS total_gross_income
FROM sales;

-- 15. Average customer rating
SELECT ROUND(AVG(rating),2) AS average_rating
FROM sales;
