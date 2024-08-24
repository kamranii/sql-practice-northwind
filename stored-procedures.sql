
-- CREATE PROCEDURE GetCompleteOrderInfo
-- AS 
-- BEGIN
--     SELECT * FROM Orders AS [OR]
--     JOIN [Order Details] AS [OD]
--     ON [OR].OrderID = OD.OrderID 
-- END

-- EXEC GetCompleteOrderInfo

-- CREATE PROCEDURE GetOrdersBasedOnTotalAmount
-- (@amount money = 5000)
-- AS
-- BEGIN
--     SELECT P.ProductName, (OD.UnitPrice * OD.Quantity * (1 - Discount)) AS [TotalOrderedAmount]
--     FROM [Order Details] AS[OD]
--     JOIN Products AS P
--     ON OD.ProductID = P.ProductID
--     WHERE (OD.UnitPrice * OD.Quantity * (1 - Discount)) > @amount
-- END

-- GO

-- EXEC GetOrdersBasedOnTotalAmount 8500
--
-- SELECT * FROM Colleges

-- GO
-- CREATE PROCEDURE sp_insert_new_college_get_id
-- (@college_code int, @college_name NVARCHAR(max), @college_id int output)
-- AS
-- BEGIN
--     INSERT Colleges (college_code, college_name) VALUES(@college_code, @college_name)
--     SELECT @college_id = SCOPE_IDENTITY();
-- END

-- DECLARE @last_added_college_id INT
-- EXEC sp_insert_new_college_get_id 546, 'BOTL', @last_added_college_id OUTPUT
-- SELECT @last_added_college_id

-- sp_helptext sp_insert_new_college_get_id

--Encrypted
-- CREATE PROCEDURE sp_get_suppliers_of_a_country
-- (@country NVARCHAR(max))
-- WITH ENCRYPTION
-- AS
-- BEGIN
--     SELECT CompanyName, City FROM Suppliers 
--     WHERE Country = @country
-- END

-- EXEC sp_get_suppliers_of_a_country 'USA'

-- sp_helptext sp_get_suppliers_of_a_country

-- CREATE PROCEDURE #sp_get_suppliers_of_a_city
-- (@city NVARCHAR(max))
-- AS
-- BEGIN
--     SELECT CompanyName, City, Country FROM Suppliers 
--     WHERE City = @city
-- END

-- EXEC #sp_get_suppliers_of_a_city 'london'
-- GO

-- ALTER PROCEDURE #sp_get_suppliers_of_a_city
-- (@city_keyword NVARCHAR(max))
-- AS
-- BEGIN
--     SELECT CompanyName, City, Country FROM Suppliers 
--     WHERE CHARINDEX(@city_keyword, City) > 0
-- END

-- EXEC #sp_get_suppliers_of_a_city 'in'

