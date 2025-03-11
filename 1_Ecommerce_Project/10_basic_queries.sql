-- 1️ Retrieve the first 10 customers from the customers table.

SELECT * FROM customers LIMIT 10;
-- 2️ Find the total number of orders in the orders table.

SELECT COUNT(*) FROM orders;

-- 3️ Get all orders placed by a specific customer using their email.
SELECT * FROM orders where customer_id in (SELECT customer_id from Customers where email like '%yahoo%')