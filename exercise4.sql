-- create aisle table
CREATE TABLE ex4_aisle(
	aisle_id INT PRIMARY KEY NOT NULL,
	aisle VARCHAR(250) NOT NULL
);

-- create department table
CREATE TABLE ex4_dept(
	department_id INT PRIMARY KEY NOT NULL,
	department VARCHAR(250) NOT NULL
);

-- create product table
CREATE TABLE ex4_product(
	product_id INT PRIMARY KEY NOT NULL,
	product_name VARCHAR(250) NOT NULL
);

-- create orders table
CREATE TABLE ex4_orders(
	order_id INT PRIMARY KEY NOT NULL,
	user_id INT NOT NULL,
	product_id INT NOT NULL REFERENCES ex4_product(product_id),
	aisle_id INT NOT NULL REFERENCES ex4_aisle(aisle_id),
	department_id INT NOT NULL REFERENCES ex4_dept(department_id),
	order_dow INT,
	order_hour_of_day INT,
	days_since_prior_order INT
);

-- Confirm if table data imported correctly
SELECT *
FROM ex4_aisle

SELECT *
FROM ex4_dept

SELECT *
FROM ex4_product
WHERE product_name ILIKE '%organic%'

SELECT *
FROM ex4_orders

-- Q1: On which days of the week are condoms mostly sold?

SELECT o.order_dow, COUNT(p.product_name) AS num_condoms
FROM ex4_orders o
INNER JOIN ex4_product p
USING (product_id)
WHERE product_name ILIKE '%condom%'
GROUP BY order_dow
ORDER BY num_condoms DESC
;

-- Q2: At what time of the day is it mostly sold?

SELECT o.order_hour_of_day, COUNT(p.product_name) AS num_condoms
FROM ex4_orders o
INNER JOIN ex4_product p
USING (product_id)
WHERE product_name ILIKE '%condom%'
GROUP BY order_hour_of_day
ORDER BY num_condoms DESC
;

-- Q3: What type of condom do the customers prefer?

SELECT p.product_name, COUNT(o.product_id) AS num_condoms
FROM ex4_orders o
INNER JOIN ex4_product p
USING (product_id)
WHERE product_name ILIKE '%condom%'
GROUP BY product_name
ORDER BY num_condoms DESC
LIMIT 1;

-- Q4: Which aisle contains most of the organic products?

SELECT a.aisle, COUNT(DISTINCT(p.product_id)) AS num_organic
FROM ex4_orders o
INNER JOIN ex4_aisle a
USING (aisle_id)
INNER JOIN ex4_product p
ON o.product_id = p.product_id
WHERE product_name ILIKE '%organic%'
GROUP BY a.aisle
ORDER BY num_organic DESC
LIMIT 1;

-- Q5: Which aisle(s) can I find all of the non-alcoholic drinks? 

SELECT DISTINCT a.aisle, p.product_name
FROM ex4_orders o
INNER JOIN ex4_aisle a
USING (aisle_id)
INNER JOIN ex4_product p
ON o.product_id = p.product_id
WHERE product_name ILIKE '%non alcoholic%';