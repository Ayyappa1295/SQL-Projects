USE amazon_ecommerce_sales;

-- =========================================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- PAYMENT ANALYSIS
-- =========================================================


-- 1. Display all payment methods
SELECT DISTINCT
    payment_method
FROM amazon_sales
ORDER BY payment_method;


-- 2. Number of orders by payment method
SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders
FROM amazon_sales
GROUP BY payment_method
ORDER BY total_orders DESC;


-- 3. Total units purchased by payment method
SELECT
    payment_method,
    SUM(quantity) AS total_units
FROM amazon_sales
GROUP BY payment_method
ORDER BY total_units DESC;


-- 4. Gross sales by payment method
SELECT
    payment_method,
    ROUND(
        SUM(quantity * unit_price),
        2
    ) AS gross_sales
FROM amazon_sales
GROUP BY payment_method
ORDER BY gross_sales DESC;


-- 5. Total discount by payment method
SELECT
    payment_method,
    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS total_discount
FROM amazon_sales
GROUP BY payment_method
ORDER BY total_discount DESC;


-- 6. Net revenue by payment method
SELECT
    payment_method,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS net_revenue
FROM amazon_sales
GROUP BY payment_method
ORDER BY net_revenue DESC;


-- 7. Average order value by payment method
SELECT
    payment_method,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        )
        /
        COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM amazon_sales
GROUP BY payment_method
ORDER BY average_order_value DESC;


-- 8. Payment method percentage of total orders
SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        COUNT(DISTINCT order_id)
        /
        (
            SELECT COUNT(DISTINCT order_id)
            FROM amazon_sales
        ) * 100,
        2
    ) AS order_percentage

FROM amazon_sales

GROUP BY payment_method

ORDER BY order_percentage DESC;


-- 9. Payment method percentage of total revenue
SELECT
    payment_method,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        )
        /
        (
            SELECT
                SUM(
                    (quantity * unit_price)
                    - ((quantity * unit_price) * discount / 100)
                )
            FROM amazon_sales
        ) * 100,
        2
    ) AS revenue_percentage

FROM amazon_sales

GROUP BY payment_method

ORDER BY revenue_percentage DESC;


-- 10. Payment method by city
SELECT
    customer_city,
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY
    customer_city,
    payment_method

ORDER BY
    customer_city,
    revenue DESC;


-- 11. Payment method by category
SELECT
    category,
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY
    category,
    payment_method

ORDER BY
    category,
    revenue DESC;


-- 12. Payment method by month
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY
    DATE_FORMAT(order_date, '%Y-%m'),
    payment_method

ORDER BY
    sales_month,
    revenue DESC;


-- 13. Average discount by payment method
SELECT
    payment_method,
    ROUND(
        AVG(discount),
        2
    ) AS average_discount
FROM amazon_sales
GROUP BY payment_method
ORDER BY average_discount DESC;


-- 14. Average rating by payment method
SELECT
    payment_method,
    ROUND(
        AVG(rating),
        2
    ) AS average_rating
FROM amazon_sales
GROUP BY payment_method
ORDER BY average_rating DESC;


-- 15. Customers using each payment method
SELECT
    payment_method,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM amazon_sales
GROUP BY payment_method
ORDER BY unique_customers DESC;


-- 16. Customers using multiple payment methods
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT payment_method) AS payment_methods_used
FROM amazon_sales
GROUP BY
    customer_id,
    customer_name
HAVING COUNT(DISTINCT payment_method) > 1
ORDER BY payment_methods_used DESC;


-- 17. Payment method with orders above ₹5,000
SELECT
    payment_method,
    COUNT(*) AS high_value_orders
FROM amazon_sales
WHERE
    (
        (quantity * unit_price)
        - ((quantity * unit_price) * discount / 100)
    ) > 5000
GROUP BY payment_method
ORDER BY high_value_orders DESC;


-- 18. Payment method with discounted orders
SELECT
    payment_method,
    COUNT(*) AS discounted_orders,

    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS discount_amount

FROM amazon_sales

WHERE discount > 0

GROUP BY payment_method

ORDER BY discount_amount DESC;


-- 19. Highest revenue payment method
SELECT
    payment_method,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY payment_method

ORDER BY revenue DESC

LIMIT 1;


-- 20. Lowest revenue payment method
SELECT
    payment_method,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY payment_method

ORDER BY revenue ASC

LIMIT 1;


-- 21. Payment method classification
SELECT
    payment_method,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue,

    CASE
        WHEN COUNT(DISTINCT order_id) >= 15
            THEN 'High Usage'

        WHEN COUNT(DISTINCT order_id) >= 8
            THEN 'Medium Usage'

        ELSE 'Low Usage'
    END AS usage_category

FROM amazon_sales

GROUP BY payment_method

ORDER BY total_orders DESC;


-- 22. Payment method and order status
SELECT
    payment_method,
    order_status,
    COUNT(DISTINCT order_id) AS total_orders
FROM amazon_sales
GROUP BY
    payment_method,
    order_status
ORDER BY
    payment_method,
    total_orders DESC;


-- 23. Payment method and product category percentage
SELECT
    category,
    payment_method,
    COUNT(DISTINCT order_id) AS orders,

    ROUND(
        COUNT(DISTINCT order_id)
        /
        SUM(COUNT(DISTINCT order_id))
        OVER (PARTITION BY category) * 100,
        2
    ) AS category_payment_percentage

FROM amazon_sales

GROUP BY
    category,
    payment_method

ORDER BY
    category,
    category_payment_percentage DESC;


-- 24. Payment method revenue ranking
SELECT
    payment_method,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue,

    RANK() OVER (
        ORDER BY
            SUM(
                (quantity * unit_price)
                - ((quantity * unit_price) * discount / 100)
            ) DESC
    ) AS revenue_rank

FROM amazon_sales

GROUP BY payment_method;


-- 25. Complete payment performance report
SELECT
    payment_method,

    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT customer_id) AS unique_customers,

    SUM(quantity) AS total_units,

    ROUND(
        SUM(quantity * unit_price),
        2
    ) AS gross_sales,

    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS total_discount,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS net_revenue,

    ROUND(
        AVG(discount),
        2
    ) AS average_discount,

    ROUND(
        AVG(rating),
        2
    ) AS average_rating

FROM amazon_sales

GROUP BY payment_method

ORDER BY net_revenue DESC;
