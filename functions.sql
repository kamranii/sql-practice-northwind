--Scalar function

-- CREATE FUNCTION fn_expensive_or_cheap(@unitPrice money)
-- RETURNS CHAR(9)
-- AS
-- BEGIN
--     DECLARE @price_comment CHAR(9);
--     SET @price_comment = 'average';
--     IF(@unitPrice < 20) SET @price_comment = 'cheap';
--     IF(@unitPrice > 50) SET @price_comment = 'expensive';
--     RETURN @price_comment;
-- END

-- SELECT UnitPrice FROM Products ORDER BY UnitPrice DESC

-- SELECT ProductName, UnitPrice, (dbo.fn_expensive_or_cheap(UnitPrice)) AS [Price Comment]  FROM Products WHERE UnitPrice IS NOT NULL

-- ALTER FUNCTION fn_expensive_or_cheap (@unitPrice money, @average_price money)
-- RETURNS CHAR(9)
-- AS
-- BEGIN
--     DECLARE @price_comment CHAR(9) = 'average';
--     IF(@unitPrice > @average_price) SET @price_comment = 'expensive';
--     IF(@unitPrice < @average_price) SET @price_comment = 'cheap';
--     RETURN @price_comment;
-- END

-- SELECT ProductName AS [Name], UnitPrice AS [Price], 
-- dbo.fn_expensive_or_cheap(UnitPrice, (SELECT AVG(UnitPrice) FROM Products)) AS [Comment]
-- FROM Products

-- DROP FUNCTION fn_expensive_or_cheap;

-- Table valued version

-- CREATE FUNCTION fn_expensive_from_price(@price money)
-- RETURNS TABLE AS
-- RETURN
--     SELECT * from Products
--     WHERE UnitPrice >= @price * 2;

-- SELECT * from fn_expensive_from_price((SELECT AVG(UnitPrice) from Products))
-- SELECT * from fn_expensive_from_price(100)

--Stored Procedures
