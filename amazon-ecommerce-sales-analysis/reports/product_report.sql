USE amazon_ecommerce_sales;

-- =========================================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- PRODUCT REPORT
-- =========================================================


-- 1. Overall Product Summary
SELECT
    COUNT(DISTINCT product_id) AS total_products,
    COUNT(DISTINCT category) AS total_categories,
    SUM(quantity) AS total_units_sold,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_revenue

FROM amazon_sales;


-- 2. Product Sales Performance
SELECT
    product_id,
    product_name,
    category,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS units_sold,

    ROUND(
        SUM(quantity * unit_price),
        2
    ) AS gross_sales,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS net_revenue

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

ORDER BY net_revenue DESC;


-- 3. Top 10 Products by Revenue
SELECT
    product_id,
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

GROUP BY
    product_id,
    product_name,
    category

ORDER BY revenue DESC

LIMIT 10;


-- 4. Top 10 Products by Units Sold
SELECT
    product_id,
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

GROUP BY
    product_id,
    product_name,
    category

ORDER BY units_sold DESC

LIMIT 10;


-- 5. Product Average Rating
SELECT
    product_id,
    product_name,
    category,

    ROUND(
        AVG(rating),
        2
    ) AS average_rating,

    COUNT(DISTINCT order_id) AS total_orders

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

ORDER BY average_rating DESC;


-- 6. Highly Rated Products
SELECT
    product_id,
    product_name,
    category,

    ROUND(
        AVG(rating),
        2
    ) AS average_rating

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

HAVING average_rating >= 4.5

ORDER BY average_rating DESC;


-- 7. Product Pricing Report
SELECT
    product_id,
    product_name,
    category,

    ROUND(
        AVG(unit_price),
        2
    ) AS average_price,

    MIN(unit_price) AS minimum_price,

    MAX(unit_price) AS maximum_price

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

ORDER BY average_price DESC;


-- 8. Product Discount Report
SELECT
    product_id,
    product_name,
    category,

    ROUND(
        AVG(discount),
        2
    ) AS average_discount,

    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS total_discount_amount

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

ORDER BY total_discount_amount DESC;


-- 9. Products With No Discount
SELECT
    product_id,
    product_name,
    category,

    COUNT(DISTINCT order_id) AS orders,

    SUM(quantity) AS units_sold,

    ROUND(
        SUM(
            quantity * unit_price
        ),
        2
    ) AS sales

FROM amazon_sales

WHERE discount = 0

GROUP BY
    product_id,
    product_name,
    category

ORDER BY sales DESC;


-- 10. Products With High Discounts
SELECT
    product_id,
    product_name,
    category,

    ROUND(
        AVG(discount),
        2
    ) AS average_discount,

    SUM(quantity) AS units_sold

FROM amazon_sales

WHERE discount > 10

GROUP BY
    product_id,
    product_name,
    category

ORDER BY average_discount DESC;


-- 11. Product Revenue Contribution
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
)

SELECT
    product_id,
    product_name,
    category,

    ROUND(revenue, 2) AS revenue,

    ROUND(
        revenue /
        SUM(revenue) OVER () * 100,
        2
    ) AS revenue_percentage

FROM product_revenue

ORDER BY revenue DESC;


-- 12. Product Revenue Ranking
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
)

SELECT
    product_id,
    product_name,
    category,

    ROUND(revenue, 2) AS revenue,

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank

FROM product_revenue

ORDER BY revenue_rank;


-- 13. Product Ranking Within Category
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
)

SELECT
    product_id,
    product_name,
    category,

    ROUND(revenue, 2) AS revenue,

    RANK() OVER (
        PARTITION BY category
        ORDER BY revenue DESC
    ) AS category_rank

FROM product_revenue

ORDER BY
    category,
    category_rank;


-- 14. Best Product in Each Category
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
),

ranked_products AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS product_rank

    FROM product_revenue
)

SELECT
    product_id,
    product_name,
    category,

    ROUND(revenue, 2) AS revenue

FROM ranked_products

WHERE product_rank = 1

ORDER BY revenue DESC;


-- 15. Products Above Category Average
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
),

