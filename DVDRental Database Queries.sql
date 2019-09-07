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

-- show me top 5 rows from inventory table and rental table.
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

-- Show me all the other details in the actor table where actor_id is empty
SELECT *
 FROM actor
 WHERE actor_id IS NULL;

-- Show me all the other details in the actor table where actor_id is not empty
SELECT *
 FROM actor
 WHERE actor_id IS NOT NULL;

-- I want to see number of non-empty rows in film table
SELECT COUNT(*)
 FROM film;

--I want to see number of film_id in film table
SELECT COUNT
     (film_id)
 FROM film;

-- Unlike count, sum can only be used for numeric columns. I want to see the sum of amount from the payment table, let the output title be sum_amt.

SELECT SUM(Payment.amount) AS sum_amt
 FROM payment;

-- I want to see both Maximum and minimun amount in the payment table
SELECT MAX(amount) AS Max_amt,
       MIN(amount) AS Min_amt
 FROM payment;     


-- calculate the average amount by using the COUNT and SUM command. Show the maximun and minimun amount

SELECT SUM(payment.amount) AS sum_amt,
       COUNT(amount) AS cnt_amt,
       MAX(amount) AS Max_amt,
       MIN(amount) AS Min_amt, 
       AVG(amount) AS avg_amt,
       SUM(payment.amount) / COUNT(amount) AS avg_amt2
 FROM payment;

-- show the sum of payment made by each payment_id
SELECT payment.payment_id,
       SUM(Payment.amount) AS sum_amt
 FROM payment
 GROUP BY payment_id
 ORDER BY payment_id;

-- from the actor table, show me unique first and last names. PS, DISTINCT can only be used with SELECT

SELECT DISTINCT first_name, 
                last_name
 FROM actor;

-- show the sum of amount by each payment id that is greater then 5.99
SELECT payment.payment_id,
       SUM(Payment.amount) AS sum_amt
 FROM payment
 GROUP BY 1
 HAVING SUM(payment.amount) >= 5.99;

SELECT last_update
 FROM film;

--show the sum of rental_rate of films by month

SELECT DATE_TRUNC('month', film.last_update),
       SUM(rental_rate)
 FROM film
 GROUP BY DATE_TRUNC('month', film.last_update)
 ORDER BY DATE_TRUNC('month', film.last_update);

SELECT DATE_PART('dow', film.last_update),
       SUM(rental_rate)
 FROM film
 GROUP BY DATE_PART('dow', film.last_update)
 ORDER BY DATE_PART('dow', film.last_update);


-- Show me film.id, film.title, film.description and film_length. categorize film.length into yes(film.length is less than 86) or no (film.length is greater than 86) 
SELECT film.film_id,
       film.title,
       film.description,
       film.length,
       CASE WHEN film.length = 86 OR film.length <= 86 THEN 'Yes' ELSE 'NO' END AS Not_lnger_than_86
 FROM film
 ORDER BY film.film_id; 

-- Show me the COUNT of the two categories above.
SELECT 
       CASE WHEN film.length = 86 OR film.length <= 86 THEN 'Yes' ELSE 'NO' END AS Not_lnger_than_86,
       COUNT(*) Either
 FROM film
 GROUP BY 1;

-- SHow me film.id, film.title, film.description and film_length. categorize film.length into 4 categories(over 100, 86-100, 72-86 and under 72) 

SELECT film.film_id,
       film.title,
       film.description,
       film.length,
       CASE WHEN film.length > 100 THEN 'Over 100'
            WHEN film.length > 86 AND film.length <= 100 THEN '86 - 100'
            WHEN film.length > 72 AND film.length <= 86 THEN '72 - 86'
            ELSE '72 or under' END AS film_length 
 FROM film
 ORDER BY film.film_id;

-- Show me the COUNT of the four categories above. 
SELECT 
       CASE WHEN film.length > 100 THEN 'Over 100'
            WHEN film.length > 86 AND film.length <= 100 THEN '86 - 100'
            WHEN film.length > 72 AND film.length <= 86 THEN '72 - 86'
            ELSE '72 or under' END AS film_length, 
            COUNT(*) AS movie_length_cat
 FROM film
 GROUP BY 1;
