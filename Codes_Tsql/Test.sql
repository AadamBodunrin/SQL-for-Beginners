SELECT *
FROM salesLT.Product;

SELECT Name,
    ListPrice
FROM salesLT.Product;

SELECT Name,
    StandardCost,
    ListPrice
FROM SalesLT.Product;

SELECT ProductID,
       Name,
       ListPrice,
       StandardCost
FROM SalesLT.Product;

SELECT Name,
       ProductNumber,
       color,
       ListPrice
FROM SalesLT.Product;

SELECT Name,
    ListPrice - StandardCost
FROM SalesLT.Product;


SELECT Name,
    ListPrice - StandardCost AS Markup
FROM SalesLT.Product;


SELECT ProductNumber,
    Color,
    Size,
    Color + ', ' + Size AS ProductDetails
FROM SalesLT.Product;


SELECT CAST(ProductID AS varchar(5)) + ': ' + Name AS ProductName
FROM SalesLT.Product;

SELECT CONVERT(varchar(5), ProductID) + ': ' + Name AS ProductName
FROM SalesLT.Product;

SELECT SellStartDate,
    CONVERT(nvarchar(30), SellStartDate) AS ConvertedDate,
    CONVERT(nvarchar(30), SellStartDate, 126) AS ISO8601FormatDate
FROM SalesLT.Product;

SELECT Name,
    TRY_CAST (Size AS Integer) AS NumericSize
FROM SalesLT.Product;
--(note incompatible sizes are returned as NULL)

SELECT Name, ISNULL(TRY_CAST(Size AS Integer),0) AS NumericSize
FROM SalesLT.Product;

SELECT ProductNumber,
    ISNULL(Color, '') + ', ' + ISNULL(Size, '') AS ProductDetails
FROM SalesLT.Product;

SELECT Name,
    NULLIF(Color, 'Multi') AS SingleColor
FROM SalesLT.Product;

SELECT Name, COALESCE(DiscontinuedDate, SellEndDate, SellStartDate) AS FirstNonNullDate
FROM SalesLT.Product;

--Searched case
SELECT Name,
    CASE
			WHEN SellEndDate IS NULL THEN 'On Sale'
			ELSE 'Discontinued'
		END AS SalesStatus
FROM SalesLT.Product;

--Simple case
SELECT Name,
    CASE Size
			WHEN 'S' THEN 'Small'
			WHEN 'M' THEN 'Medium'
			WHEN 'L' THEN 'Large'
			WHEN 'XL' THEN 'Extra-Large'
			ELSE ISNULL(Size, 'n/a')
		END AS ProductSize
FROM SalesLT.Product;

--Display a list of product colors
SELECT Color 
FROM SalesLT.Product;

--Display a list of product colors with the word 'None' if the value is null
SELECT DISTINCT ISNULL(Color, 'None') AS Color 
FROM SalesLT.Product;

--Display a list of product colors with the word 'None' if the value is null sorted by color
SELECT DISTINCT ISNULL(Color, 'None') AS Color 
FROM SalesLT.Product 
ORDER BY Color;

--Display a list of product colors with the word 'None' if the value is null and a dash if the size is null sorted by color
SELECT DISTINCT ISNULL(Color, 'None') AS Color, ISNULL(Size, '-') AS Size 
FROM SalesLT.Product ORDER BY Color;


--Display the top 100 products by list price
SELECT TOP 100 Name, 
       ListPrice 
FROM SalesLT.Product 
ORDER BY ListPrice DESC;

--Display the first ten products by product number
SELECT Name, 
       ListPrice 
FROM SalesLT.Product 
ORDER BY ProductNumber OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY; 

--List information about product model 6
SELECT Name, 
       Color, 
       Size 
FROM SalesLT.Product 
WHERE ProductModelID = 6;

--List information about products that have a product number beginning FR
SELECT productnumber,
       Name, 
       ListPrice 
FROM SalesLT.Product 
WHERE ProductNumber LIKE 'FR%';

--Filter the previous query to ensure that the product number contains two sets of two didgets
SELECT Name, 
       ListPrice 
FROM SalesLT.Product 
WHERE ProductNumber LIKE 'FR-_[0-9][0-9]_-[0-9][0-9]';

--Find products that have no sell end date
SELECT Name 
FROM SalesLT.Product 
WHERE SellEndDate IS NOT NULL;

