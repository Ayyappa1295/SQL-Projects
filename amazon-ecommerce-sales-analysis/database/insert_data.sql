USE amazon_ecommerce_sales;

LOAD DATA LOCAL INFILE 'amazon_sales.csv'
INTO TABLE amazon_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    order_date,
    customer_id,
    customer_name,
    customer_city,
    product_id,
    product_name,
    category,
    quantity,
    unit_price,
    discount,
    payment_method,
    order_status,
    rating
);
