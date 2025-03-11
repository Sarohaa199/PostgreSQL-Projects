-- Creating table customers with column customer_id, name, email, location, signup_date
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100)  UNIQUE NOT NULL,
    location VARCHAR(100),
    signup_date TIMESTAMPTZ DEFAULT NOW()
)