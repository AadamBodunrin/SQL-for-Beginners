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