SELECT first_name, 
       last_name
FROM
 actor
WHERE
 first_name IN ('Nick','Ed', 'Jennifer');

SELECT
 last_name
FROM
 actor
where 
first_name in ('Ed','Nick','Jennifer');

SELECT *
FROM
 address;

SELECT 
 district,
 phone
FROM
 address
ORDER BY
 district DESC,
 phone DESC;

SELECT film.title,
       film.film_id,
       inventory.inventory_id
FROM
 film
INNER JOIN 
 inventory 
ON 
 film.film_id = inventory.film_id;

SELECT
 first_name,
 last_name
FROM
 actor
WHERE
 first_name
IN
(Select 
DISTINCT 
 first_name
FROM
 actor
WHERE
 first_name IN ('Nick', 'Ed', 'Jennifer'));

SELECT inventory.*, rental.*
 FROM inventory
 JOIN rental 
 ON rental.inventory_id = inventory.inventory_id
 LIMIT 5;

SELECT rental.rental_id, 
       rental.rental_date, 
       payment.payment_id, 
       payment.amount
 FROM rental
 JOIN payment
 ON payment.rental_id = rental.rental_id
 ORDER BY amount DESC
 LIMIT 10;

SELECT film_category.film_id, 
       film_category.category_id, 
       film.film_id, 
       film.title, 
       film.rental_rate,
       film_actor.film_id
 FROM film_category
 JOIN film 
 ON film.film_id = film_category.film_id
 JOIN film_actor 
 ON film_actor.film_id = film.film_id
 LIMIT 5;