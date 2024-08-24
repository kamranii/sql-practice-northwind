CREATE TABLE Roles(
    ID int,
    [Name] NVARCHAR(30),
    IsDeleted BIT DEFAULT 0,
    PRIMARY KEY (ID)
)

CREATE TABLE Departments(
    ID int PRIMARY KEY,
    [Name] NVARCHAR(30),
    [Address] NVARCHAR(60),
    IsDeleted BIT DEFAULT 0,
    CONSTRAINT DepartmentNameConstraint CHECK(Name NOT LIKE '%[^A-Z]%')
)

CREATE TABLE Employees(
    ID int PRIMARY KEY,
    DepartmentID int FOREIGN KEY REFERENCES Departments(ID) NOT NULL,
    RoleID int FOREIGN KEY REFERENCES Roles(ID) NOT NULL,
    FirstName NVARCHAR(30) NOT NULL,
    Surname NVARCHAR(30) NOT NULL,
    Age int,
    IsDeleted BIT DEFAULT 0,
    CONSTRAINT AgeOverEighteen CHECK(Age > 18),
    CONSTRAINT FirstNameConstraint CHECK(FirstName NOT LIKE '%[^A-Z]%'),
    CONSTRAINT SurnameConstraint CHECK(Surname NOT LIKE '%[^A-Z]%')

)

INSERT INTO Roles(ID, [Name]) VALUES(1,'CEO'), (2,'Manager'), (3,'Employee')

INSERT INTO Departments(ID, [Name], [Address]) VALUES (2, 'Ganclik', 'Ganclik ave. 25'), 
(3, 'Narimanov', 'Narimanov ave. 25'), (4, 'Icharishahar', 'Icharishahar ave. 25')

INSERT INTO Employees(ID, DepartmentID, RoleID, FirstName, Surname, Age) 
VALUES
(1, 1, 1, 'Kamran', 'Imranli', 27),
(2, 4, 2, 'Farhad', 'Azadaliyev', 26),
(3, 3, 3, 'Xayal', 'Imranli', 22),
(4, 2, 2, 'Ruslan', 'Ibharimov', 23)

INSERT INTO Employees(ID, DepartmentID, RoleID, FirstName, Surname, Age) 
VALUES (5, 2, 3, 'Elxan', 'Quliyev', 37)

INSERT INTO Employees(ID, DepartmentID, RoleID, FirstName, Surname, Age) 
VALUES (6, 3, 1, 'Kamran', 'Aghayev', 37)

--Dlete age over 35
UPDATE Employees SET IsDeleted = 1 WHERE Age>35

--Department from Employees
SELECT E.FirstName, D.Name FROM Employees AS E INNER JOIN Departments D ON E.DepartmentID = D.ID 
WHERE E.IsDeleted = 0 AND D.IsDeleted = 0

--Same names
SELECT FirstName, COUNT(*) [TotalCount] FROM Employees  GROUP BY FirstName Having COUNT(*) > 1

--Managers of departments
SELECT D.Name, R.Name, E.FirstName FROM Employees AS E JOIN Departments AS D ON E.DepartmentID = D.ID 
JOIN Roles AS R ON E.RoleID = R.ID WHERE R.ID = 2 AND D.IsDeleted = 0

--Fullnames
SELECT CONCAT(FirstName,' ', Surname) AS [FullName] FROM Employees WHERE IsDeleted = 0

--Change Department Name

UPDATE Departments SET [Name] = 'GanclikLLC' WHERE [Name] = 'Ganclik'

--Oldest employee
SELECT FirstName, AGE FROM Employees WHERE Age = (SELECT MAX(AGE) FROM Employees)

--Check identity key
INSERT INTO Employees(DepartmentID, RoleID, FirstName, Surname, Age) 
VALUES (2, 3, 'Orxan', 'Zeynalli', 43)

INSERT Departments ([Name], [Address]) VALUES ('Barda', 'Barda central 22')