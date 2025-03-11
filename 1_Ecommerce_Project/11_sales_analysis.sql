-- 1 Find the total sales amount across all orders./
SELECT SUM(total_amount) AS total_sales_amount
FROM orders;

-- 2 Get the top 5 best-selling products by quantity sold.
SELECT ot.product_id, p.name,SUM(ot.quantity) AS total_quantity_sold
FROM order_items ot
JOIN products p
ON ot.product_id = p.product_id
GROUP BY ot.product_id,p.name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- 3 Find the top 5 highest revenue-generating products.
SELECT ot.product_id, p.name, SUM(ot.subtotal) AS total_revenue_generated
FROM order_items ot
JOIN products p
ON ot.product_id = p.product_id
GROUP BY ot.product_id,p.name
ORDER BY total_revenue_generated DESC
LIMIT 5;

-- 4 Find customers who have placed more than 5 orders.
SELECT c.customer_id,c.name, COUNT(o.order_id) AS total_orders_placed
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id,c.name
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders_placed DESC;

-- 5 Identify customers who never placed an order.

SELECT c.customer_id,c.name, COUNT(o.order_id) AS total_orders_placed
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id,c.name
HAVING COUNT(o.order_id) = 0 OR COUNT(o.order_id) IS NULL
ORDER BY total_orders_placed DESC;

-- 6 Find the most frequent customers (those with the highest number of orders).
SELECT c.customer_id,c.name, COUNT(o.order_id) AS total_orders_placed
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id,c.name
ORDER BY total_orders_placed DESC;

-- 7 Calculate the total sales per month for the last 12 months.
SELECT EXTRACT(MONTH FROM order_date) AS month, EXTRACT(YEAR FROM order_date) AS year, SUM(total_amount) AS total_sales
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY month, year
ORDER BY year, month;
-- 8 Find the peak sales month (the month with the highest total revenue).
SELECT EXTRACT(MONTH FROM order_date) AS month, EXTRACT(YEAR FROM order_date) AS year, SUM(total_amount) AS total_sales
FROM orders
GROUP BY month, year
ORDER BY total_sales DESC
LIMIT 1;

-- 9 Identify order trends by counting the number of orders placed per day in the last 30 days.

SELECT order_date, COUNT(order_id) AS total_orders_placed
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY order_date
ORDER BY order_date;