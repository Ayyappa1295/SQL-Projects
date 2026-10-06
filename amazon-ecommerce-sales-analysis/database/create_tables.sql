USE amazon_ecommerce_sales;

DROP TABLE IF EXISTS amazon_sales;

CREATE TABLE amazon_sales (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_city VARCHAR(100),
    product_id VARCHAR(10) NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(5,2) DEFAULT 0,
    payment_method VARCHAR(50),
    order_status VARCHAR(30),
    rating DECIMAL(2,1)
);
