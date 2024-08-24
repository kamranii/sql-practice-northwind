DECLARE @count int = (SELECT COUNT (*) FROM Customers WHERE Country = 'USA') 
SELECT * FROM CUSTOMERS WHERE COUNTRY = 'USA'

SELECT COUNT(*) FROM Customers WHERE EXISTS(SELECT * FROM CUSTOMERS WHERE COUNTRY = 'USA')

IF (SELECT COUNT(*) FROM Customers WHERE EXISTS(SELECT * FROM CUSTOMERS WHERE COUNTRY = 'USA')) > 0
    PRINT 'WE HAVE CUSTOMERS FROM USA'
ELSE
    PRINT 'NO CUSTOMERS FROM USA'
SELECT * FROM Customers WHERE Country = 'USA' SELECT @@ROWCOUNT

SELECT * FROM Employees WHERE FirstName = 'ONUR' AND LastName = 'IBADOV'
-- DECLARE @row_count int = (SELECT @@ROWCOUNT)

IF @@ROWCOUNT > 0
    SELECT * FROM Employees WHERE FirstName = 'ONUR'
ELSE
    INSERT Employees (FirstName, LastName) VALUES('Onur', 'Ibadov')


SELECT CompanyName, Address
FROM Customers AS C
WHERE EXISTS(
    SELECT COUNT(*) FROM Orders O WHERE C.CustomerID = O.CustomerID GROUP BY CustomerID HAVING COUNT(*) > 2
)




SELECT E.FirstName EMPLOYEE, E.ReportsTo, E2.FirstName AS MANAGER into #EmployeeRelations FROM ORDERS O JOIN Customers C ON O.CustomerID = C.CustomerID 
JOIN Employees E ON O.EmployeeID = E.EmployeeID JOIN Employees E2 ON E.ReportsTo = E2.EmployeeID WHERE C.ContactName = 'Roland Mendel'
AND YEAR(O.OrderDate) > 1950

SELECT * FROM #EmployeeRelations