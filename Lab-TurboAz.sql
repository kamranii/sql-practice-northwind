CREATE DATABASE TurboAzDB
GO

--FUEL
USE TurboAzDB
CREATE TABLE FuelType(
    FuelID SMALLINT PRIMARY KEY IDENTITY(1,1),
    TypeName NVARCHAR(20) NOT NULL 
)

GO

--BRAND

CREATE TABLE Brand(
    BrandID SMALLINT PRIMARY KEY IDENTITY(1,1),
    BrandName NVARCHAR(50) NOT NULL
)
GO
--MODEL

CREATE TABLE Model(
    ModelID INT PRIMARY KEY IDENTITY(1,1),
    ModelName NVARCHAR(100) NOT NULL,
    BrandID SMALLINT NOT NULL,
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
)
GO

--Advert

CREATE TABLE Advert(
    AdvertID INT PRIMARY KEY IDENTITY(1,1),
    BrandID SMALLINT NOT NULL,
    ModelID INT NOT NULL, 
    FuelTypeID SMALLINT NOT NULL,
    Color NVARCHAR(30),
    IsNew BIT NOT NULL,
    Price MONEY NOT NULL,
    HorsePower INT,
    Engine FLOAT,
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID),
    FOREIGN KEY (ModelID) REFERENCES Model(ModelID),
    FOREIGN KEY (FuelTypeID) REFERENCES FuelType(FuelID),
)

GO

--PHOTOS (ADD foreign key)

CREATE TABLE Photos(
    PhotoID INT PRIMARY KEY IDENTITY(1,1),
    PhotoURL NVARCHAR(300) UNIQUE,
    AdvertID INT NOT NULL,
    FOREIGN KEY (AdvertID) REFERENCES Advert(AdvertID)
)

USE TurboAzDB
INSERT FuelType(TypeName) VALUES
('Benzin'), ('Dizel'), ('Hibrid')

GO
INSERT Brand(BrandName) VALUES
('Lamborghini'), ('Porsche'), ('Ford')
GO

INSERT Model(ModelName, BrandID) VALUES
('Aventador', 1), ('911', 2), ('Mustang', 3)
GO

INSERT Advert(BrandID, ModelID, FuelTypeID, Color, IsNew, Price, HorsePower, Engine) VALUES
(1, 1, 1, 'Goy', 0, 425000, 700, 6.5),
(2, 2, 1, 'Goy', 0, 246500, 450, 3.0),
(3, 3, 1, 'Ag', 0, 38760, 320, 2.0)
GO

INSERT Photos(PhotoURL, AdvertID) VALUES
('https://turbo.azstatic.com/uploads/f710x568/2022%2F12%2F05%2F15%2F32%2F31%2F72e04c20-1704-452c-a912-57b19b7817db%2F2857_3pfwB7fPcdU9U8fTBLJj8w.jpg', 1),
('https://turbo.azstatic.com/uploads/f710x568/2022%2F03%2F24%2F14%2F28%2F55%2Fdf438a53-bd5f-45c2-b78e-a0a63f09fbfa%2F15129_FQip4DIZeX6U2LIKjtEaUg.jpg', 2),
('https://turbo.azstatic.com/uploads/f710x568/2023%2F01%2F23%2F19%2F36%2F54%2Fa290f591-1250-4db3-b40d-30d83231d624%2F42141_nYhtkONRZeiY2Kwl_uHQgA.jpg', 3)
GO

CREATE FUNCTION fn_convert_isNew_to_string
(@isNewValue BIT) 
RETURNS NVARCHAR(4)
AS
BEGIN 
    DECLARE @isNewString NVARCHAR(4);
    SET @isNewString = 'Yes'
    IF(@isNewValue = 0) SET @isNewString = 'No';

    RETURN @isNewString
END

GO
CREATE VIEW vw_adverts_get_all
AS
    SELECT B.BrandName AS [Brand], M.ModelName AS [Model], F.TypeName AS [Fuel Type], A.Color, dbo.fn_convert_isNew_to_string(A.IsNew) AS [IsNEw], 
    A.Price, A.HorsePower, A.Engine
    FROM Advert AS A
    JOIN Brand AS B ON A.BrandID = B.BrandID
    JOIN Model AS M ON A.ModelID = M.ModelID
    JOIN FuelType AS F ON A.FuelTypeID = F.FuelID
GO
SELECT * FROM vw_adverts_get_all
    
--Procedure to insert data
GO
CREATE PROCEDURE sp_advert_add_new_advert
(@brandID SMALLINT, @modelID SMALLINT, @fuelTypeID SMALLINT, @color NVARCHAR(30), @isNew BIT, @price MONEY, @horsepower INT, @engine FLOAT,
@photoUrl NVARCHAR(MAX))
AS
BEGIN
    INSERT Advert(BrandID, ModelID, FuelTypeID, Color, IsNew, Price, HorsePower, Engine) VALUES
    (@brandID, @modelID, @fuelTypeID, @color, @isNew, @price, @horsepower, @engine)
    INSERT Photos (PhotoURL, AdvertID) VALUES
    (@photoUrl, (SELECT AdvertID from inserted))
END

EXEC sp_advert_add_new_advert 1, 1, 1, 'Qara', 1, 727800, 620, 5.0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWpJsqzAfBjjbdy84lHhS57YV29_jtx4IBhFfU-pFf&s'
EXEC sp_advert_add_new_advert 3, 3, 3, 'Qara', 1, 27800, 220, 2.0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWpJsqzAfBjjbdy84lHhS57YV29_jtx4IBhFfU-pFf&s'

SELECT * FROM vw_adverts_get_all
SELECT * FROM Photos
--TRIGGER
CREATE TABLE AdvertArchives
(AdvertID INT,
    BrandID SMALLINT,
    ModelID INT, 
    FuelTypeID SMALLINT,
    Color NVARCHAR(30),
    IsNew BIT ,
    Price MONEY ,
    HorsePower INT,
    Engine FLOAT)

GO

--Alter Photo to be able to delete

ALTER TABLE Photos 
ADD CONSTRAINT fk_photos_advert
FOREIGN KEY(AdvertID) REFERENCES Advert(AdvertID)
ON DELETE CASCADE



GO
CREATE TRIGGER tr_advert_delete
ON Advert
FOR DELETE
AS 
BEGIN
    DELETE FROM Photos WHERE AdvertID = (SELECT AdvertID FROM deleted) 
    INSERT INTO AdvertArchives SELECT * FROM deleted 
END

DELETE FROM Advert Where AdvertID = 3

SELECT * FROM Photos