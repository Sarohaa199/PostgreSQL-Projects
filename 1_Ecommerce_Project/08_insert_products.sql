-- Inserting Data into Products Table

COPY products(product_id,name,category,price,stock_quantity,created_at) 
FROM 'D:\Programming\SQL\ecommerce_db\products.csv' 
DELIMITER ',' 
CSV HEADER;

-- Query to count total inserted rows
SELECT COUNT(*) FROM products;