DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    firstname VARCHAR (50) NOT NULL,
    lastname VARCHAR (50) NOT NULL,
    location VARCHAR (50) NOT NULL,
    email VARCHAR (50) NOT NULL
);

INSERT INTO customers
    (customer_id, firstname, lastname, location, email)
 VALUES
   ( 1, 'Orlando', 'Bloom', 'Australia', 'orlando@python.com'),
   ( 2, 'Keith', 'Urban', 'India', 'keith0@adventure-works.com'),
   ( 3, 'Donna', 'Paulson', 'Germany', 'donna0@adventure-works.com'),
   ( 4, 'Janet', 'Jackson',  'United States','janet1@adventure-works.com'),
   ( 5, 'Shade', 'Okoya', 'Nigeria', 'shadedeveloper@python.com'),
   ( 6, 'Kondogbia', 'Gemma', 'Malaysia', 'kondogbia@adventure-works.com'),
   ( 7, 'Bankole', 'Weliington', 'United states', 'bankole0@adventure-works.com'),
   ( 8, 'Mike', 'Ross', 'New Zealand', 'Mike0@adventure-works.com'),
   ( 9, 'Johnson', 'Lawal', 'Gambia','Johnson@adventure-works.com'),
   ( 10, 'Akuffo', 'Adoh', 'Ghana', 'Lawal@python.com');

SELECT * 
 FROM 
 customers;

SELECT email
 FROM customers;

SELECT location
 FROM customers
 LIMIT 5;

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id DESC
 LIMIT 5;

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id ASC
 LIMIT 5;

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id 
 LIMIT 5;

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id DESC, location;

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id ASC, location DESC;

SELECT firstname, lastname, location 
 FROM customers
 WHERE customer_id != 1;

SELECT firstname, lastname, location 
 FROM customers
 WHERE customer_id > 1;

SELECT firstname, lastname, location 
 FROM customers
 WHERE location = 'Nigeria';

SELECT firstname, lastname, location 
 FROM customers
 WHERE location != 'Nigeria';

SELECT firstname, location, email
 FROM customers
 WHERE email LIKE '%@adventure%';

SELECT *
 FROM customers
 WHERE location IN ('Nigeria', 'Ghana');

SELECT firstname, location, email
 FROM customers
 WHERE email NOT LIKE '%@adventure%';