USE product_sales_analytics;

-- 1. Total Revenue
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM order_items;


-- 2. Total Units Sold
SELECT
    SUM(quantity) AS total_units_sold
FROM order_items;


-- 3. Top Revenue Product
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 1;


-- 4. Top Selling Product by Quantity
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 1;


-- 5. Best Revenue Category
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 1;


-- 6. Highest Spending Customer
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY spending DESC
LIMIT 1;


-- 7. Most Used Payment Method
SELECT
    payment_method,
    COUNT(*) AS usage_count
FROM orders
GROUP BY payment_method
ORDER BY usage_count DESC
LIMIT 1;


-- 8. Order Status Summary
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;
