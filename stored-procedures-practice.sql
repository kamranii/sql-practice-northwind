--CREATE A SAMPLE SP
DROP PROCEDURE IF EXISTS sp_get_all_customers
GO
CREATE PROCEDURE sp_get_all_customers
AS
BEGIN
    SELECT * FROM Customers
END

EXEC sp_get_all_customers

--SP TO RETRIEVE ONLY ONE ROW
GO
USE Northwind
DROP PROCEDURE IF EXISTS sp_products_get_by_id
GO
CREATE PROCEDURE sp_products_get_by_id
(@id INT)
AS 
BEGIN 
    SELECT * FROM Products 
    WHERE ProductID = @id
END

EXEC sp_products_get_by_id 22

--SP TO INSERT A ROW
DROP PROCEDURE IF EXISTS sp_employees_insert_row
GO
CREATE PROCEDURE sp_employees_insert_row
(@lastname nvarchar(max), @firstname nvarchar(max), @title nvarchar(max), @titleOfCourtesy nvarchar(20), @city nvarchar(20),
@hireDate DATE)
AS 
BEGIN
    INSERT Employees (LastName, FirstName, Title, TitleOfCourtesy, City, HireDate)
    VALUES(@lastname, @firstname, @title, @titleOfCourtesy, @city, GETDATE())
END
EXEC sp_employees_insert_row 'Aliyev', 'Aziz', 'Software Engineer', 'Mr.', 'Baku', NULL

GO
CREATE PROCEDURE sp_territories_get_details
(@territoryName as nvarchar(max))
AS 
SELECT T.TerritoryDescription, R.RegionDescription FROM Territories
AS T JOIN Region AS R ON T.RegionID = R.RegionID
WHERE T.TerritoryDescription = @territoryName

DECLARE @return_value INT
EXEC @return_value = sp_territories_get_details 34
SELECT 'Return Value' = @return_value
GO

SELECT SUSER_NAME();
SELECT SUSER_SNAME();