USE product_sales_analytics;

-- ============================================
-- PRODUCT SALES & REVENUE ANALYTICS
-- SALES REPORT
-- ============================================


-- 1. Total Number of Orders
SELECT
    COUNT(*) AS total_orders
FROM orders;


-- 2. Total Delivered Orders
SELECT
    COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'Delivered';


-- 3. Total Cancelled Orders
SELECT
    COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';


-- 4. Total Units Sold
SELECT
    SUM(quantity) AS total_units_sold
FROM order_items;


-- 5. Total Sales Revenue
SELECT
    SUM(quantity * unit_price) AS total_sales_revenue
FROM order_items;


-- 6. Average Order Value
SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM
(
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS order_summary;


-- 7. Sales by Order
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    SUM(oi.quantity) AS total_items,
    SUM(oi.quantity * oi.unit_price) AS order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.order_date,
    o.order_status
ORDER BY order_value DESC;


-- 8. Daily Sales
SELECT
    o.order_date,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_date
ORDER BY o.order_date;


-- 9. State-wise Sales
SELECT
    o.shipping_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.shipping_state
ORDER BY revenue DESC;


-- 10. Payment Method Sales
SELECT
    o.payment_method,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.payment_method
ORDER BY revenue DESC;


-- 11. Customer-wise Sales
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS units_purchased,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spending DESC;


-- 12. Monthly Sales
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