--Find products that have a sell end date in 2006
SELECT Name 
FROM SalesLT.Product 
WHERE SellEndDate BETWEEN '2006/1/1' AND '2006/12/31';

--Find products that have a category ID of 5, 6, or 7.
SELECT ProductCategoryID, 
       Name, 
       ListPrice 
FROM SalesLT.Product 
WHERE ProductCategoryID IN (5, 6, 7);

--Find products that have a category ID of 5, 6, or 7 and have a sell end date
SELECT ProductCategoryID, 
       Name, ListPrice, 
       SellEndDate 
FROM SalesLT.Product 
WHERE ProductCategoryID IN (5, 6, 7) AND SellEndDate IS NULL;

--Select products that have a category ID of 5, 6, or 7 and a product number that begins FR
SELECT Name, 
       ProductCategoryID, 
       ProductNumber 
FROM SalesLT.Product 
WHERE ProductNumber LIKE 'FR%' OR ProductCategoryID IN (5,6,7);

--Basic inner join
SELECT SalesLT.Product.Name As ProductName, 
    SalesLT.ProductCategory.Name AS Category
FROM SalesLT.Product
INNER JOIN SalesLT.ProductCategory
ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID;

-- Table aliases
SELECT p.Name As ProductName, 
       c.Name AS Category
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory As c
ON p.ProductCategoryID = c.ProductCategoryID;

-- Joining more than 2 tables
SELECT oh.OrderDate, 
       oh.SalesOrderNumber, 
       p.Name As ProductName, 
       od.OrderQty, 
       od.UnitPrice, 
       od.LineTotal
FROM SalesLT.SalesOrderHeader AS oh
JOIN SalesLT.SalesOrderDetail AS od
ON od.SalesOrderID = oh.SalesOrderID
JOIN SalesLT.Product AS p
ON od.ProductID = p.ProductID
ORDER BY oh.OrderDate, oh.SalesOrderID, od.SalesOrderDetailID;

-- Multiple join predicates
SELECT oh.OrderDate, 
       oh.SalesOrderNumber, 
       p.Name As ProductName, 
       od.OrderQty, 
       od.UnitPrice, 
       od.LineTotal
FROM SalesLT.SalesOrderHeader AS oh
JOIN SalesLT.SalesOrderDetail AS od
ON od.SalesOrderID = oh.SalesOrderID
JOIN SalesLT.Product AS p
ON od.ProductID = p.ProductID AND od.UnitPrice = p.ListPrice --Note multiple predicates
ORDER BY oh.OrderDate, oh.SalesOrderID, od.SalesOrderDetailID; 

--Get all customers, with sales orders for those who've bought anything
SELECT c.FirstName, 
       c.LastName, 
       oh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
ORDER BY c.CustomerID;

--Return only customers who haven't purchased anything
SELECT c.FirstName, 
       c.LastName, 
       oh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
WHERE oh.SalesOrderNumber IS NULL 
ORDER BY c.CustomerID;


--More than 2 tables
SELECT p.Name As ProductName, 
       oh.SalesOrderNumber
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS od
ON p.ProductID = od.ProductID
LEFT JOIN SalesLT.SalesOrderHeader AS oh --Additional tables added to the right must also use a left join
ON od.SalesOrderID = oh.SalesOrderID
ORDER BY p.ProductID;


SELECT p.Name As ProductName, 
       c.Name AS Category, 
       oh.SalesOrderNumber
FROM SalesLT.Product AS p
LEFT OUTER JOIN SalesLT.SalesOrderDetail AS od
ON p.ProductID = od.ProductID
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS oh
ON od.SalesOrderID = oh.SalesOrderID
INNER JOIN SalesLT.ProductCategory AS c --Added to the left, so can use inner join
ON p.ProductCategoryID = c.ProductCategoryID
ORDER BY p.ProductID;

--Call each customer once per product
SELECT p.Name, 
       c.FirstName, 
       c.LastName, 
       c.Phone
FROM SalesLT.Product as p
CROSS JOIN SalesLT.Customer as c;

