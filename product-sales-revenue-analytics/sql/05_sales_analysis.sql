USE product_sales_analytics;

-- Total Sales Quantity
SELECT
    SUM(quantity) AS total_units_sold
FROM order_items;


-- Total Orders
SELECT
    COUNT(*) AS total_orders
FROM orders;


-- Delivered Orders
SELECT
    COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'Delivered';


-- Cancelled Orders
SELECT
    COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';


-- Sales by Order
SELECT
    o.order_id,
    SUM(oi.quantity) AS total_items,
    SUM(oi.quantity * oi.unit_price) AS order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY order_value DESC;


-- Average Order Value
SELECT
    AVG(order_value) AS average_order_value
FROM
(
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_value
    FROM order_items
    GROUP BY order_id
) AS sales;
