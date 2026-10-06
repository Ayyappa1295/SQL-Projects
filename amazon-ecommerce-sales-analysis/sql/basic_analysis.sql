USE amazon_ecommerce_sales;

-- ============================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- BASIC ANALYSIS
-- ============================================


-- 1. Display all sales records
SELECT *
FROM amazon_sales;


-- 2. Count total orders
SELECT COUNT(*) AS total_orders
FROM amazon_sales;


-- 3. Count unique customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM amazon_sales;


-- 4. Count unique products
SELECT COUNT(DISTINCT product_id) AS total_products
FROM amazon_sales;


-- 5. Count product categories
SELECT COUNT(DISTINCT category) AS total_categories
FROM amazon_sales;


-- 6. Calculate total quantity sold
SELECT SUM(quantity) AS total_units_sold
FROM amazon_sales;


-- 7. Calculate total gross sales
SELECT
    ROUND(SUM(quantity * unit_price), 2) AS gross_sales
FROM amazon_sales;


-- 8. Calculate total discount amount
SELECT
    ROUND(
        SUM((quantity * unit_price) * discount / 100),
        2
    ) AS total_discount
FROM amazon_sales;


-- 9. Calculate total net revenue
SELECT
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_revenue
FROM amazon_sales;


-- 10. Calculate average order value
SELECT
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM amazon_sales;


-- 11. Find minimum product price
SELECT
    MIN(unit_price) AS minimum_price
FROM amazon_sales;


-- 12. Find maximum product price
SELECT
    MAX(unit_price) AS maximum_price
FROM amazon_sales;


-- 13. Find average product price
SELECT
    ROUND(AVG(unit_price), 2) AS average_product_price
FROM amazon_sales;


-- 14. Find average customer rating
SELECT
    ROUND(AVG(rating), 2) AS average_rating
FROM amazon_sales;


-- 15. Display all available payment methods
SELECT DISTINCT payment_method
FROM amazon_sales;


-- 16. Count orders by payment method
SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM amazon_sales
GROUP BY payment_method
ORDER BY total_orders DESC;


-- 17. Count orders by status
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM amazon_sales
GROUP BY order_status;


-- 18. Sales by city
SELECT
    customer_city,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_units,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_revenue
FROM amazon_sales
GROUP BY customer_city
ORDER BY total_revenue DESC;


-- 19. Sales by category
SELECT
    category,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY category
ORDER BY revenue DESC;


-- 20. Sales by month
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(*) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY sales_month;


-- 21. Top 10 products by revenue
SELECT
    product_name,
    category,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY product_id, product_name, category
ORDER BY revenue DESC
LIMIT 10;


-- 22. Top 10 customers by spending
SELECT
    customer_id,
    customer_name,
    COUNT(*) AS total_orders,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY total_spending DESC
LIMIT 10;


-- 23. Products with rating above 4.5
SELECT
    product_name,
    category,
    rating
FROM amazon_sales
WHERE rating > 4.5
ORDER BY rating DESC;


-- 24. Orders with discount greater than 10%
SELECT
    order_id,
    product_name,
    quantity,
    discount
FROM amazon_sales
WHERE discount > 10
ORDER BY discount DESC;


-- 25. Products where quantity sold is greater than 2
SELECT
    product_name,
    SUM(quantity) AS total_quantity
FROM amazon_sales
GROUP BY product_id, product_name
HAVING SUM(quantity) > 2
ORDER BY total_quantity DESC;
