USE product_sales_analytics;

-- ============================================
-- PRODUCT SALES & REVENUE ANALYTICS
-- PRODUCT PERFORMANCE REPORT
-- ============================================


-- 1. Product-wise Sales Quantity
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.brand
ORDER BY units_sold DESC;


-- 2. Product-wise Revenue
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY revenue DESC;


-- 3. Product Profit
SELECT
    p.product_name,

    SUM(oi.quantity) AS units_sold,

    SUM(
        oi.quantity *
        (oi.unit_price - p.cost_price)
    ) AS estimated_profit

FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY p.product_name
ORDER BY estimated_profit DESC;


-- 4. Product Profit Margin
SELECT
    p.product_name,

    ROUND(
        (
            SUM(
                oi.quantity *
                (oi.unit_price - p.cost_price)
            )
            /
            SUM(oi.quantity * oi.unit_price)
        ) * 100,
        2
    ) AS profit_margin_percentage

FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY p.product_name

ORDER BY profit_margin_percentage DESC;


-- 5. Top 5 Products by Revenue
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;


-- 6. Top 5 Products by Quantity Sold
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 5;


-- 7. Category-wise Product Performance
SELECT
    p.category,

    COUNT(DISTINCT p.product_id) AS number_of_products,

    SUM(oi.quantity) AS units_sold,

    SUM(oi.quantity * oi.unit_price) AS revenue

FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY p.category

ORDER BY revenue DESC;


-- 8. Brand-wise Product Performance
SELECT
    p.brand,

    COUNT(DISTINCT p.product_id) AS number_of_products,

    SUM(oi.quantity) AS units_sold,

    SUM(oi.quantity * oi.unit_price) AS revenue

FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY p.brand

ORDER BY revenue DESC;


-- 9. Best Product in Each Category
SELECT
    category,
    product_name,
    revenue,
    category_rank

FROM
(
    SELECT
        p.category,
        p.product_name,

        SUM(
            oi.quantity * oi.unit_price
        ) AS revenue,

        RANK() OVER (
            PARTITION BY p.category
            ORDER BY
                SUM(
                    oi.quantity * oi.unit_price
                ) DESC
        ) AS category_rank

    FROM products p

    JOIN order_items oi
        ON p.product_id = oi.product_id

    GROUP BY
        p.category,
        p.product_name
) AS ranked_products

WHERE category_rank = 1;


-- 10. Low Stock Products
SELECT
    product_id,
    product_name,
    category,
    stock_quantity
FROM products
WHERE stock_quantity < 100
ORDER BY stock_quantity ASC;


-- 11. High Revenue Products
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
HAVING revenue > 50000
ORDER BY revenue DESC;


-- 12. Product Performance Summary
SELECT
    p.product_name,
    p.category,
    p.brand,

    SUM(oi.quantity) AS units_sold,

    SUM(
        oi.quantity * oi.unit_price
    ) AS revenue,

    SUM(
        oi.quantity *
        (oi.unit_price - p.cost_price)
    ) AS estimated_profit

FROM products p

JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY
    p.product_name,
    p.category,
    p.brand

ORDER BY revenue DESC;
