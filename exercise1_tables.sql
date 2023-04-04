CREATE TABLE customers ( 
	customer_id int PRIMARY KEY NOT NULL,
	customer_name VARCHAR (50) NOT NULL,
	email VARCHAR (50) NOT NULL,
	phone VARCHAR (50) NOT NULL);

CREATE TABLE products (
	product_id VARCHAR (5) PRIMARY KEY,
	product_name VARCHAR (50) NOT NULL,
	description VARCHAR (255) NOT NULL,
	product_category VARCHAR (50) NOT NULL,
	unit_price NUMERIC (10,2) NOT NULL
);

CREATE TABLE orders (
	order_id int PRIMARY KEY,
	customer_id int NOT NULL,
	order_date DATE NOT NULL,
	product_id VARCHAR (5) NOT NULL,
	quantity INT NOT NULL,
	delivery_status VARCHAR (15) NOT NULL,
	FOREIGN KEY (customer_id) references customers (customer_id),
	FOREIGN KEY (product_id) references products (product_id));


CREATE TABLE payment (
	payment_id VARCHAR (5) PRIMARY KEY NOT NULL,
	order_id INT NOT NULL,
	payment_date DATE NOT NULL,
	FOREIGN KEY (order_id) references orders (order_id)
);

-- create unit_cost column and set default value to 0 because of the nut null constraint
ALTER TABLE products
ADD COLUMN unit_cost NUMERIC(10, 2) NOT NULL DEFAULT 0;

-- fill the unit_cost with the calculated values
UPDATE products
SET unit_cost = unit_price * 0.95;


-- creating the credit_card table
CREATE TABLE credit_card(
    credit_card_id VARCHAR(10) NOT NULL PRIMARY KEY,
    customer_id INT NOT NULL,
    card_number VARCHAR(20) NOT NULL,
    card_expiry_date DATE NOT NULL,
    bank_name VARCHAR(50) NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);