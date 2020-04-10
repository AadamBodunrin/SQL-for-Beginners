-- Challenge 1: Retrieve Product Information

-- 1. Retrieve the name and approximate weight of each product
SELECT ProductID ,
       UPPER(Name) AS ProductName, 
       ROUND(SalesLT.Weight, 0) AS ApproxWeight
FROM SalesLT.Product;
       

-- 2. Retrieve the year and month in which products were first sold
SELECT ProductID ,
       UPPER(Name), 
       ROUND(SalesLT.Weight, 0) AS ApproxWeight,
       YEAR(SellStartDate) AS SellStartYear, 
       YEAR(M, SellStartDate) AS SellStartMonth
FROM SalesLT.Product;

-- 3. Extract product types from product numbers
SELECT ProductID ,
       UPPER(Name), 
       ROUND(SalesLT.Weight, 0) AS ApproxWeight,
       YEAR(SellStartDate) AS SellStartYear, 
       YEAR(M, SellStartDate) AS SellStartMonth,
       LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product;

-- 4. Retrieve only products with a numeric size
SELECT ProductID ,
       UPPER(Name), 
       ROUND(SalesLT.Weight, 0) AS ApproxWeight,
       YEAR(SellStartDate) AS SellStartYear, 
       YEAR(M, SellStartDate) AS SellStartMonth,
       LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product
WHERE ISNUMERIC(size) = 1;


--Challenge 2: Rank Customers by Revenue

-- 1. Retrieve companies ranked by sales totals
SELECT CompanyName,
       TotalDue AS Revenue,
       RANK()OVER(ORDER BY TotalDue DESC) AS RankBySales
FROM SalesLT.OrderHeader
JOIN SaleLT.Customer
ON SalesLT.OrderHeader.CustomerID = SaleLT.Customer.CustomerID ;


-- Challenge 3: Aggregate Product Sales

-- 1. Retrieve total sales by product

SELECT Name,
       SUM(SalesLT.SalesOrderDetail.LineTotal) AS TotalRevenue
FROM SalesLT.Product
JOIN SalesLT.SalesOrderDetail
ON SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
GROUP BY SalesLT.Product.Name
ORDER BY TotalRevenue DESC;


-- 2. Filter the product sales list to include only products that cost over $1,000
SELECT Name,
       SUM(SalesLT.SalesOrderDetail.LineTotal) AS TotalRevenue
FROM SalesLT.Product
JOIN SalesLT.SalesOrderDetail
ON SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
WHERE Sales.Product.ListPrice > 1000
ORDER BY TotalRevenue DESC;


-- 3. Filter the product sales groups to include only total sales over $20,000
SELECT Name,
       SUM(SalesLT.SalesOrderDetail.LineTotal) AS TotalRevenue
FROM SalesLT.Product
JOIN SalesLT.SalesOrderDetail
ON SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
WHERE Sales.Product.ListPrice > 1000
GROUP BY SalesLT.Product.Name
HAVING SUM(LineTotal) > 20000
ORDER BY TotalRevenue DESC;