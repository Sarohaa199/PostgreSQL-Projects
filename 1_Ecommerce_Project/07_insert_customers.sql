-- Inserting Data into the Customers Table 

COPY Customers (customer_id,name,email,location,signup_date) 
FROM 'D:\Programming\SQL\ecommerce_db\customers.csv' 
DELIMITER ',' 
CSV HEADER; 
 --The above script will insert data into the Customers table from the customers.csv file. 

 -- Query to check the number of rows in the Customers table
 Select Count(*) From Customers;
