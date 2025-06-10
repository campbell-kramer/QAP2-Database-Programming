CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
	product_name TEXT,
	price DECIMAL(10, 2),
	stock_quantity INT,
	enrollment_date DATE
);

CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	email TEXT
)

CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customers(customer_id),
	order_date DATE
)

CREATE TABLE order_items (
	order_id INT REFERENCES orders(order_id),
	product_id INT REFERENCES products(product_id),
	quantity INT,
	PRIMARY KEY (order_id, product_id)
)
