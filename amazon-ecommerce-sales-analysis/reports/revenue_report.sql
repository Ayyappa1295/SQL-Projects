USE amazon_ecommerce_sales;

-- =========================================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- REVENUE REPORT
-- =========================================================


-- 1. Overall Revenue Summary
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_id) AS total_products,

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
    ) AS net_revenue

FROM amazon_sales;


-- 2. Daily Revenue
SELECT
    order_date,

    COUNT(DISTINCT order_id) AS total_orders,

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
    ) AS net_revenue

FROM amazon_sales

GROUP BY order_date

ORDER BY order_date;


-- 3. Monthly Revenue
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS monthly_revenue

FROM amazon_sales

GROUP BY DATE_FORMAT(order_date, '%Y-%m')

ORDER BY sales_month;


-- 4. Monthly Revenue Growth
WITH monthly_revenue AS
(
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS sales_month,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
),

revenue_comparison AS
(
    SELECT
        sales_month,
        revenue,

        LAG(revenue) OVER (
            ORDER BY sales_month
        ) AS previous_revenue

    FROM monthly_revenue
)

SELECT
    sales_month,

    ROUND(revenue, 2) AS revenue,

    ROUND(previous_revenue, 2) AS previous_revenue,

    ROUND(
        (
            (revenue - previous_revenue)
            / NULLIF(previous_revenue, 0)
        ) * 100,
        2
    ) AS growth_percentage

FROM revenue_comparison

ORDER BY sales_month;


-- 5. Revenue by Category
SELECT
    category,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS units_sold,

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
    ) AS net_revenue

FROM amazon_sales

GROUP BY category

ORDER BY net_revenue DESC;


-- 6. Category Revenue Contribution
WITH category_revenue AS
(
    SELECT
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY category
)

SELECT
    category,

    ROUND(revenue, 2) AS revenue,

    ROUND(
        revenue /
        SUM(revenue) OVER () * 100,
        2
    ) AS revenue_percentage

FROM category_revenue

ORDER BY revenue DESC;


-- 7. Revenue by Product
SELECT
    product_id,
    product_name,
    category,

    SUM(quantity) AS units_sold,

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
    ) AS net_revenue

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

ORDER BY net_revenue DESC;


-- 8. Top 10 Revenue-Generating Products
SELECT
    product_id,
    product_name,
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
    product_id,
    product_name,
    category

ORDER BY revenue DESC

LIMIT 10;


-- 9. Revenue by Customer
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS customer_revenue

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

ORDER BY customer_revenue DESC;


-- 10. Top 10 Customers by Revenue
SELECT
    customer_id,
    customer_name,

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
    customer_id,
    customer_name

ORDER BY revenue DESC

LIMIT 10;


-- 11. Revenue by City
SELECT
    customer_city,

    COUNT(DISTINCT customer_id) AS customers,

    COUNT(DISTINCT order_id) AS orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY customer_city

ORDER BY revenue DESC;


-- 12. Revenue by Payment Method
SELECT
    payment_method,

    COUNT(DISTINCT order_id) AS orders,

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
    ) AS revenue

FROM amazon_sales

GROUP BY payment_method

ORDER BY revenue DESC;


-- 13. Revenue by Order Status
SELECT
    order_status,

    COUNT(DISTINCT order_id) AS orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY order_status

ORDER BY revenue DESC;


-- 14. Gross Sales vs Net Revenue
SELECT
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
        (
            SUM(
                (quantity * unit_price) * discount / 100
            )
            /
            NULLIF(SUM(quantity * unit_price), 0)
        ) * 100,
        2
    ) AS discount_percentage

FROM amazon_sales;


-- 15. Revenue by Discount Range
SELECT
    CASE
        WHEN discount = 0
            THEN '0% Discount'

        WHEN discount <= 5
            THEN '1-5% Discount'

        WHEN discount <= 10
            THEN '6-10% Discount'

        WHEN discount <= 20
            THEN '11-20% Discount'

        ELSE '20%+ Discount'
    END AS discount_range,

    COUNT(DISTINCT order_id) AS orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY
    CASE
        WHEN discount = 0
            THEN '0% Discount'

        WHEN discount <= 5
            THEN '1-5% Discount'

        WHEN discount <= 10
            THEN '6-10% Discount'

        WHEN discount <= 20
            THEN '11-20% Discount'

        ELSE '20%+ Discount'
    END

ORDER BY revenue DESC;


-- 16. Revenue Ranking by Category
WITH category_revenue AS
(
    SELECT
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY category
)

SELECT
    category,

    ROUND(revenue, 2) AS revenue,

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank

FROM category_revenue

ORDER BY revenue_rank;


-- 17. Running Total of Revenue
WITH daily_revenue AS
(
    SELECT
        order_date,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY order_date
)

SELECT
    order_date,

    ROUND(revenue, 2) AS daily_revenue,

    ROUND(
        SUM(revenue) OVER (
            ORDER BY order_date
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS running_revenue

FROM daily_revenue

ORDER BY order_date;


-- 18. Revenue by Day of Week
SELECT
    DAYNAME(order_date) AS day_name,

    COUNT(DISTINCT order_id) AS orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY
    DAYNAME(order_date),
    DAYOFWEEK(order_date)

ORDER BY DAYOFWEEK(order_date);


-- 19. Highest Revenue Day
SELECT
    order_date,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY order_date

ORDER BY revenue DESC

LIMIT 1;


-- 20. Average Order Value
SELECT
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        )
        /
        COUNT(DISTINCT order_id),
        2
    ) AS average_order_value

FROM amazon_sales;


-- 21. Revenue Above Average Order Value
WITH order_revenue AS
(
    SELECT
        order_id,
        customer_id,
        customer_name,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        order_id,
        customer_id,
        customer_name
)

SELECT
    order_id,
    customer_id,
    customer_name,

    ROUND(revenue, 2) AS order_revenue

FROM order_revenue

WHERE revenue >
(
    SELECT AVG(revenue)
    FROM order_revenue
)

ORDER BY order_revenue DESC;


-- 22. Product Revenue Ranking Within Category
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


-- 23. Revenue by Category and Payment Method
SELECT
    category,
    payment_method,

    COUNT(DISTINCT order_id) AS orders,

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


-- 24. Revenue by Month and Category
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


-- 25. FINAL REVENUE DASHBOARD
WITH revenue_summary AS
(
    SELECT
        COUNT(DISTINCT order_id) AS total_orders,

        COUNT(DISTINCT customer_id) AS total_customers,

        COUNT(DISTINCT product_id) AS total_products,

        SUM(quantity) AS total_units,

        SUM(quantity * unit_price) AS gross_sales,

        SUM(
            (quantity * unit_price) * discount / 100
        ) AS total_discount,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS net_revenue

    FROM amazon_sales
)

SELECT
    total_orders,
    total_customers,
    total_products,
    total_units,

    ROUND(gross_sales, 2) AS gross_sales,

    ROUND(total_discount, 2) AS total_discount,

    ROUND(net_revenue, 2) AS net_revenue,

    ROUND(
        total_discount / NULLIF(gross_sales, 0) * 100,
        2
    ) AS discount_percentage,

    ROUND(
        net_revenue / NULLIF(total_orders, 0),
        2
    ) AS average_order_value

FROM revenue_summary;
