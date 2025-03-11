-- Creating table order_items with columns order_id, product_id, quantity, subtotal
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK(quantity > 0),
    subtotal DECIMAL(10, 2) NOT NULL CHECK(subtotal > 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);