USE product_sales_analytics;

-- =========================
-- CUSTOMERS
-- =========================

INSERT INTO customers VALUES
(101,'Aarav Sharma','aarav@gmail.com','Bengaluru','Karnataka','India','2025-01-10'),
(102,'Priya Reddy','priya@gmail.com','Hyderabad','Telangana','India','2025-01-15'),
(103,'Rahul Kumar','rahul@gmail.com','Chennai','Tamil Nadu','India','2025-02-05'),
(104,'Sneha Patel','sneha@gmail.com','Mumbai','Maharashtra','India','2025-02-18'),
(105,'Arjun Rao','arjun@gmail.com','Pune','Maharashtra','India','2025-03-01'),
(106,'Ananya Singh','ananya@gmail.com','Delhi','Delhi','India','2025-03-10'),
(107,'Vikram Das','vikram@gmail.com','Kolkata','West Bengal','India','2025-03-20'),
(108,'Kavya Nair','kavya@gmail.com','Kochi','Kerala','India','2025-04-02'),
(109,'Rohan Mehta','rohan@gmail.com','Ahmedabad','Gujarat','India','2025-04-15'),
(110,'Divya Iyer','divya@gmail.com','Coimbatore','Tamil Nadu','India','2025-05-01');


-- =========================
-- PRODUCTS
-- =========================

INSERT INTO products VALUES
(201,'Laptop Pro 14','Electronics','TechPro',75000,60000,50),
(202,'Smartphone X','Electronics','TechPro',35000,27000,100),
(203,'Wireless Headphones','Accessories','SoundMax',5000,3000,200),
(204,'Smart Watch','Wearables','FitTech',8000,5000,150),
(205,'Bluetooth Speaker','Accessories','SoundMax',4500,2800,120),
(206,'Gaming Mouse','Accessories','GamePro',2500,1400,250),
(207,'Mechanical Keyboard','Accessories','GamePro',5500,3500,180),
(208,'Tablet Air','Electronics','TechPro',28000,21000,80),
(209,'Power Bank','Accessories','PowerPlus',1800,1000,300),
(210,'USB-C Hub','Accessories','ConnectPro',3000,1700,220);


-- =========================
-- ORDERS
-- =========================

INSERT INTO orders VALUES
(1001,101,'2025-06-01','Delivered','UPI','Bengaluru','Karnataka'),
(1002,102,'2025-06-03','Delivered','Credit Card','Hyderabad','Telangana'),
(1003,103,'2025-06-05','Delivered','UPI','Chennai','Tamil Nadu'),
(1004,104,'2025-06-08','Shipped','Debit Card','Mumbai','Maharashtra'),
(1005,105,'2025-06-10','Delivered','UPI','Pune','Maharashtra'),
(1006,106,'2025-06-12','Cancelled','Credit Card','Delhi','Delhi'),
(1007,107,'2025-06-15','Delivered','UPI','Kolkata','West Bengal'),
(1008,108,'2025-06-18','Delivered','UPI','Kochi','Kerala'),
(1009,109,'2025-06-20','Shipped','Credit Card','Ahmedabad','Gujarat'),
(1010,110,'2025-06-22','Delivered','Debit Card','Coimbatore','Tamil Nadu'),
(1011,101,'2025-07-01','Delivered','UPI','Bengaluru','Karnataka'),
(1012,102,'2025-07-04','Delivered','Credit Card','Hyderabad','Telangana'),
(1013,103,'2025-07-07','Shipped','UPI','Chennai','Tamil Nadu'),
(1014,104,'2025-07-10','Delivered','UPI','Mumbai','Maharashtra'),
(1015,105,'2025-07-15','Delivered','Credit Card','Pune','Maharashtra');


-- =========================
-- ORDER ITEMS
-- =========================

INSERT INTO order_items VALUES
(1,1001,201,1,75000),
(2,1001,203,2,5000),

(3,1002,202,1,35000),
(4,1002,204,1,8000),

(5,1003,208,1,28000),
(6,1003,209,2,1800),

(7,1004,203,3,5000),
(8,1004,206,2,2500),

(9,1005,201,1,75000),
(10,1005,207,1,5500),

(11,1006,202,1,35000),

(12,1007,205,2,4500),
(13,1007,209,3,1800),

(14,1008,204,2,8000),
(15,1008,210,2,3000),

(16,1009,208,1,28000),
(17,1009,203,2,5000),

(18,1010,202,1,35000),
(19,1010,206,2,2500),

(20,1011,201,1,75000),
(21,1011,210,1,3000),

(22,1012,202,2,35000),
(23,1012,203,1,5000),

(24,1013,207,2,5500),
(25,1013,209,2,1800),

(26,1014,208,1,28000),
(27,1014,204,1,8000),

(28,1015,201,1,75000),
(29,1015,205,2,4500);
