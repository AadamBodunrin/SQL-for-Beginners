-- TO reset the root password; replace Mypass with a strong password
-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'Mypass';


-- To use a Database for your queries.
USE sql_store;

-- Generic SELECT statement 
SELECT *
FROM customers;

-- Use WHERE and ORDER BY as a filter. 
SELECT *
FROM Customers
WHERE State = "FL"
ORDER BY First_name;

SELECT *
FROM Customers
WHERE Points > 3000;

-- Perform Some mathematical functions, to get desired result, follow the PEMDAS rule
SELECT first_name, last_name,
    points,
    Points + 10 * 100,
    (points + 10) * 100  Sub
FROM Customers;

SELECT name, Unit_price,
	Unit_price * 1.1 New_price
FROM products;

-- Return Unique states in the customers table
SELECT DISTINCT state
FROM Customers;
    
-- Further use case scenarios of WHERE statement
SELECT *
FROM Customers
WHERE State = "VA";

SELECT *
FROM Customers
WHERE State != "VA";

SELECT *
FROM Customers
WHERE State <> "VA";

SELECT *
FROM Customers
WHERE Birth_date > "1990-01-01";

SELECT *
FROM Orders
WHERE Order_date >= "2019-01-01";

SELECT *
FROM Customers
WHERE Birth_date > "1990-01-01" AND Points > 1000;

SELECT *
FROM Customers
WHERE Birth_date > "1990-01-01" OR Points > 1000;

SELECT *
FROM Customers
WHERE Birth_date > "1990-01-01" OR Points > 1000 AND State = "VA";

SELECT *
FROM Order_items
WHERE order_id = 6 AND (Quantity * Unit_price) > 30;

SELECT *
FROM Customers
WHERE State IN ("VA", "FL", "GA");

SELECT *
FROM Customers
WHERE State NOT IN ("VA", "FL", "GA");

SELECT * 
FROM Products
WHERE quantity_in_stock IN (49, 38, 72); 

SELECT * 
FROM Customers
WHERE Points BETWEEN 1000 AND 3000;

SELECT *
FROM Customers
WHERE Birth_date BETWEEN "1990-01-01" AND "2000-01-01";

-- Using the LIKE command. This returns details about customers whose names start with b
SELECT *
FROM Customers
WHERE last_name LIKE "b%";

-- This will return details about all customers that have at least a 'b' in their last name, regardless of its location.
SELECT *
FROM Customers
WHERE last_name LIKE "%b%";

-- This will return details about all customers whose last name ends with a y
SELECT *
FROM Customers
WHERE last_name LIKE "%y";

-- This will return details about all customers whose last name ends with a y with exactly 6 characters in total
SELECT *
FROM Customers
WHERE last_name LIKE "_____y";

-- This will return details about all customers whose last name starts and ends with a  b and y with exactly 6 characters in total
SELECT *
FROM Customers
WHERE last_name LIKE "b____y";

-- Get the customers whose address contains trail or avenue
SELECT *
FROM Customers
WHERE address LIKE "%Trail%" OR  address LIKE "%Avenue%";

-- Get the customers whose phone ends with 9
SELECT *
FROM Customers
WHERE phone LIKE "%9";

-- REGEXP Statements

-- Get customers whose last name starts with b
SELECT *
FROM Customers
WHERE last_name REGEXP "^b";

-- Get Customers whose last name ends with field
SELECT *
FROM Customers
WHERE last_name REGEXP "field$";

-- Get Customers whose last name contains field, mac, rose
SELECT *
FROM Customers
WHERE last_name REGEXP "field|mac|rose";

SELECT *
FROM Customers
WHERE last_name REGEXP "field$|mac|rose";

-- Get details of customers whose last name conatain ge, ie, me 
SELECT *
FROM Customers
WHERE last_name REGEXP "[gim]e";

SELECT *
FROM Customers
WHERE last_name REGEXP "[a-h]e"; -- incase you have more than several characters

-- Get Customers whose first name contains elka or ambur
SELECT *
FROM Customers
WHERE first_name REGEXP "ELKA|AMBUR";

-- Get Customers whose last name ends with ey or on 
SELECT *
FROM Customers
WHERE last_name REGEXP "EY$|ON$";

-- Get Customers whose last name starts with my or contains se 
SELECT *
FROM Customers
WHERE last_name REGEXP "^MY|SE";

-- Get Customers whose last name contain b followed by r or u
-- 1
SELECT *
FROM Customers
WHERE last_name REGEXP "b[ru]";

-- 2 
SELECT *
FROM Customers
WHERE last_name REGEXP "br|bu";


-- IS NULL Function

-- Get Details of customers whose phone number is not in the database
SELECT *
FROM Customers
WHERE phone IS NULL;

-- Get details of customers whpse phone is in the database
SELECT *
FROM Customers
WHERE phone IS NOT NULL;


SELECT *
FROM Orders
WHERE shipped_date IS NULL;

-- ORDER BY Functions

SELECT *
FROM Customers
ORDER BY first_name DESC;

SELECT *
FROM Customers
ORDER BY state, first_name DESC;

SELECT *,
	quantity * unit_price AS Total_price
FROM Order_items
WHERE order_id = 2
ORDER BY Total_price DESC;

-- LIMIT Function

-- Get only 2 customers
SELECT *
FROM Customers
ORDER BY first_name DESC
LIMIT 2;

-- get the next 3 customers after the first 6
SELECT *
FROM Customers
LIMIT 6, 3;

SELECT *
FROM Customers
ORDER BY points DESC
LIMIT 3;

-- INNER JOIN Function
SELECT *
FROM Orders
INNER JOIN Customers 
ON orders.customer_id = customers.customer_id;

SELECT order_id, 
	c.first_name, 
    c.last_name, 
    c.birth_date
FROM Orders o
INNER JOIN Customers c
ON o.customer_id = c.customer_id;

SELECT oi.order_id,  oi.product_id, p.name, oi.quantity, oi.unit_price
FROM order_items oi
INNER JOIN products p
ON oi.product_id = p.product_id;

-- Joining across Databases
SELECT *
FROM order_items oi
INNER JOIN sql_inventory.products sip
ON oi.product_id = sip.product_id;

-- Joining Multiple Tables
SELECT *
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_statuses os
ON o.status = os.order_status_id;

SELECT o.order_id,
	o.order_date,
    c.first_name,
    c.last_name,
    os.name AS Status
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_statuses os
ON o.status = os.order_status_id;

-- Compound Join conditions
SELECT *
FROM order_items oi
INNER JOIN order_item_notes oin
ON oi.order_id = oin.order_id
AND oi.product_id = oin.product_id;