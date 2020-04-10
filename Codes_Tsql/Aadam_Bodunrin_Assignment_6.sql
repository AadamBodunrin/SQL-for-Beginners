-- Challenge 1: Retrieve Product Price Information

-- 1. Retrieve products whose list price is higher than the average unit price
SELECT ProductID,
       Name,
       ListPrice
FROM SalesLT.Product
WHERE ListPrice > 
(SELECT AVG(UnitPrice) FROM SalesLT.OrderDetails)
ORDER BY ProductID;

-- 2. Retrieve Products with a list price of $100 or more that have been sold for less than $100
SELECT ProductID,
       Name,
       ListPrice
FROM SalesLT.Product SO1
WHERE ProductID IN
(SELECT ProductID FROM SalesLT.OrderDetails WHERE UnitPrice < 100 AND ListPrice >= 100)
ORDER BY ProductID;

-- 3. Retrieve the cost, list price, and average selling price for each product

SELECT ProductID, Name, StandardCost, ListPrice,
    (SELECT AVG(UnitPrice)
     FROM SalesLT.SalesOrderDetail AS SOD
     WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS P
ORDER BY P.ProductID;

-- 4. Retrieve products that have an average selling price that is lower than the cost
SELECT ProductID, Name, StandardCost, ListPrice,
(SELECT AVG(UnitPrice)
 FROM SalesLT.SalesOrderDetail AS SOD
 WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS P
WHERE StandardCost >
(SELECT AVG(UnitPrice)
 FROM SalesLT.SalesOrderDetail AS SOD
 WHERE P.ProductID = SOD.ProductID)
ORDER BY P.ProductID;


-- Challenge 2: Retrieve Customer Information

-- 1. Retrieve customer information for all sales orders
SELECT SOH.SalesOrderID, 
       SOH.CustomerID,
       CI.FirstName,
       CI.LastName,
       SOH.TotalDue
FROM SalesLT.SalesOrderHeader SOH
CROSS APPLY dbo.ufnGetCustomerInformation(SOH.CustomerID) AS CI
ORDER BY SOH.SalesOrderID;

-- 2. Retrieve customer address information
SELECT CA.CustomerID, 
       CI.FirstName, 
       CI.LastName, 
       A.AddressLine1, 
       A.City
FROM SalesLT.Address AS A
JOIN SalesLT.CustomerAddress AS CA
ON A.AddressID = CA.AddressID
CROSS APPLY dbo.ufnGetCustomerInformation(CA.CustomerID) AS CI
ORDER BY CA.CustomerID;