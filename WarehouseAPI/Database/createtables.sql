--rearrange my script below so I add the foreign key as soon as its possible

USE WarehouseDB;

--delete all tables in warehouseDB
DROP TABLE IF EXISTS SaleItems;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;


BEGIN TRANSACTION;

BEGIN TRY


--create a table called Users with these columns Id, FirstName, LastName, Email, Password, IsAdmin
CREATE TABLE Users (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(100) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    IsAdmin BIT NOT NULL,
    AddedOn DATETIME NOT NULL,
    AddedBy INT NOT NULL,
    UpdatedOn DATETIME NULL,
    UpdatedBy INT NULL
);

--make email unique, I want it to be unique in create statement above
CREATE INDEX IX_Users_Username ON Users(Username);
CREATE INDEX IX_Users_Email ON Users(Email);

ALTER TABLE Users ADD CONSTRAINT FK_Users_Users_AddedBy FOREIGN KEY (AddedBy) REFERENCES Users(Id);
ALTER TABLE Users ADD CONSTRAINT FK_Users_Users_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES Users(Id);


CREATE TABLE Categories (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(500) NULL,
    AddedOn DATETIME NOT NULL,
    AddedBy INT NOT NULL,
    UpdatedOn DATETIME NULL,
    UpdatedBy INT NULL
);

ALTER TABLE Categories ADD CONSTRAINT FK_Categories_Users_AddedBy FOREIGN KEY (AddedBy) REFERENCES Users(Id);
ALTER TABLE Categories ADD CONSTRAINT FK_Categories_Users_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES Users(Id);



--create a table for Customers with these columns Id, FirstName, LastName, Email, Phone, Address, City, Country, PostalCode
CREATE TABLE Customers (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    BusinessName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(100) NOT NULL,
    Address VARCHAR(500) NOT NULL,
    AddedOn DATETIME NOT NULL,
    AddedBy INT NOT NULL,
    UpdatedOn DATETIME NULL,
    UpdatedBy INT NULL
);

ALTER TABLE Customers ADD CONSTRAINT FK_Customers_Users_AddedBy FOREIGN KEY (AddedBy) REFERENCES Users(Id);
ALTER TABLE Customers ADD CONSTRAINT FK_Customers_Users_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES Users(Id);

--using good sql server practices, create a Products table with these columns Id, Name, Price, Description, AddedOn, CategoryId, ImageUrl, CBM, QuantityPerBox
CREATE TABLE Products (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    Description VARCHAR(500) NULL,
    CategoryId INT NOT NULL,
    ImageUrl VARCHAR(500) NULL,
    CBM DECIMAL(18,2) NOT NULL,
    QuantityPerBox INT NOT NULL,
    AddedOn DATETIME NOT NULL,
    AddedBy INT NOT NULL,
    UpdatedOn DATETIME NULL,
    UpdatedBy INT NULL
);



--create a foreign key constraint between Products and Categories
ALTER TABLE Products ADD CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(Id);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Users_AddedBy FOREIGN KEY (AddedBy) REFERENCES Users(Id);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Users_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES Users(Id);


--create a table for Sales with these columns Id, CustomerId, SaleDate, AddedOn, AddedBy, SaleBy
CREATE TABLE Sales (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    SaleDate DATETIME NOT NULL,
    SaleBy INT NOT NULL,
    AddedOn DATETIME NOT NULL,
    AddedBy INT NOT NULL,
    UpdatedOn DATETIME NULL,
    UpdatedBy INT NULL
);

ALTER TABLE Sales ADD CONSTRAINT FK_Sales_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(Id);
ALTER TABLE Sales ADD CONSTRAINT FK_Sales_Users FOREIGN KEY (SaleBy) REFERENCES Users(Id);
ALTER TABLE Sales ADD CONSTRAINT FK_Sales_Users_AddedBy FOREIGN KEY (AddedBy) REFERENCES Users(Id);
ALTER TABLE Sales ADD CONSTRAINT FK_Sales_Users_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES Users(Id);

--add a saleitems table with these columns Id, SaleId, ProductId, Quantity, Price, AddedOn, AddedBy, updatedOn, updatedBy
CREATE TABLE SaleItems (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    SaleId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    IsDifferentToStandardPrice BIT NOT NULL,
    AddedOn DATETIME NOT NULL,
    AddedBy INT NOT NULL,
    UpdatedOn DATETIME NULL,
    UpdatedBy INT NULL
);

