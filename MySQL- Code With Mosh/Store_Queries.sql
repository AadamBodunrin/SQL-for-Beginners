-- TO reset the root password; replace Mypass with a strong password
-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'Mypass';


USE sql_store;

SELECT *
FROM customers;

    
SELECT *
FROM Customers
WHERE State = "FL"
ORDER BY First_name;
    
SELECT first_name, last_name,
    points,
    Points + 10 * 100,
    (points + 10) * 100  Sub
FROM Customers;

SELECT DISTINCT state
FROM Customers;
    
SELECT name, Unit_price,
	Unit_price * 1.1 New_price
FROM products;

SELECT *
FROM Customers
WHERE Points > 3000;

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