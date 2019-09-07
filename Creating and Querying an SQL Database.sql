-- Drop table first by using DROP TABLE IF EXISTS.

DROP TABLE IF EXISTS customers;

/* create a table using the CREATE TABLE command. */

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

-- Both -- and /* and */ are used for commenting. -- is for a single while /* */ can span several lines.
-- SELECT * is used to return all info from a selected table.

SELECT * 
 FROM 
 customers;

-- if SELECT is used without the *, you have to specify the title of the information you are trying to retrieve. limit is use to specify the number of rows you want to see.

SELECT email
 FROM customers;

-- LIMIT is used to idenity the number of rows returned by your query. In the case, only 5 customers and their location will be returned.
 
SELECT location
 FROM customers
 LIMIT 5;

--ORDER BY is used as a filter, in this case, it shows the columns selected and ranks them by customer_id in descending order.

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id DESC
 LIMIT 5;

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id ASC
 LIMIT 5;

-- if you do not specify the ORDER BY command using ASC or DESC, SQL will show the result in ascending order.

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id 
 LIMIT 5;

-- You can specify more than one column with ORDER BY.

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id DESC, location;

SELECT firstname, lastname, location
 FROM customers
 ORDER BY customer_id ASC, location DESC;

-- WHERE is the perfect filter command for a column. != means not equal.

SELECT firstname, lastname, location 
 FROM customers
 WHERE customer_id != 1;

SELECT firstname, lastname, location 
 FROM customers
 WHERE customer_id > 1;

-- For strings or specific items in a column you can use any below.
SELECT firstname, lastname, location 
 FROM customers
 WHERE location = 'Nigeria';

SELECT firstname, lastname, location 
 FROM customers
 WHERE location != 'Nigeria';

-- LIKE command can replace the = sign, adding anything between '% and %' will resturn any column that has anything in between. In this case, it will return all email that has adventure in it. 
SELECT firstname, location, email
 FROM customers
 WHERE email LIKE '%@adventure%';

SELECT *
 FROM customers
 WHERE location IN ('Nigeria', 'Ghana');

SELECT firstname, location, email
 FROM customers
 WHERE email NOT LIKE '%@adventure%';