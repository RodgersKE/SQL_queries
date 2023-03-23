-- number of customers with customer_id more than 20
SELECT COUNT(*)
FROM customers
WHERE customer_id > 20;

-- customers whose names begin with the letter E
SELECT COUNT(*)
FROM customers
WHERE customer_name LIKE 'E%';

-- number of products in each product category
SELECT product_category, COUNT(product_name)
FROM products
GROUP BY product_category;

-- sum and average of unit price for each product category with more than 150 total unit_price.
SELECT product_category, SUM(unit_price) AS total_price, ROUND(AVG(unit_price),2) AS average_price
FROM products
GROUP BY product_category
HAVING SUM(unit_price) > 150;



