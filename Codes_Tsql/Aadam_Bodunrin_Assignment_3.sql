-- Challenge 1: Generate Invoice Reports

-- 1. Retrieve customer orders
SELECT CompanyName,
       SalesOrderId,
       TotalDue
FROM SalesLT.Customer  sc
JOIN SalesLT.SalesOrderHeader soh
ON  sc.CustomerID = soh.CustomerID;

-- 2. Retrieve customer orders with addresses
SELECT a.AddressLine1,
       ISNULL(a.AddressLine2, '') as AddressLine2,
       a.City,
       a.StateProvince,
       a.PostalCode,
       a.CountryRegion,
       oh.SalesOrderID,
       oh.TotalDue
FROM SalesLT.Customer c
JOIN SalesLT.SalesOrderHeader oh
ON oh.CustomerID = c.CustomerID
JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = Ca.CustomerID AND AddressType = 'Main Office'
JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID;

-- Challenge 2: Retrieve Sales Data

-- 1. Retrieve a list of all customers and their orders
SELECT FirstName,
       LastName
       CompanyName,
       SalesOrderID,
       TotalDue
FROM SalesLT.Customer
LEFT JOIN SalesLT.SalesOrderHeader
ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
ORDER BY SalesOrderID DESC;

-- 2. Retrieve a list of customers with no address
SELECT sltc.CustomerID,
       CompanyName,
       FirstName + LastName AS ContactName,
       Phone
FROM SalesLT.Customer sltc
LEFT JOIN SalesLT.CustomerAddress sca
ON sltc.CustomerID = sca.CustomerID
WHERE sca.AddressID IS NULL;

-- 3. Retrieve a list of customers and products without orders
SELECT sltc.CustomerID, 
       sp.ProductID
FROM SalesLT.Customer  sltc
FULL OUTER JOIN SalesLT.SalesOrderHeader ssoh
ON sltc.CustomerID = ssoh.CustomerID
FULL OUTER JOIN SalesLT.SalesOrderDetail ssod
ON ssoh.SalesOrderID = ssod.SalesOrderID
FULL OUTER JOIN SalesLT.Product sp
ON ssod.ProductID = sp.ProductID
WHERE ssoh.SalesOrderID IS NULL;