category_average AS
(
    SELECT
        category,
        AVG(revenue) AS average_revenue

    FROM product_revenue

    GROUP BY category
)

SELECT
    p.product_id,
    p.product_name,
    p.category,

    ROUND(p.revenue, 2) AS product_revenue,

    ROUND(c.average_revenue, 2)
        AS category_average_revenue

FROM product_revenue p

JOIN category_average c
    ON p.category = c.category

WHERE p.revenue > c.average_revenue

ORDER BY
    p.category,
    p.revenue DESC;


-- 16. Products Sold in Multiple Cities
SELECT
    product_id,
    product_name,
    category,

    COUNT(DISTINCT customer_city) AS cities_sold_in,

    SUM(quantity) AS units_sold

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

HAVING COUNT(DISTINCT customer_city) > 1

ORDER BY cities_sold_in DESC;


-- 17. Products Purchased by Multiple Customers
SELECT
    product_id,
    product_name,
    category,

    COUNT(DISTINCT customer_id) AS unique_customers,

    SUM(quantity) AS units_sold

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

HAVING COUNT(DISTINCT customer_id) > 1

ORDER BY unique_customers DESC;


-- 18. Product Payment Method Analysis
SELECT
    product_id,
    product_name,
    payment_method,

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
    product_id,
    product_name,
    payment_method

ORDER BY
    product_id,
    revenue DESC;


-- 19. Product City Performance
SELECT
    product_id,
    product_name,
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
    product_id,
    product_name,
    customer_city

ORDER BY
    product_id,
    revenue DESC;


-- 20. Product Monthly Performance
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,

    product_id,
    product_name,

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
    DATE_FORMAT(order_date, '%Y-%m'),
    product_id,
    product_name

ORDER BY
    sales_month,
    revenue DESC;


-- 21. Product Performance Classification
SELECT
    product_id,
    product_name,
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
        ) >= 20000
        THEN 'Excellent'

        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 10000
        THEN 'Good'

        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 5000
        THEN 'Average'

        ELSE 'Low'
    END AS performance

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

ORDER BY revenue DESC;


-- 22. Product Revenue and Rating Analysis
SELECT
    product_id,
    product_name,
    category,

    ROUND(
        AVG(rating),
        2
    ) AS average_rating,

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
    product_id,
    product_name,
    category

ORDER BY
    average_rating DESC,
    revenue DESC;


-- 23. Products With High Sales and High Ratings
SELECT
    product_id,
    product_name,
    category,

    SUM(quantity) AS units_sold,

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

GROUP BY
    product_id,
    product_name,
    category

HAVING
    units_sold >= 5
    AND average_rating >= 4.0

ORDER BY revenue DESC;


-- 24. Product Sales Summary by Category
SELECT
    category,

    COUNT(DISTINCT product_id) AS total_products,

    SUM(quantity) AS total_units_sold,

    ROUND(
        SUM(
            (quantity * unit_price)
        ),
        2
    ) AS gross_sales,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS net_revenue,

    ROUND(
        AVG(rating),
        2
    ) AS average_rating

FROM amazon_sales

GROUP BY category

ORDER BY net_revenue DESC;


-- 25. FINAL PRODUCT DASHBOARD REPORT
WITH product_summary AS
(
    SELECT
        product_id,
        product_name,
        category,

        COUNT(DISTINCT order_id) AS total_orders,

        SUM(quantity) AS units_sold,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue,

        AVG(rating) AS average_rating,

        AVG(discount) AS average_discount

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
)

SELECT
    product_id,
    product_name,
    category,
    total_orders,
    units_sold,

    ROUND(revenue, 2) AS revenue,

    ROUND(average_rating, 2) AS average_rating,

    ROUND(average_discount, 2) AS average_discount,

    CASE
        WHEN revenue >= 20000
             AND average_rating >= 4.0
            THEN 'Top Product'

        WHEN revenue >= 10000
            THEN 'Strong Product'

        WHEN revenue >= 5000
            THEN 'Average Product'

        ELSE 'Low Performing Product'
    END AS product_segment

FROM product_summary

ORDER BY revenue DESC;
