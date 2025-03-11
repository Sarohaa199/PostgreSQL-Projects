-- Creating products table with column names product_id, name, category, price, stock_quantity, created_at

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT DEFAULT 0 CHECK(stock_quantity >=0),
    created_at TIMESTAMP DEFAULT NOW()
)