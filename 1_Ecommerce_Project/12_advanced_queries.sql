-- 1 Use a CTE to find the total sales per customer and filter only those who have spent more than $5000.
WITH customer_sales AS (
  SELECT o.customer_id as customer_id, SUM(total_amount) AS total_sales,c.name as customer_name
  FROM orders o 
  Join customers c 
  on o.customer_id = c.customer_id
  GROUP BY o.customer_id,c.name
)
SELECT customer_id, total_sales,customer_name
FROM customer_sales
WHERE total_sales > 5000
ORDER BY total_sales DESC;

-- 2 Use a recursive CTE to generate a monthly sales growth report for the last 12 months.
WITH RECURSIVE monthly_sales AS (
  -- Anchor member: Start from the earliest month within the last 12 months
  SELECT 
    DATE_TRUNC('month', CURRENT_DATE - INTERVAL '11 months') AS month,
    (SELECT COALESCE(SUM(total_amount), 0) 
     FROM orders 
     WHERE DATE_TRUNC('month', order_date) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '11 months')
    ) AS total_sales
  UNION ALL
  SELECT 
    month + INTERVAL '1 month',
    (SELECT COALESCE(SUM(total_amount), 0) 
     FROM orders 
     WHERE DATE_TRUNC('month', order_date) = month + INTERVAL '1 month'
    ) AS total_sales
  FROM monthly_sales
  WHERE month < DATE_TRUNC('month', CURRENT_DATE) -- Stop at the current month
)
SELECT * FROM monthly_sales;

-- 3 Rank customers by total spending using RANK().
SELECT 
  customer_id, 
  total_sales,
  RANK() OVER (ORDER BY total_sales DESC) AS rank
FROM (
    SELECT o.customer_id, SUM(total_amount) AS total_sales
    FROM orders o
    GROUP BY o.customer_id
    ) AS customer_sales;

-- 4 Find the top 5 products per category by sales using DENSE_RANK().
  With top_product AS
   (
	Select ot.product_id, p.name,p.category as category,
	Sum(ot.subtotal) as total_sales,
	DENSE_RANK() OVER(partition by p.category order by (Sum(ot.subtotal)) desc) as ranking
    From order_items ot
	Join products p 
	on ot.product_id=p.product_id
	group by p.category,ot.product_id,p.name
	) 
   Select category,product_id,name,total_sales,ranking 
   from top_product
   where ranking <=5;


-- 5 Calculate the running total of sales using SUM() OVER().
SELECT 
    product_id, 
    subtotal,
    Round(SUM(subtotal) OVER (ORDER BY product_id),0) AS running_total  -- Running total calculation
FROM order_items;

-- 6 Find the first and last order date for each customer using FIRST_VALUE() and LAST_VALUE().
SELECT 
    distinct (customer_id),
    FIRST_VALUE(order_date) OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS first_order_date,
    LAST_VALUE(order_date) OVER (PARTITION BY customer_id ORDER BY order_date ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order_date
FROM orders
ORDER BY customer_id;

-- 7 Identify slow queries using EXPLAIN ANALYZE.
Explain Analyze
SELECT 
    customer_id,
    FIRST_VALUE(order_date) OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS first_order_date,
    LAST_VALUE(order_date) OVER (PARTITION BY customer_id ORDER BY order_date ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order_date
FROM orders
group by customer_id
ORDER BY customer_id;
-- 8 Create an index on order_date to speed up sales reports.
CREATE INDEX order_date_idx ON orders(order_date);
