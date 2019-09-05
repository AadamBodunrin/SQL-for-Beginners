/* If you are a beginner, refer to the creating and querying an SQL Database file.

Comments here will serve as form of possible questions. Let your curiousity drive you */


-- Show me actor's first_name, last_name that have Nick, Ed and Jennifer as their firstnames.

SELECT first_name, 
       last_name
FROM
 actor
WHERE
 first_name IN ('Nick','Ed', 'Jennifer');

-- Show me only last_name of actor whose first names are Ed, Nick and Jennifer
SELECT
 last_name
FROM
 actor
WHERE 
first_name in ('Ed','Nick','Jennifer');

-- Show me all the details of the address table

SELECT *
FROM
 address;


-- I want to see district & phone in descending order that are in the address table
SELECT 
 district,
 phone
FROM
 address
ORDER BY
 district DESC,
 phone DESC;

-- From fiilm table, show me title, film_id. from Inventory table, show me inventory_id. Do this when film_id on film table match film_id on the inventory table.
SELECT film.title,
       film.film_id,
       inventory.inventory_id
FROM
 film
INNER JOIN 
 inventory 
ON 
 film.film_id = inventory.film_id;

-- show me first_name, last_name of actors whose first_name (Ed, Nick and Jennifer) are distinct 
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

-- show me everything from inventory table and rental table.
SELECT inventory.*, rental.*
 FROM inventory
 JOIN rental 
 ON rental.inventory_id = inventory.inventory_id
 LIMIT 5;

-- From the rental and payment table, show me just 10 rows of rental_id, rental_date, payment_id and ordedered by amount in descending order. 
SELECT rental.rental_id, 
       rental.rental_date, 
       payment.payment_id, 
       payment.amount
 FROM rental
 JOIN payment
 ON payment.rental_id = rental.rental_id
 ORDER BY amount DESC
 LIMIT 10;

-- from film_category table, film and film_actor table, I want to see 5 rows of film_id, category_id, title, rental_rate  from the three tables.
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