-- Joining Multiple Tables

USE sql_invoicing;

SELECT *
FROM payments p
INNER JOIN clients c
ON p.client_id = c.client_id
INNER JOIN payment_methods pm
ON p.payment_method= pm.payment_method_id;

SELECT p.date,
	p.invoice_id,
    p.amount,
    c.name,
    pm.name Type
FROM payments p
INNER JOIN clients c
ON p.client_id = c.client_id
INNER JOIN payment_methods pm
ON p.payment_method= pm.payment_method_id;


SELECT p.date,
	c.name as Customer,
    p.amount,
    pm.name Method
FROM payments p
INNER JOIN clients c
USING (client_id)
INNER JOIN payment_methods pm
ON p.payment_method= pm.payment_method_id;


-- Creating a copy of a Table
CREATE TABLE Invoices_archived AS
SELECT i.invoice_id,
		i.number,
        c.name Client,
        i.invoice_total,
        i.payment_total,
        i.invoice_date,
        i.payment_date,
        i.due_date
FROM invoices i
JOIN clients c
USING(client_id)
WHERE payment_date IS NOT NULL;

-- Updating a single row
UPDATE invoices
SET payment_total = 0, payment_date = NULL
WHERE invoice_id = 1;

UPDATE invoices
SET payment_total = invoice_total * 0.5, 
	payment_date = due_date
WHERE invoice_id = 3;

-- Updating Multiple rows
UPDATE invoices
SET payment_total = invoice_total * 0.5, 
	payment_date = due_date
WHERE client_id = 3;

-- Using Subqueries in Update
UPDATE invoices
SET payment_total = invoice_total * 0.5, 
	payment_date = due_date
WHERE client_id =
				(SELECT client_id
				FROM clients
				WHERE name = "Myworks");

UPDATE invoices
SET payment_total = invoice_total * 0.5, 
	payment_date = due_date
WHERE client_id IN
				(SELECT client_id
				FROM clients
				WHERE state IN ("CA", "NY" ));
                
-- Deleting Rows
DELETE FROM Invoices
WHERE client_id = (
				SELECT client_id
                FROM clients
                WHERE name = "Myworks");
			
-- Aggregate Function
SELECT 
	ROUND(MAX(invoice_total), 0)  AS Highest,
	ROUND(MIN(invoice_total), 1) AS Lowest,
	ROUND(AVG(invoice_total), 3) AS Average,
    SUM(invoice_total) AS Sum,
    COUNT(invoice_total) AS Number_of_Invoice,
    COUNT(payment_date) AS count_of_payment,
    COUNT(*) AS Total_records
FROM Invoices;

SELECT 
	ROUND(MAX(invoice_total), 0)  AS Highest,
	ROUND(MIN(invoice_total), 1) AS Lowest,
	ROUND(AVG(invoice_total), 3) AS Average,
    ROUND(SUM(invoice_total * 1.1), 0) AS Total,
    COUNT(*) AS Total_records,
    COUNT(DISTINCT client_id) AS Total_records
FROM invoices
WHERE invoice_date > "2019-07-01";


SELECT 
	"First Half of 2019" AS Date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) As payment_total,
    SUM(invoice_total - payment_total) AS WW_Expect
FROM Invoices
WHERE invoice_date
	BETWEEN "2019-01-01" AND "2019-06-30"
UNION
SELECT 
	"Second Half of 2019" AS Date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) As payment_total,
    SUM(invoice_total - payment_total) AS WW_Expect
FROM Invoices
WHERE invoice_date
	BETWEEN "2019-07-01" AND "2019-12-31"
UNION
SELECT 
	"Total" AS Date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) As payment_total,
    SUM(invoice_total - payment_total) AS WW_Expect
FROM Invoices
WHERE invoice_date
	BETWEEN "2019-01-01" AND "2019-12-31";

-- GROUPBY Clause
SELECT
	client_id, 
    SUM(Invoice_total) as Total_sales
FROM Invoices
WHERE invoice_date >= "2019-07-01"
GROUP BY client_id
ORDER BY Total_sales DESC;

SELECT
	state,
    city,
    SUM(Invoice_total) as Total_sales
FROM Invoices
JOIN clients USING (Client_id)
GROUP BY state, city
ORDER BY Total_sales DESC;

SELECT 
	date,
    pm.name AS payment_method,
    SUM(amount) AS total_payments
FROM payments p
JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id
GROUP BY date, payment_method
ORDER BY date;

-- HAVING Clause
SELECT
	client_id, 
    SUM(Invoice_total) AS Total_sales,
    COUNT(invoice_total) AS Number_of_invoices
FROM Invoices
GROUP BY client_id
HAVING  Total_sales > 500 AND NUmber_of_invoices > 5;