--note there's no employee table, so we'll create one for this example
CREATE TABLE SalesLT.Employee
(EmployeeID int IDENTITY PRIMARY KEY,
EmployeeName nvarchar(256),
ManagerID int);
GO
-- Get salesperson from Customer table and generate managers
INSERT INTO SalesLT.Employee (EmployeeName, ManagerID)
SELECT DISTINCT Salesperson, NULLIF(CAST(RIGHT(SalesPerson, 1) as INT), 0)
FROM SalesLT.Customer;
GO
UPDATE SalesLT.Employee
SET ManagerID = (SELECT MIN(EmployeeID) FROM SalesLT.Employee WHERE ManagerID IS NULL)
WHERE ManagerID IS NULL
AND EmployeeID > (SELECT MIN(EmployeeID) FROM SalesLT.Employee WHERE ManagerID IS NULL);
GO
 
-- Here's the actual self-join demo
SELECT e.EmployeeName, m.EmployeeName AS ManagerName
FROM SalesLT.Employee AS e
LEFT JOIN SalesLT.Employee AS m
ON e.ManagerID = m.EmployeeID
ORDER BY e.ManagerID;

-- Setup
CREATE VIEW SalesLT.Customers
as
select distinct firstname,lastname
from saleslt.customer
where lastname >='m'
or customerid=3;
GO

CREATE VIEW SalesLT.Employees
as
select distinct firstname,lastname
from saleslt.customer
where lastname <='m'
or customerid=3;
GO

-- Union example
SELECT FirstName, LastName
FROM SalesLT.Employees
UNION
SELECT FirstName, LastName
FROM SalesLT.Customers
ORDER BY LastName;

SELECT FirstName, LastName
FROM SalesLT.Customers
INTERSECT
SELECT FirstName, LastName
FROM SalesLT.Employees;

SELECT FirstName, LastName
FROM SalesLT.Customers
EXCEPT
SELECT FirstName, LastName
FROM SalesLT.Employees;



-- Scalar functions
SELECT YEAR(SellStartDate) SellStartYear, ProductID, Name
FROM SalesLT.Product
ORDER BY SellStartYear;

SELECT YEAR(SellStartDate) SellStartYear, DATENAME(mm,SellStartDate) SellStartMonth,
       DAY(SellStartDate) SellStartDay, DATENAME(dw, SellStartDate) SellStartWeekday,
	   ProductID, Name
FROM SalesLT.Product
ORDER BY SellStartYear;

SELECT DATEDIFF(yy,SellStartDate, GETDATE()) YearsSold, ProductID, Name
FROM SalesLT.Product
ORDER BY ProductID;

SELECT UPPER(Name) AS ProductName
FROM SalesLT.Product;

SELECT CONCAT(FirstName + ' ', LastName) AS FullName
FROM SalesLT.Customer;

SELECT Name, ProductNumber, LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product;

SELECT Name, ProductNumber, LEFT(ProductNumber, 2) AS ProductType,
                            SUBSTRING(ProductNumber,CHARINDEX('-', ProductNumber) + 1, 4) AS ModelCode,
							SUBSTRING(ProductNumber, LEN(ProductNumber) - CHARINDEX('-', REVERSE(RIGHT(ProductNumber, 3))) + 2, 2) AS SizeCode
FROM SalesLT.Product;


-- Logical functions
SELECT Name, Size AS NumericSize
FROM SalesLT.Product
WHERE ISNUMERIC(Size) = 1;

SELECT Name, IIF(ProductCategoryID IN (5,6,7), 'Bike', 'Other') ProductType
FROM SalesLT.Product;

SELECT Name, IIF(ISNUMERIC(Size) = 1, 'Numeric', 'Non-Numeric') SizeType
FROM SalesLT.Product;

SELECT prd.Name AS ProductName, cat.Name AS Category,
      CHOOSE (cat.ParentProductCategoryID, 'Bikes','Components','Clothing','Accessories') AS ProductType
FROM SalesLT.Product AS prd
JOIN SalesLT.ProductCategory AS cat
ON prd.ProductCategoryID = cat.ProductCategoryID;


-- Window functions
SELECT TOP(100) ProductID, Name, ListPrice,
	RANK() OVER(ORDER BY ListPrice DESC) AS RankByPrice
FROM SalesLT.Product AS p
ORDER BY RankByPrice;

SELECT c.Name AS Category, p.Name AS Product, ListPrice,
	RANK() OVER(PARTITION BY c.Name ORDER BY ListPrice DESC) AS RankByPrice
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS c
ON p.ProductCategoryID = c.ProductcategoryID
ORDER BY Category, RankByPrice;


