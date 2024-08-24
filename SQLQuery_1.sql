UPDATE Products 
SET Products.ProductName = Categories.CategoryName
FROM Products 
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID

UPDATE TOP(30) Products
SET ProductName = 'X'
SELECT CONCAT_WS('-',FirstName, LastName, CategoryName) FROM Employees CROSS JOIN Categories

SELECT ProductName,
CASE 
WHEN UnitPrice < 50 THEN 'CIN MALI'
WHEN UnitPrice BETWEEN 50 AND 100 THEN 'UCUZ'
WHEN UnitPrice BETWEEN 100 AND 200 THEN 'NORMAL'
WHEN UnitPrice > 200 THEN 'BAHALI'
ELSE 'UnitPrice'
END
AS PIRIYS
FROM Products

SELECT * FROM Products, Suppliers

SELECT SOUNDEX(CompanyName) FROM Customers
SELECT CompanyName FROM Customers

INSERT Territories (TerritoryID, TerritoryDescription, RegionID) 
VALUES (88888, 'GANJA', 2),
(77777, 'MOSCOW', 1)

CREATE TABLE Colleges (
  college_id INT IDENTITY(1,1),
  college_code VARCHAR(20) NOT NULL,
  college_name VARCHAR(50),
  CONSTRAINT CollegePK PRIMARY KEY (college_id)
);
INSERT Colleges (college_code, college_name) VALUES(546, 'BOTL'), (512, 'SOTL')

INSERT INTO Categories (CategoryName, [Description])
SELECT FirstName, Address FROM Employees

DECLARE @MYyTable TABLE (
    ID [INT] NOT NULL, 
    Description NVARCHAR(20))
INSERT INTO @MYyTable SELECT TerritoryID, TerritoryDescription FROM Territories

UPDATE @MYyTable
SET [Description] = 'BAKU'
WHERE ID = 1581

SELECT ID, [Description]
FROM @MYyTable
WHERE ID > 1500

UNION ALL

SELECT TerritoryID, TerritoryDescription
FROM Territories

UPDATE @MYyTable 
SET [Description] = ContactTitle
FROM Suppliers 
WHERE ID > SupplierID

SELECT * FROM @MYyTable

SELECT TerritoryID, TerritoryDescription, RegionID FROM Territories
ORDER BY CASE RegionID
WHEN 1 THEN TerritoryID END DESC,
CASE WHEN REGIONID = 2 THEN TerritoryID END DESC,
CASE WHEN RegionID = 3 THEN TerritoryID END ASC,
CASE WHEN RegionID = 4 THEN TerritoryID END ASC

SHOW DATABASES
