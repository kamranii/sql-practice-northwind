SELECT CONCAT(LastName, ' ', FirstName) AS [FullName], TitleOfCourtesy 
INTO #FemaleEmployees 
FROM Employees 
WHERE TitleOfCourtesy IN ('Mrs.', 'Ms.')
GO
SELECT * FROM #FemaleEmployees

USE BankDb
CREATE VIEW AzerbaijaniAuthors
AS 
SELECT au.Name, ad.City FROM Authors AS AU LEFT JOIN Addresses AS AD ON AU.AddressID = AD.ID
WHERE AD.Country = 'Azerbaijan'
GO
SELECT Name FROM AzerbaijaniAuthors ORDER BY Name DESC

sp_helptext 'AzerbaijaniAuthors'

CREATE VIEW WesternTerritories
WITH SCHEMABINDING
AS 
    SELECT T.TerritoryDescription, R.RegionDescription FROM dbo.Territories AS T INNER JOIN dbo.Region AS R 
    ON T.RegionID = R.RegionID WHERE R.RegionDescription = 'Western'

ALTER TABLE Region
ALTER COLUMN RegionDescription NVARCHAR(MAX)

DROP VIEW WesternTerritories