-- Aggregate Functions
SELECT COUNT(*) AS Products, COUNT(DISTINCT ProductCategoryID) AS Categories, AVG(ListPrice) AS AveragePrice
FROM SalesLT.Product;

SELECT COUNT(p.ProductID) BikeModels, AVG(p.ListPrice) AveragePrice
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS c
ON p.ProductCategoryID = c.ProductCategoryID
WHERE c.Name LIKE '%Bikes';




SELECT Salesperson, COUNT(CustomerID) Customers
FROM SalesLT.Customer
GROUP BY Salesperson
ORDER BY Salesperson;

SELECT c.Name AS Category, COUNT(p.ProductID) AS Products
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS c
ON p.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name
ORDER BY Category;

SELECT c.Salesperson, SUM(oh.SubTotal) SalesRevenue
FROM SalesLT.Customer c
JOIN SalesLT.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID
GROUP BY c.Salesperson
ORDER BY SalesRevenue DESC;

SELECT c.Salesperson, ISNULL(SUM(oh.SubTotal), 0.00) SalesRevenue
FROM SalesLT.Customer c
LEFT JOIN SalesLT.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID
GROUP BY c.Salesperson
ORDER BY SalesRevenue DESC;

SELECT c.Salesperson, CONCAT(c.FirstName +' ', c.LastName) AS Customer, ISNULL(SUM(oh.SubTotal), 0.00) SalesRevenue
FROM SalesLT.Customer c
LEFT JOIN SalesLT.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID
GROUP BY c.Salesperson, CONCAT(c.FirstName +' ', c.LastName)
ORDER BY SalesRevenue DESC, Customer;


-- Try to find salespeople with over 150 customers (fails with error)
SELECT Salesperson, COUNT(CustomerID) Customers
FROM SalesLT.Customer
WHERE COUNT(CustomerID) > 100
GROUP BY Salesperson
ORDER BY Salesperson;

--Need to use HAVING clause to filter based on aggregate
SELECT Salesperson, COUNT(CustomerID) Customers
FROM SalesLT.Customer
GROUP BY Salesperson
HAVING COUNT(CustomerID) > 100
ORDER BY Salesperson;




--Display a list of products whose list price is higher than the highest unit price of items that have sold

SELECT MAX(UnitPrice) FROM SalesLT.SalesOrderDetail

SELECT * from SalesLT.Product
WHERE ListPrice > 1466.01


SELECT * from SalesLT.Product
WHERE ListPrice >
(SELECT MAX(UnitPrice) FROM SalesLT.SalesOrderDetail);


--List products that have an order quantity greater than 20

SELECT Name FROM SalesLT.Product
WHERE ProductID IN
(SELECT ProductID from SalesLT.SalesOrderDetail
WHERE OrderQty>20)

SELECT Name 
FROM SalesLT.Product P
JOIN SalesLT.SalesOrderDetail SOD
ON P.ProductID=SOD.ProductID
WHERE OrderQty>20


--For each customer list all sales on the last day that they made a sale

SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader AS SO1
ORDER BY CustomerID,OrderDate

SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader AS SO1
WHERE orderdate =
(SELECT MAX(orderdate)
FROM SalesLT.SalesOrderHeader)


SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader AS SO1
WHERE orderdate =
(SELECT MAX(orderdate)
FROM SalesLT.SalesOrderHeader AS SO2
WHERE SO2.CustomerID = SO1.CustomerID)
ORDER BY CustomerID



-- Setup
CREATE FUNCTION SalesLT.udfMaxUnitPrice (@SalesOrderID int)
RETURNS TABLE
AS
RETURN
SELECT SalesOrderID,Max(UnitPrice) as MaxUnitPrice FROM 
SalesLT.SalesOrderDetail
WHERE SalesOrderID=@SalesOrderID
GROUP BY SalesOrderID;

--Display the sales order details for items that are equal to
-- the maximum unit price for that sales order
SELECT * FROM SalesLT.SalesOrderDetail AS SOH
CROSS APPLY SalesLT.udfMaxUnitPrice(SOH.SalesOrderID) AS MUP
WHERE SOH.UnitPrice=MUP.MaxUnitPrice
ORDER BY SOH.SalesOrderID;
