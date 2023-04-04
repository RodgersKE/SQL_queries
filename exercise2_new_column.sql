-- run query to check data in products table
SELECT *
FROM products;

-- created a new column named unit_cost
ALTER TABLE products
ADD COLUMN unit_cost NUMERIC(10,2);

-- populated the unit_cost which is 95% of unit_price
UPDATE products
SET unit_cost = unit_price * 0.95 
WHERE unit_cost IS NULL;

