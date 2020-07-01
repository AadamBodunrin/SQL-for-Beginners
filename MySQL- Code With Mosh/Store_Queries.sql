-- TO reset the root password; replace Mypass with a strong password
-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'Mypass';


-- To use a Database for your queries.
USE sql_store;

-- Generic SELECT syntax 
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
    
-- Further use case scenarios of WHERE syntax
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

-- Using the LIKE syntax. This returns details about customers whose names start with b
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

-- REGEXP Syntax

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


-- IS NULL syntax

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


-- Implicit Join syntax. P.S The explicit join syntax is better

SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;

-- OUTER JOIN syntax

SELECT *
FROM customers c
LEFT OUTER JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT *
FROM customers c
RIGHT OUTER JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT p.product_id,
	p.name,
    oi.quantity
FROM products p
LEFT OUTER JOIN order_items oi
ON p.product_id = oi.product_id;

-- OUTER JOIN between Multiple tables
SELECT c.customer_id,
	c.first_name,
    o.order_id,
    sh.name  AS Shipper
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
ON o.shipper_id = sh.shipper_id;


SELECT o.order_id,
	o.order_date,
    c.first_name Customer,
    sh.name Shipper,
    ors.name as Status
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
ON o.shipper_id = sh.shipper_id
INNER JOIN order_statuses ors
ON o.status = ors.order_status_id;

-- USING clause syntax
SELECT p.product_id,
	p.name,
    oi.quantity
FROM products p
LEFT OUTER JOIN order_items oi
-- ON p.product_id = oi.product_id
USING (product_id);


SELECT o.order_id,
	c.first_name,
    sh.name AS Shipper
FROM orders o
INNER JOIN customers c
USING (customer_id)
LEFT JOIN shippers sh
USING (shipper_id);

SELECT *
FROM Order_items 
INNER JOIN order_item_notes
USING (order_id, product_id);

-- NATURAL JOIN P.S Avoid NATURAL JOINS
SELECT o.order_id,
	c.first_name
FROM orders o
NATURAL JOIN customers c;

-- CROSS JOIN
SELECT c.first_name Customer,
	p.name Product
FROM customers c
CROSS JOIN products p
ORDER BY Customer;

SELECT c.first_name Customer,
	p.name Product
FROM customers c, products p
ORDER BY Customer;

SELECT sh.name Shipper,
	p.name  Product
FROM shippers sh, products p
ORDER BY Shipper;

SELECT sh.name Shipper,
	p.name  Product
FROM Shippers sh
CROSS JOIN products p
ORDER BY Shipper;


-- UNIONS
SELECT order_id,
	order_date,
    "Active" AS Status
FROM Orders
WHERE order_date >= "2019-01-01"
UNION
SELECT order_id,
	order_date,
    "Archive" AS Status
FROM Orders
WHERE order_date < "2019-01-01";

SELECT first_name
FROM Customers
UNION
SELECT name
FROM shippers;

SELECT customer_id,
	first_name,
    points,
    "Bronze" AS Type
FROM Customers
WHERE points < "2000"
UNION
SELECT customer_id,
	first_name,
    points,
    "Silver" AS Type
FROM Customers
WHERE points > "2000" AND points <= "3000"
UNION
SELECT customer_id,
	first_name,
    points,
    "Gold" AS Type
FROM Customers
WHERE points >= "3000" 
ORDER BY first_name;

SELECT customer_id,
	first_name,
    points,
    "Bronze" AS Type
FROM Customers
WHERE points < "2000"
UNION
SELECT customer_id,
	first_name,
    points,
    "Silver" AS Type
FROM Customers
WHERE points BETWEEN  "2000" AND "3000"
UNION
SELECT customer_id,
	first_name,
    points,
    "Gold" AS Type
FROM Customers
WHERE points >= "3000" 
ORDER BY first_name;

-- INSERTING a row

INSERT INTO Customers (
	first_name,
	last_name,
	birth_date,
    address,
    city,
    state)
VALUES (
    "John", 
    "Smith", 
    "1990-01-01",
    "address",
    "City",
    "CA");


-- INSERTING MULTIPLE ROWS
INSERT INTO shippers (name)
VALUES ("Shippers1"),
	   ("Shippers2"),
       ("Shippers3");
       
       
INSERT INTO Products (
		product_id,
        name,
        quantity_in_stock,
        unit_price)
VALUES  (DEFAULT, "Product1", "10", "3.1"),
		(DEFAULT, "Product2", "12", "2.1"),
        (DEFAULT, "Product3", "13", "7.1");
        
        
-- INSERTING Hierarchial rows
INSERT INTO orders (
		Customer_id, 
        order_date, 
        status)
VALUES  (1, "2019-01-02", 1);

INSERT INTO order_items
VALUES  (LAST_INSERT_ID(), 1, 1, "2.95"),
		(LAST_INSERT_ID(), 2, 1, "3.95");

-- Creating a copy of a Table
CREATE TABLE orders_archive AS
SELECT * FROM orders;


INSERT INTO orders_archive
SELECT *
FROM orders
WHERE order_date < "2019-01-01";

-- Updating Multiple rows
UPDATE Customers
SET points = points + 50
WHERE birth_date < "1990-01-01";

UPDATE orders
SET Comments = "Gold Customers"
WHERE Customer_id IN
					(SELECT Customer_id
                    FROM Customers
                    WHERE Points > 3000);
                    
