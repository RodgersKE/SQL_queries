/* KPIs
1. Product performance by revenue
2. Product category performance by profits
3. Effectiveness of delivery by delivery rate
4. Trend of orders placed by month
5. Customer loyalty measured by number of orders placed by each customer */

SELECT * FROM products

SELECT * FROM orders

SELECT * FROM payment

SELECT * FROM customers

--1. Which are the top 5 best performing products by profit?
SELECT product_name, product_category, SUM(unit_price * quantity) AS revenue, SUM((unit_price - unit_cost) * o.quantity) AS profit
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY product_name, product_category
ORDER BY profit DESC
LIMIT 5;

-- Recommendation
/* Based on the above, products generating the highest revenue also generate the highest profit. Sales promotions should be
done for the products to generate more profit. */

--2. What is the revenue and profit by product category? Which category needs more sales promotion efforts? 
SELECT product_category, SUM(unit_price * quantity) AS revenue, SUM((unit_price - unit_cost) * o.quantity) AS profit
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY product_category
ORDER BY profit DESC
LIMIT 5;

-- Recommendation
/* Laptop category has the highest revenue and profits. Accessories category has the lowest of both thus needs 
to have more sales promotions to boost it. */

-- 3. % of delivered orders to total orders placed

SELECT COUNT(CASE WHEN delivery_status = 'Delivered' THEN 1 END) * 100 / COUNT(*) AS delivery_rate
FROM orders;

-- Recommendation
/* Delivery rate is at 36% which is quite low. Efforts should be put to improve on the logisitics processes and tracking of 
delivery times from date of order in order to improve this. */

-- 4. How many orders were placed per month?

SELECT DATE_TRUNC('Month', order_date)::DATE AS Month, COUNT(*) AS num_orders
FROM orders
GROUP BY Month
ORDER BY Month

--Recommendations
/* There was a sharp decline in sales in April 2023. Promotion efforts should be made on products that 
generate high revenue and profits to boost sales. */  

-- 5. Identify repeat customers and their respective number of orders

SELECT c.customer_id, COUNT(order_id) AS num_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(order_id) > 3
ORDER BY num_orders DESC;

-- Recommendations
/* There should be a reward system for repeat customers to encourage more sales. There could be promotions
for customers in the loyalty program to stand a chance to win prizes or get great discounts. There should be a customer
survey targeting those who have less than 2 orders to find out about their experience with the business and get feedback on what
to improve. */
