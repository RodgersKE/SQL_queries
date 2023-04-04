-- Find the highest and lowest priced products along with their prices
SELECT product_name,
		unit_price
FROM products
WHERE unit_price = (SELECT MAX(unit_price) FROM products)
OR	  unit_price = (SELECT MIN(unit_price) FROM products);

-- find the total number of orders in each month in the year 2022 - should show month by name
SELECT DATE_PART('MONTH', order_date) AS order_date,
COUNT(order_id) AS count_of_orders
FROM orders
where order_date < '2023-01-01'
GROUP BY DATE_PART('MONTH', order_date)
order by order_date;

-- average unit_price and unit_cost (2 decimal places) for each product category

SELECT 	product_category, 
		ROUND(AVG(unit_price),2) AS avg_unit_price, 
		ROUND(AVG(unit_cost),2) AS avg_unit_cost
FROM products
GROUP BY product_category;

-- Find all orders that were placed on or after August 1, 2022

SELECT *
FROM orders
WHERE order_date >= '2022-08-01'
ORDER BY order_date;

-- Count the number of payments made on April 14, 2023

SELECT COUNT(*)
FROM payment
WHERE payment_date = '2022-04-14';

-- Which customer_id has the highest orders placed in the orders table

SELECT customer_id, COUNT(quantity) AS highest_quantity
FROM orders
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 1;

-- What is the total number of orders made by each customer_id

SELECT customer_id, COUNT(quantity) 
FROM orders
GROUP BY customer_id
ORDER BY customer_id;

-- How many orders were delivered between Jan & Feb 2023

SELECT COUNT(*)
FROM orders 
WHERE order_date BETWEEN '2023-01-01' AND '2023-02-28' 
AND delivery_status = 'Delivered';

-- Retrieve all the information associated with the credit card that is next to expire from the credit card table. 

SELECT *
FROM credit_card
WHERE card_expiry_date = (
	SELECT card_expiry_date
	FROM credit_card
	WHERE card_expiry_date > CURRENT_DATE
	ORDER BY card_expiry_date
	LIMIT 1);
	
-- Expired cards

SELECT COUNT(*)
FROM credit_card
WHERE card_expiry_date = (
	SELECT card_expiry_date
	FROM credit_card
	WHERE card_expiry_date < CURRENT_DATE
	ORDER BY card_expiry_date);


