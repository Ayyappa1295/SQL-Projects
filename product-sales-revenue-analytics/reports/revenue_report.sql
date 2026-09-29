USE product_sales_analytics;

-- ============================================
-- PRODUCT SALES & REVENUE ANALYTICS
-- REVENUE REPORT
-- ============================================


-- 1. Total Revenue
SELECT
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM order_items;


-- 2. Revenue by Month
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;


-- 3. Revenue by Category
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- 4. Revenue by Brand
SELECT
    p.brand,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.brand
ORDER BY revenue DESC;


-- 5. Revenue by State
SELECT
    o.shipping_state,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.shipping_state
ORDER BY revenue DESC;


-- 6. Revenue by Payment Method
SELECT
    o.payment_method,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.payment_method
ORDER BY revenue DESC;


-- 7. Revenue Percentage by Category
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,

    ROUND(
        SUM(oi.quantity * oi.unit_price) * 100 /
        (
            SELECT SUM(quantity * unit_price)
            FROM order_items
        ),
        2
    ) AS revenue_percentage

FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY p.category
ORDER BY revenue DESC;


-- 8. Highest Revenue Product
SELECT
    p.product_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 1;


-- 9. Highest Revenue Customer
SELECT
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 1;


-- 10. Revenue by Order Status
SELECT
    o.order_status,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY revenue DESC;


-- 11. Revenue Ranking of Products
SELECT
    product_name,
    revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM
(
    SELECT
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_name
) AS product_revenue;


-- 12. Cumulative Revenue by Month
SELECT
    month,
    revenue,

    SUM(revenue) OVER (
        ORDER BY month
    ) AS cumulative_revenue

FROM
(
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY month
) AS monthly_revenue;
