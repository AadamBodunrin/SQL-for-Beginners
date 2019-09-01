SELECT
 FIRST_NAME,
 LAST_NAME
FROM
 actor
WHERE
 FIRST_NAME IN ('Nick','Ed', 'Jennifer');

SELECT
 last_name
FROM
 actor
where 
first_name in ('Ed','Nick','Jennifer');

SELECT *
FROM
 ADDRESS;

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