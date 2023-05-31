-- Q1 available movies
SELECT f.title,
		COUNT(DISTINCT i.inventory_id) available_copies
FROM inventory i
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
GROUP BY f.title;

-- Q2 track customer rentals
SELECT c.first_name || ' ' || c.last_name AS customer_name,
		STRING_AGG(f.title, ', ') rented_movies
FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE r.return_date IS  NULL
GROUP BY c.customer_id;

-- Q3 late fees
WITH rented AS(
	SELECT c.first_name || ' ' || c.last_name AS customer_name,
			f.title,
			f.rental_rate,
			f.rental_duration,
			EXTRACT(DAY FROM AGE(r.rental_date + INTERVAL '5 days', r.rental_date)) days_rented 
	FROM inventory i
	JOIN rental r ON i.inventory_id = r.inventory_id
	JOIN film f ON i.film_id = f.film_id
	JOIN customer c ON r.customer_id = c.customer_id
	WHERE r.return_date IS NULL
	GROUP BY c.customer_id, f.title, f.rental_rate, f.rental_duration,
			EXTRACT(DAY FROM AGE(r.rental_date + INTERVAL '5 days', r.rental_date))
)
SELECT customer_name,
		title,
		((days_rented - rental_duration) * rental_rate) late_fees
FROM rented
WHERE days_rented > rental_duration;

--Q4 popular movie genres
SELECT c.name AS genres,
		COUNT(r.rental_id) total_rentals
FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY genres
ORDER BY total_rentals DESC
LIMIT 5;

--Q5 revenue by movie genres
SELECT 	c.name AS genres,
		'$' || SUM(p.amount) revenue_by_genre
FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY genres
ORDER BY revenue_by_genre DESC
LIMIT 5;
