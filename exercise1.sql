CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	phone VARCHAR(50) NOT NULL
);

CREATE TABLE products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	description VARCHAR(250),
	product_category VARCHAR(50) NOT NULL,
	unit_price NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	customer_id INT NOT NULL,
	order_date DATE NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	delivery_status VARCHAR(50) NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments(
	payment_id INT PRIMARY KEY,
	order_id INT NOT NULL,
	payment_date DATE NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
);