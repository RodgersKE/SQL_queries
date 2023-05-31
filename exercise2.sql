-- Created restaurant database

CREATE DATABASE restaurantsDB

-- Created customers, restaurants, products and orders tables

CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(50) NOT NULL,
	customer_address VARCHAR(50) NOT NULL,
	customer_email VARCHAR(100) NOT NULL
);

CREATE TABLE restaurants(
	restaurant_id INT PRIMARY KEY,
	restaurant_name VARCHAR(50) NOT NULL,
	restaurant_address VARCHAR(100),
	restaurant_city VARCHAR(50) NOT NULL,
	restaurant_state VARCHAR(50) NOT NULL
);

CREATE TABLE products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	item_description VARCHAR(250),
	unit_price NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	order_quantity INT NOT NULL,
	order_date DATE NOT NULL
);

-- Used basic SELECT query to check whether the tables had been properly created with columns

SELECT * 
FROM customers;

SELECT * 
FROM restaurants;

SELECT * 
FROM products;

SELECT * 
FROM orders;

-- Add a foreign key to reference the customers table

ALTER TABLE orders
ADD COLUMN customer_id INT REFERENCES customers(customer_id);

-- Add a foreign key to reference the products table

ALTER TABLE orders
ADD COLUMN product_id INT REFERENCES products(product_id);

-- Add a foreign key to reference the restaurants table

ALTER TABLE orders
ADD COLUMN restaurant_id INT REFERENCES restaurants(restaurant_id);

-- Populated orders table with appropriate foreign key values

ALTER TABLE orders
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