ALTER TABLE SaleItems ADD CONSTRAINT FK_SaleItems_Sales FOREIGN KEY (SaleId) REFERENCES Sales(Id);
ALTER TABLE SaleItems ADD CONSTRAINT FK_SaleItems_Products FOREIGN KEY (ProductId) REFERENCES Products(Id);
ALTER TABLE SaleItems ADD CONSTRAINT FK_SaleItems_Users_AddedBy FOREIGN KEY (AddedBy) REFERENCES Users(Id);
ALTER TABLE SaleItems ADD CONSTRAINT FK_SaleItems_Users_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES Users(Id);

END TRY

BEGIN CATCH
    --show details of error
    SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
    ROLLBACK TRANSACTION;
END CATCH

COMMIT TRANSACTION;
GO

BEGIN TRANSACTION;

BEGIN TRY

INSERT INTO Users (Username, Email, FirstName, LastName, Password, IsAdmin, AddedOn, AddedBy)
VALUES 
('alberteinstein', 'alberteinstein@example.com', 'Albert', 'Einstein', 'pass123', 0, GETDATE(), 1),
('mariecurie', 'mariecurie@example.com', 'Marie', 'Curie', 'pass123', 0, GETDATE(), 1),
('leonardodavinci', 'leonardodavinci@example.com', 'Leonardo', 'da Vinci', 'pass123', 0, GETDATE(), 1),
('stevejobs', 'stevejobs@example.com', 'Steve', 'Jobs', 'pass123', 0, GETDATE(), 1),
('williamshakespeare', 'williamshakespeare@example.com', 'William', 'Shakespeare', 'pass123', 0, GETDATE(), 1),
('cleopatra', 'cleopatra@example.com', 'Cleopatra', 'VII', 'pass123', 0, GETDATE(), 1),
('nelsonmandela', 'nelsonmandela@example.com', 'Nelson', 'Mandela', 'pass123', 0, GETDATE(), 1),
('mozart', 'mozart@example.com', 'Wolfgang', 'Mozart', 'pass123', 0, GETDATE(), 1),
('michelangelo', 'michelangelo@example.com', 'Michelangelo', '', 'pass123', 0, GETDATE(), 1),
('janeausten', 'janeausten@example.com', 'Jane', 'Austen', 'pass123', 0, GETDATE(), 1);

INSERT INTO Categories (Name, Description, AddedOn, AddedBy) 
VALUES 
('Kitchen', 'Kitchen supplies and appliances', GETDATE(), 1),
('Electronics', 'Electronic gadgets and devices', GETDATE(), 1),
('Stationery', 'Office and school stationery', GETDATE(), 1),
('Home Decor', 'Decorative items for home', GETDATE(), 1),
('Gardening', 'Gardening tools and plants', GETDATE(), 1),
('Sporting Goods', 'Equipment and apparel for various sports', GETDATE(), 1),
('Books', 'Fiction and non-fiction books', GETDATE(), 1),
('Toys', 'Toys and games for children', GETDATE(), 1),
('Clothing', 'Apparel for men and women', GETDATE(), 1),
('Footwear', 'Shoes and sandals for all ages', GETDATE(), 1);

INSERT INTO Customers (BusinessName, FirstName, LastName, Email, Phone, Address, AddedOn, AddedBy) 
VALUES 
('ABC Corp', 'Alice', 'Brown', 'alicebrown@example.com', '123-456-7890', '123 Main St', GETDATE(), 1),
('XYZ Inc', 'David', 'Clark', 'davidclark@example.com', '123-456-7891', '456 Elm St', GETDATE(), 1),
('MNO Company', 'Eva', 'Green', 'evagreen@example.com', '123-456-7892', '789 Pine St', GETDATE(), 1),
('PQR Enterprises', 'Frank', 'Wright', 'frankwright@example.com', '123-456-7893', '101 Oak St', GETDATE(), 1),
('STU Ltd', 'Grace', 'Hall', 'gracehall@example.com', '123-456-7894', '202 Maple St', GETDATE(), 1),
('VWX Co', 'Henry', 'Lee', 'henrylee@example.com', '123-456-7895', '303 Birch St', GETDATE(), 1),
('YZA LLC', 'Irene', 'Adams', 'ireneadams@example.com', '123-456-7896', '404 Cedar St', GETDATE(), 1),
('BCD Corp', 'Jack', 'Miller', 'jackmiller@example.com', '123-456-7897', '505 Aspen St', GETDATE(), 1),
('EFG Inc', 'Karen', 'White', 'karenwhite@example.com', '123-456-7898', '606 Cherry St', GETDATE(), 1),
('HIJ Company', 'Louis', 'Brown', 'louisbrown@example.com', '123-456-7899', '707 Elm St', GETDATE(), 1);


