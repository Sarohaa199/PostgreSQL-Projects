-- Inserting data into the orders table

COPY orders(order_id, customer_id, order_date, total_amount)
FROM 'D:\Programming\SQL\ecommerce_db\orders.csv' 
DELIMITER ',' 
CSV HEADER;

--Query to check total inserted rows
SELECT COUNT(*) FROM orders;

-- Inserting data into the order_items table
COPY order_items(order_id,product_id,quantity,subtotal)
FROM 'D:\Programming\SQL\ecommerce_db\order_items.csv'
DELIMITER ','
CSV HEADER;

--Query to check total inserted rows
SELECT Count(*) FROM order_items;