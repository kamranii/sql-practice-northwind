
SELECT C.CategoryName, P.ProductName, SUM(OD.UnitPrice * (1 - OD.Discount) * OD.Quantity) AS [TOTAL PROFIT]  
FROM Orders AS O JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
JOIN Products AS P ON OD.ProductID = P.ProductID 
JOIN Categories AS C ON P.CategoryID = C.CategoryID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY C.CategoryName, P.ProductName

-- SELECT SUM(O.UnitPrice * (1 - O.Discount) * O.Quantity) FROM [Order Details] AS O JOIN Products AS P 
-- ON O.ProductID = P.ProductID JOIN Orders AS OD ON OD.OrderID = O.OrderID 
-- WHERE P.ProductID = 11 AND YEAR(OD.OrderDate) = 1997
--

--

SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
SELECT AVG(UnitPrice) from Products

-- CREATE FUNCTION CalculateTotalValueMoney(@unitPrice money, @unitsInStock SMALLINT) RETURNS money
-- AS 
--  BEGIN
--     RETURN (@unitPrice * @unitsInStock) * 1.18
--  END

-- SELECT  ProductName, dbo.CalculateTotalValueMoney(UnitPrice, UnitsInStock) AS [TOTAL AMOUNT] FROM Products

CREATE FUNCTION CheckIfAboveAverage(@unitPrice money, @averagePrice money) RETURNS NVARCHAR(50)
AS
    BEGIN
        IF @unitPrice > @averagePrice
            RETURN 'Boyukdur'
        RETURN 'Kicikdir'
    END

SELECT ProductName, UnitPrice, (SELECT AVG(UnitPrice) FROM Products) AS [AvergaeUnitPrice], dbo.CheckIfAboveAverage(UnitPrice, (SELECT AVG(UnitPrice) 
FROM Products)) AS [Comparison] FROM Products


CREATE FUNCTION CheckIfAboveAverageSEC(@unitPrice money, @averagePrice money) RETURNS NVARCHAR(50)
AS
    BEGIN
        IF @unitPrice > @averagePrice
            BEGIN
                RETURN 'Boyukdur'
            END
        ELSE
            RETURN 'Kicikdir'
    END
