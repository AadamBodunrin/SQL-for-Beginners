-- Challenge 1: Retrieve Customer Addresses

-- 1. Retrieve billing addresses

SELECT SalesLT.Customer.CompanyName,
       SalesLT.Address.AddressLine1,
       SalesLT.Address.City,
       SalesLT.CustomerAddress.AddressType,
       'Billing' AS AddressType
FROM SalesLT.Customer
JOIN SalesLT.CustomerAddress  
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID
JOIN SalesLT.Address
ON SalesLT.CustomerAddress.AddressID = SalesLT.Address.AddressID
WHERE SalesLT.CustomerAddress.AddressType = 'Main Office';

-- 2. Retrieve shipping addresses
SELECT SalesLT.Customer.CompanyName,
       SalesLT.Address.AddressLine1,
       SalesLT.Address.City,
       SalesLT.CustomerAddress.AddressType,
       'Shipping' As AddressType
FROM SalesLT.Customer
JOIN SalesLT.CustomerAddress  
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID 
JOIN SalesLT.Address
ON SalesLT.CustomerAddress.AddressID = SalesLT.Address.AddressID
WHERE SalesLT.CustomerAddress.AddressType = 'Shipping';

-- 3. Combine billing and shipping addresses
SELECT SalesLT.Customer.CompanyName,
       SalesLT.Address.AddressLine1,
       SalesLT.Address.City,
       SalesLT.CustomerAddress.AddressType,
       'Billing' AS AddressType
FROM SalesLT.Customer
JOIN SalesLT.CustomerAddress  
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID
JOIN SalesLT.Address
ON SalesLT.CustomerAddress.AddressID = SalesLT.Address.AddressID
WHERE SalesLT.CustomerAddress.AddressType = 'Main Office'
UNION ALL
SELECT SalesLT.Customer.CompanyName,
       SalesLT.Address.AddressLine1,
       SalesLT.Address.City,
       SalesLT.CustomerAddress.AddressType,
       'Shipping' As AddressType
FROM SalesLT.Customer
JOIN SalesLT.CustomerAddress  
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID 
JOIN SalesLT.Address
ON SalesLT.CustomerAddress.AddressID = SalesLT.Address.AddressID
WHERE SalesLT.CustomerAddress.AddressType = 'Shipping';

-- Challenge 2: Filter Customer Addresses

-- 1. Retrieve customers with only a main office address
SELECT SalesLT.Customer.CompanyName
FROM SalesLT.Customer
JOIN SalesLT.CustomerAddress  
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID 
JOIN SalesLT.Address
ON SalesLT.CustomerAddress.AddressID = SalesLT.Address.AddressID
WHERE SalesLT.CustomerAddress.AddressType = 'Main Office'
EXCEPT
SELECT SalesLT.Customer.CompanyName
FROM SalesLT.Customer
JOIN SalesLT.CustomerAddress  
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID 
JOIN SalesLT.Address
ON SalesLT.CustomerAddress.AddressID = SalesLT.Address.AddressID
WHERE SalesLT.CustomerAddress.AddressType = 'Shipping'
ORDER BY SalesLT.Customer.CompanyName, SalesLT.CustomerAddress.AddressType;


-- 2. Retrieve only customers with both a main office address and a shipping address
SELECT SalesLT.Customer.CompanyName
FROM SalesLT.Customer
JOIN SalesLT.CustomerAddress  
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID 
JOIN SalesLT.Address
ON SalesLT.CustomerAddress.AddressID = SalesLT.Address.AddressID
WHERE SalesLT.CustomerAddress.AddressType = 'Main Office'
INTERSECT
SELECT SalesLT.Customer.CompanyName
FROM SalesLT.Customer
JOIN SalesLT.CustomerAddress  
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID 
JOIN SalesLT.Address
ON SalesLT.CustomerAddress.AddressID = SalesLT.Address.AddressID
WHERE SalesLT.CustomerAddress.AddressType = 'Shipping'
ORDER BY SalesLT.Customer.CompanyName, SalesLT.CustomerAddress.AddressType;
