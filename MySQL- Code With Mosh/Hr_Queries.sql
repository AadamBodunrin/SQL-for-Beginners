USE sql_hr;

SELECT *
FROM employees;

-- SELF JOIN

SELECT e.employee_id,
	e.first_name,
    em.first_name Manager
FROM employees e
INNER JOIN employees em
ON e.reports_to = em.employee_id;

-- SELF OUTER JOIN syntax

SELECT e.employee_id,
	e.first_name,
    em.first_name Manager
FROM employees e
LEFT JOIN employees em
ON e.reports_to = em.employee_id;