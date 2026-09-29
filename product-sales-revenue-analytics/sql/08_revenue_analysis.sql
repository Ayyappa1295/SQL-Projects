USE product_sales_analytics;

-- Total Revenue
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM order_items;


-- Monthly Revenue
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;


-- State-wise Revenue
SELECT
    o.shipping_state,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.shipping_state
ORDER BY revenue DESC;


-- Payment Method Revenue
SELECT
    o.payment_method,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.payment_method
ORDER BY revenue DESC;


-- Category-wise Revenue Percentage
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    ROUND(
        SUM(oi.quantity * oi.unit_price) * 100 /
        (SELECT SUM(quantity * unit_price)
         FROM order_items), 2
    ) AS revenue_percentage
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category;
