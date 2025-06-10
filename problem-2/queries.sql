CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
	product_name TEXT,
	price DECIMAL(10, 2),
	stock_quantity INT
);

CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	email TEXT
);

CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customers(customer_id),
	order_date DATE
);

CREATE TABLE order_items (
	order_id INT REFERENCES orders(order_id),
	product_id INT REFERENCES products(product_id),
	quantity INT,
	PRIMARY KEY (order_id, product_id)
);

INSERT INTO products (product_name, price, stock_quantity) VALUES
('iPhone', 1899.99, 200),
('iPad', 999.99, 50),
('iPod Shuffle', 149.99, 100),
('iPod Nano', 399.99, 45),
('Zune', 299.99, 67),
('Hamburger', 29.50, 50);

INSERT INTO customers (first_name, last_name, email) VALUES
('Elizabeth', 'Shaw', 'eshaw@science.com'),
('Meredith', 'Vickers', 'meredith_vickers@weylandcorp.com'),
('Charlie', 'Holloway', 'cholloway@science.com'),
('David', 'Last-name', 'david@weylandcorp.com');

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1, 1, '2089-08-08'),
(2, 2, '2089-11-08'),
(3, 2, '2089-11-09'),
(4, 3, '2089-11-12'),
(5, 4, '2089-11-14');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 4, 1),
(2, 6, 1),
(3, 6, 10),
(4, 5, 1),
(4, 6, 1),
(5, 2, 100);

-- Retrieve the names and stock quantities of all products
SELECT product_name, stock_quantity FROM products;

-- Retrieve the product names and quantities for one of the orders placed.
SELECT 
    product_name,
    quantity
FROM order_items
JOIN products ON order_items.product_id = products.product_id
WHERE order_items.order_id = 2;

-- Retrieve all orders placed by a specific customer
SELECT order_items.order_id, order_items.product_id, order_items.quantity
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
WHERE orders.customer_id = 2;

-- Perform an update to simulate the reducing of stock quantities of items after a customer places an order.
-- This stock update is via order_id 3 (10 Hamburgers for Meredith Vickers [hungry lady])
UPDATE products
SET stock_quantity = stock_quantity - 10
WHERE product_name = 'Hamburger';

-- Remove one of the orders and all associated order items from the system
DELETE FROM order_items 
WHERE order_id = 4;

DELETE FROM orders
WHERE order_id = 4;