INSERT INTO Products (Name, Price, Description, CategoryId, ImageUrl, CBM, QuantityPerBox, AddedOn, AddedBy) 
VALUES 
('Blender', 49.99, 'Kitchen blender for smoothies', 1, 'http://example.com/blender.jpg', 0.5, 10, GETDATE(), 1),
('Laptop', 999.99, 'High-performance laptop', 2, 'http://example.com/laptop.jpg', 1.5, 5, GETDATE(), 1),
('Notepad', 3.99, 'Spiral notepad for notes', 3, 'http://example.com/notepad.jpg', 0.1, 50, GETDATE(), 1),
('Table Lamp', 29.99, 'Decorative table lamp', 4, 'http://example.com/lamp.jpg', 0.8, 15, GETDATE(), 1),
('Gardening Gloves', 15.99, 'Leather gardening gloves', 5, 'http://example.com/gloves.jpg', 0.2, 20, GETDATE(), 1),
('Football', 19.99, 'Professional size football', 6, 'http://example.com/football.jpg', 0.7, 30, GETDATE(), 1),
('Mystery Novel', 12.99, 'Bestselling mystery novel', 7, 'http://example.com/novel.jpg', 0.3, 40, GETDATE(), 1),
('Teddy Bear', 25.99, 'Plush teddy bear for children', 8, 'http://example.com/teddy.jpg', 1.0, 25, GETDATE(), 1),
('T-shirt', 9.99, 'Cotton t-shirt for adults', 9, 'http://example.com/tshirt.jpg', 0.4, 35, GETDATE(), 1),
('Running Shoes', 49.99, 'Comfortable running shoes', 10, 'http://example.com/shoes.jpg', 1.2, 20, GETDATE(), 1);

-- Assuming CustomerId ranges from 1 to 10
INSERT INTO Sales (CustomerId, SaleDate, SaleBy, AddedOn, AddedBy) 
VALUES 
(1, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 1, GETDATE(), 1),
(2, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 2, GETDATE(), 1),
(3, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 3, GETDATE(), 1),
(4, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 4, GETDATE(), 1),
(5, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 5, GETDATE(), 1),
(6, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 6, GETDATE(), 1),
(7, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 7, GETDATE(), 1),
(8, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 8, GETDATE(), 1),
(9, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 9, GETDATE(), 1),
(10, DATEADD(DAY, -CAST(RAND()*365 AS INT), GETDATE()), 10, GETDATE(), 1);

INSERT INTO SaleItems (SaleId, ProductId, Quantity, Price, IsDifferentToStandardPrice, AddedOn, AddedBy)
VALUES
-- Sale 1 Items
(1, 1, 2, 49.99, 1, GETDATE(), 1),
(1, 2, 1, 999.99, 1, GETDATE(), 1),

-- Sale 2 Items
(2, 3, 3, 3.99, 1, GETDATE(), 1),
(2, 4, 1, 29.99, 0, GETDATE(), 1),
(2, 5, 2, 15.99, 1, GETDATE(), 1),

-- Sale 3 Items
(3, 6, 1, 19.99, 0, GETDATE(), 1),
(3, 7, 1, 12.99, 1, GETDATE(), 1),

-- Sale 4 Items
(4, 8, 2, 25.99, 1, GETDATE(), 1),
(4, 9, 1, 9.99, 1, GETDATE(), 1),

-- Sale 5 Items
(5, 3, 1, 3.99, 1, GETDATE(), 1),
(5, 5, 2, 15.99, 1, GETDATE(), 1),

-- Sale 6 Items
(6, 6, 1, 19.99, 1, GETDATE(), 1),
(6, 7, 1, 12.99, 1, GETDATE(), 1),
(6, 9, 2, 9.99, 1, GETDATE(), 1),

-- Sale 7 Items
(7, 2, 1, 999.99, 1, GETDATE(), 1),
(7, 4, 1, 29.99, 1, GETDATE(), 1),
(7, 5, 1, 29.99, 0, GETDATE(), 1),
(7, 6, 1, 29.99, 0, GETDATE(), 1),
(7, 8, 1, 29.99, 1, GETDATE(), 1),

-- Sale 8 Items
(8, 1, 2, 49.99, 1, GETDATE(), 1),
(8, 8, 1, 25.99, 1, GETDATE(), 1),

-- Sale 9 Items
(9, 5, 3, 15.99, 0, GETDATE(), 1),
(9, 10, 1, 49.99, 1, GETDATE(), 1),

-- Sale 10 Items
(10, 7, 1, 12.99, 1, GETDATE(), 1),
(10, 9, 2, 9.99, 0, GETDATE(), 1),
(10, 10, 1, 49.99, 1, GETDATE(), 1);



END TRY

BEGIN CATCH
    --show details of error
    SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
    ROLLBACK TRANSACTION;
END CATCH

COMMIT TRANSACTION;
GO