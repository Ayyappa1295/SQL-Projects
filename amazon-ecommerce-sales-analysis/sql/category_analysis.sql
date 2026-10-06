USE amazon_ecommerce_sales;

-- =========================================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- CATEGORY ANALYSIS
-- =========================================================


-- 1. Display all categories
SELECT DISTINCT
    category
FROM amazon_sales
ORDER BY category;


-- 2. Total number of categories
SELECT
    COUNT(DISTINCT category) AS total_categories
FROM amazon_sales;


-- 3. Number of products in each category
SELECT
    category,
    COUNT(DISTINCT product_id) AS total_products
FROM amazon_sales
GROUP BY category
ORDER BY total_products DESC;


-- 4. Total orders by category
SELECT
    category,
    COUNT(DISTINCT order_id) AS total_orders
FROM amazon_sales
GROUP BY category
ORDER BY total_orders DESC;


-- 5. Total units sold by category
SELECT
    category,
    SUM(quantity) AS total_units_sold
FROM amazon_sales
GROUP BY category
ORDER BY total_units_sold DESC;


-- 6. Gross sales by category
SELECT
    category,
    ROUND(
        SUM(quantity * unit_price),
        2
    ) AS gross_sales
FROM amazon_sales
GROUP BY category
ORDER BY gross_sales DESC;


-- 7. Total discount by category
SELECT
    category,
    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS total_discount
FROM amazon_sales
GROUP BY category
ORDER BY total_discount DESC;


-- 8. Net revenue by category
SELECT
    category,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS net_revenue
FROM amazon_sales
GROUP BY category
ORDER BY net_revenue DESC;


-- 9. Average product price by category
SELECT
    category,
    ROUND(
        AVG(unit_price),
        2
    ) AS average_product_price
FROM amazon_sales
GROUP BY category
ORDER BY average_product_price DESC;


-- 10. Average discount by category
SELECT
    category,
    ROUND(
        AVG(discount),
        2
    ) AS average_discount
FROM amazon_sales
GROUP BY category
ORDER BY average_discount DESC;


-- 11. Average rating by category
SELECT
    category,
    ROUND(
        AVG(rating),
        2
    ) AS average_rating
FROM amazon_sales
GROUP BY category
ORDER BY average_rating DESC;


-- 12. Unique customers per category
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM amazon_sales
GROUP BY category
ORDER BY unique_customers DESC;


-- 13. Average order value by category
SELECT
    category,
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
GROUP BY category
ORDER BY average_order_value DESC;


-- 14. Category revenue contribution percentage
SELECT
    category,

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

GROUP BY category

ORDER BY revenue_percentage DESC;


-- 15. Category-wise sales by city
SELECT
    category,
    customer_city,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS units_sold,

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
    customer_city

ORDER BY
    category,
    revenue DESC;


-- 16. Best-selling product in each category
SELECT
    category,
    product_name,
    SUM(quantity) AS units_sold
FROM amazon_sales
GROUP BY
    category,
    product_id,
    product_name
ORDER BY
    category,
    units_sold DESC;


-- 17. Categories with revenue above ₹10,000
SELECT
    category,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY category

HAVING revenue > 10000

ORDER BY revenue DESC;


-- 18. Categories selling more than 10 units
SELECT
    category,
    SUM(quantity) AS units_sold
FROM amazon_sales
GROUP BY category
HAVING SUM(quantity) > 10
ORDER BY units_sold DESC;


-- 19. Categories with average rating above 4.3
SELECT
    category,
    ROUND(
        AVG(rating),
        2
    ) AS average_rating
FROM amazon_sales
GROUP BY category
HAVING AVG(rating) > 4.3
ORDER BY average_rating DESC;


-- 20. Category sales classification
SELECT
    category,

    SUM(quantity) AS units_sold,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue,

    CASE
        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 30000
            THEN 'High Revenue Category'

        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 15000
            THEN 'Medium Revenue Category'

        ELSE 'Low Revenue Category'
    END AS category_segment

FROM amazon_sales

GROUP BY category

ORDER BY revenue DESC;


-- 21. Monthly category revenue
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    category,

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
    category

ORDER BY
    sales_month,
    revenue DESC;


-- 22. Category payment method analysis
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


-- 23. Category customer spending
SELECT
    category,

    COUNT(DISTINCT customer_id) AS customers,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_customer_spending

FROM amazon_sales

GROUP BY category

ORDER BY total_customer_spending DESC;


-- 24. Category gross margin-style calculation
SELECT
    category,

    ROUND(
        SUM(quantity * unit_price),
        2
    ) AS gross_sales,

    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS discount_amount,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS net_sales,

    ROUND(
        (
            SUM(
                (quantity * unit_price)
                - ((quantity * unit_price) * discount / 100)
            )
            /
            SUM(quantity * unit_price)
        ) * 100,
        2
    ) AS net_sales_percentage

FROM amazon_sales

GROUP BY category

ORDER BY net_sales DESC;


-- 25. Complete category performance report
SELECT
    category,

    COUNT(DISTINCT product_id) AS products,

    COUNT(DISTINCT customer_id) AS customers,

    COUNT(DISTINCT order_id) AS orders,

    SUM(quantity) AS units_sold,

    ROUND(
        AVG(unit_price),
        2
    ) AS average_price,

    ROUND(
        AVG(discount),
        2
    ) AS average_discount,

    ROUND(
        AVG(rating),
        2
    ) AS average_rating,

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
