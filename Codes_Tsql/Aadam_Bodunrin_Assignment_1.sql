-- Challenge 1: Retrieve Customer Data 

-- 1. Retrieve customer details

SELECT *
FROM SalesLT.Customer;

-- 2. Retrieve customer name data

SELECT Title,
       FirstName,
       MiddleName,
       LastName,
       Suffix
FROM SalesLT.Customer;

-- 3. Retrieve customer names and phone numbers

SELECT SalesPerson,
       Title + ' ' + FirstName AS CUSTOMERNAME,
       Phone
FROM SalesLT.Customer;

-- Challenge 2: Retrieve Customer and Sales Data

-- 1. Retrieve a list of customer companies

SELECT CONVERT(varchar(5), CustomerID) + ': ' + CompanyName AS CustomerComapany
FROM SalesLT.Customer;

-- 2. Retrieve a list of sales order revisions

SELECT SalesOrderNumber  + ' (' + CONVERT(nvarchar(30), RevisionNumber) + ')',
       CONVERT(nvarchar(30), OrderDate, 102) AS ANSI
FROM SalesLT.SalesOrderHeader;

-- Challenge 3: Retrieve Customer Contact Details

-- 1. Retrieve customer contact names with middle names if known
SELECT firstname + ' ' + ISNULL(middlename, ' ') + ' ' +lastname 
FROM SalesLT.Customer;

-- 2. Retrieve primary contact details
SELECT CustomerID, COALESCE(EmailAddress, Phone) AS PrimaryContact 
FROM SalesLT.Customer;

-- 3. Retrieve shipping status 

SELECT SalesOrderID, OrderDate,
    CASE 
        WHEN ShipDate IS NULL THEN  'Known Ship Date'
        ELSE 'Awaiting Shipment'
        END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;