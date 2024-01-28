--rearrange my script below so I add the foreign key as soon as its possible

USE WarehouseDB;

--delete all tables in warehouseDB
DROP TABLE IF EXISTS PurchaseItems;
DROP TABLE IF EXISTS Purchases;
DROP TABLE IF EXISTS Suppliers;

DROP TABLE IF EXISTS SaleItems;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS StockMovementLog;
DROP TABLE IF EXISTS Inventories;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;


BEGIN TRANSACTION;

BEGIN TRY


--create a table called Users with these columns Id, FirstName, LastName, Email, Password, IsAdmin
CREATE TABLE Users (
    UserId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(100) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    IsAdmin BIT NOT NULL,
    AddedOnUtc DATETIME NOT NULL,
    AddedByUserId INT NOT NULL,
    UpdatedOnUtc DATETIME NULL,
    UpdatedByUserId INT NULL
);

--make email unique, I want it to be unique in create statement above
CREATE INDEX IX_Users_Username ON Users(Username);
CREATE INDEX IX_Users_Email ON Users(Email);

ALTER TABLE Users ADD CONSTRAINT FK_Users_Users_AddedByUserId FOREIGN KEY (AddedByUserId) REFERENCES Users(UserId);
ALTER TABLE Users ADD CONSTRAINT FK_Users_Users_UpdatedByUserId FOREIGN KEY (UpdatedByUserId) REFERENCES Users(UserId);


CREATE TABLE Categories (
    CategoryId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(500) NULL,
    AddedOnUtc DATETIME NOT NULL,
    AddedByUserId INT NOT NULL,
    UpdatedOnUtc DATETIME NULL,
    UpdatedByUserId INT NULL
);

ALTER TABLE Categories ADD CONSTRAINT FK_Categories_Users_AddedByUserId FOREIGN KEY (AddedByUserId) REFERENCES  Users(UserId);
ALTER TABLE Categories ADD CONSTRAINT FK_Categories_Users_UpdatedByUserId FOREIGN KEY (UpdatedByUserId) REFERENCES  Users(UserId);



--create a table for Customers with these columns Id, FirstName, LastName, Email, Phone, Address, City, Country, PostalCode
CREATE TABLE Customers (
    CustomerId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    BusinessName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(100) NOT NULL,
    Address VARCHAR(500) NOT NULL,
    AddedOnUtc DATETIME NOT NULL,
    AddedByUserId INT NOT NULL,
    UpdatedOnUtc DATETIME NULL,
    UpdatedByUserId INT NULL
);

ALTER TABLE Customers ADD CONSTRAINT FK_Customers_Users_AddedByUserId FOREIGN KEY (AddedByUserId) REFERENCES  Users(UserId);
ALTER TABLE Customers ADD CONSTRAINT FK_Customers_Users_UpdatedByUserId FOREIGN KEY (UpdatedByUserId) REFERENCES  Users(UserId);

--using good sql server practices, create a Products table with these columns Id, Name, Price, Description, AddedOnUtc, CategoryId, ImageUrl, CBM, QuantityPerBox
CREATE TABLE Products (
    ProductId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    Description VARCHAR(500) NULL,
    CategoryId INT NOT NULL,
    ImageUrl VARCHAR(500) NULL,
    CBM DECIMAL(18,2) NOT NULL,
    QuantityPerBox INT NOT NULL,
    AddedOnUtc DATETIME NOT NULL,
    AddedByUserId INT NOT NULL,
    UpdatedOnUtc DATETIME NULL,
    UpdatedByUserId INT NULL
);

--create a foreign key constraint between Products and Categories
ALTER TABLE Products ADD CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Users_AddedByUserId FOREIGN KEY (AddedByUserId) REFERENCES  Users(UserId);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Users_UpdatedByUserId FOREIGN KEY (UpdatedByUserId) REFERENCES  Users(UserId);

CREATE TABLE Inventories (
    ProductId INT PRIMARY KEY,
    QuantityInStock INT,
    LastUpdated DATETIME,
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);


--create a table for Sales with these columns Id, CustomerId, SaleDate, AddedOnUtc, AddedByUserId, SaleByUserId
CREATE TABLE Sales (
    SaleId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    SaleDate DATETIME NOT NULL,
    SaleByUserId INT NOT NULL,
    AddedOnUtc DATETIME NOT NULL,
    AddedByUserId INT NOT NULL,
);

ALTER TABLE Sales ADD CONSTRAINT FK_Sales_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId);
ALTER TABLE Sales ADD CONSTRAINT FK_Sales_Users FOREIGN KEY (SaleByUserId) REFERENCES  Users(UserId);
ALTER TABLE Sales ADD CONSTRAINT FK_Sales_Users_AddedByUserId FOREIGN KEY (AddedByUserId) REFERENCES  Users(UserId);

--add a saleitems table with these columns Id, SaleId, ProductId, Quantity, Price, AddedOnUtc, AddedByUserId, UpdatedOnUtc, updatedByUserId
CREATE TABLE SaleItems (
    SaleItemId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    SaleId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18,2) NOT NULL
);

ALTER TABLE SaleItems ADD CONSTRAINT FK_SaleItems_Sales FOREIGN KEY (SaleId) REFERENCES Sales(SaleId);
ALTER TABLE SaleItems ADD CONSTRAINT FK_SaleItems_Products FOREIGN KEY (ProductId) REFERENCES Products(ProductId);



CREATE TABLE Suppliers (
    SupplierId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(255),
    ContactInfo NVARCHAR(MAX),
    AddedOnUtc DATETIME NOT NULL,
    AddedByUserId INT NOT NULL,
    UpdatedOnUtc DATETIME NULL,
    UpdatedByUserId INT NULL
);


CREATE TABLE Purchases (
    PurchaseId INT PRIMARY KEY IDENTITY,
    SupplierId INT,
    PurchaseDate DATETIME,
    AddedOnUtc DATETIME NOT NULL,
    AddedByUserId INT NOT NULL,
    UpdatedOnUtc DATETIME NULL,
    UpdatedByUserId INT NULL
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(SupplierId)
);

CREATE TABLE PurchaseItems (
    PurchaseItemId INT PRIMARY KEY IDENTITY,
    PurchaseId INT,
    ProductId INT,
    Quantity INT,
    AddedOnUtc DATETIME NOT NULL,
    AddedByUserId INT NOT NULL,
    UpdatedOnUtc DATETIME NULL,
    UpdatedByUserId INT NULL
    FOREIGN KEY (PurchaseId) REFERENCES Purchases(PurchaseId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);


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

INSERT INTO Users (Username, Email, FirstName, LastName, Password, IsAdmin, AddedOnUtc, AddedByUserId)
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

INSERT INTO Categories (Name, Description, AddedOnUtc, AddedByUserId) 
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

INSERT INTO Customers (BusinessName, FirstName, LastName, Email, Phone, Address, AddedOnUtc, AddedByUserId) 
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

--change below inserts to use the first 3 imageurls for all the rest of the products
INSERT INTO Products (Name, Price, Description, CategoryId, ImageUrl, CBM, QuantityPerBox, AddedOnUtc, AddedByUserId) 
VALUES 
('Blender', 49.99, 'Kitchen blender for smoothies', 1, 'https://i.ebayimg.com/images/g/oHsAAOSwM2lkCM1G/s-l1200.webp', 0.5, 10, GETDATE(), 1),
('Laptop', 999.99, 'High-performance laptop', 2, 'https://media.4rgos.it/s/Argos/2074539_R_SET?$Main768$&w=620&h=620', 1.5, 5, GETDATE(), 1),
('Notepad', 3.99, 'Spiral notepad for notes', 3, 'https://via.placeholder.com/150', 0.1, 50, GETDATE(), 1),
('Table Lamp', 29.99, 'Decorative table lamp', 4, 'https://i.ebayimg.com/images/g/oHsAAOSwM2lkCM1G/s-l1200.webp', 0.8, 15, GETDATE(), 1),
('Gardening Gloves', 15.99, 'Leather gardening gloves', 5, 'https://media.4rgos.it/s/Argos/2074539_R_SET?$Main768$&w=620&h=620', 0.2, 20, GETDATE(), 1),
('Football', 19.99, 'Professional size football', 6, 'https://via.placeholder.com/150', 0.7, 30, GETDATE(), 1),
('Mystery Novel', 12.99, 'Bestselling mystery novel', 7, 'https://i.ebayimg.com/images/g/oHsAAOSwM2lkCM1G/s-l1200.webp', 0.3, 40, GETDATE(), 1),
('Teddy Bear', 25.99, 'Plush teddy bear for children', 8, 'https://media.4rgos.it/s/Argos/2074539_R_SET?$Main768$&w=620&h=620', 1.0, 25, GETDATE(), 1),
('T-shirt', 9.99, 'Cotton t-shirt for adults', 9, 'https://via.placeholder.com/150', 0.4, 35, GETDATE(), 1),
('Shirt', 19.99, 'Cotton Shirt for adults', 9, 'https://media.4rgos.it/s/Argos/2074539_R_SET?$Main768$&w=620&h=620', 0.4, 28, GETDATE(), 1),
('Running Shoes', 49.99, 'Comfortable running shoes', 10, 'https://i.ebayimg.com/images/g/oHsAAOSwM2lkCM1G/s-l1200.webp', 1.2, 20, GETDATE(), 1);

-- Insert into Inventory for each product
DECLARE @CurrentDate DATETIME = GETDATE();

INSERT INTO Inventories (ProductId, QuantityInStock, LastUpdated)
VALUES 
(1, 100, @CurrentDate),
(2, 50, @CurrentDate),
(3, 200, @CurrentDate),
(4, 75, @CurrentDate),
(5, 150, @CurrentDate),
(6, 100, @CurrentDate),
(7, 50, @CurrentDate),
(8, 200, @CurrentDate),
(9, 75, @CurrentDate),
(10, 150, @CurrentDate),
(11, 120, @CurrentDate);


-- Assuming CustomerId ranges from 1 to 10
INSERT INTO Sales (CustomerId, SaleDate, SaleByUserId, AddedOnUtc, AddedByUserId) 
VALUES 
(1, GETDATE() - 900, 1, GETDATE(), 1),
(2, GETDATE() - 800, 2, GETDATE(), 1),
(3, GETDATE() - 700, 3, GETDATE(), 1),
(4, GETDATE() - 600, 4, GETDATE(), 1),
(5, GETDATE() - 500, 5, GETDATE(), 1),
(6, GETDATE() - 700, 6, GETDATE(), 1),
(7, GETDATE() - 500, 7, GETDATE(), 1),
(8, GETDATE() - 400, 8, GETDATE(), 1),
(9, GETDATE() - 300, 9, GETDATE(), 1),
(10, GETDATE() - 200, 10, GETDATE(), 1);

INSERT INTO SaleItems (SaleId, ProductId, Quantity, Price)
VALUES
-- Sale 1 Items
(1, 1, 2, 49.99),
(1, 2, 1, 999.99),

-- Sale 2 Items
(2, 3, 3, 3.99),
(2, 4, 1, 29.99),
(2, 5, 2, 15.99),

-- Sale 3 Items
(3, 6, 1, 19.99),
(3, 7, 1, 12.99),

-- Sale 4 Items
(4, 8, 2, 25.99),
(4, 9, 1, 9.99),

-- Sale 5 Items
(5, 3, 1, 3.99),
(5, 5, 2, 15.99),

-- Sale 6 Items
(6, 6, 1, 19.99),
(6, 7, 1, 12.99),
(6, 9, 2, 9.99),

-- Sale 7 Items
(7, 2, 1, 999.99),
(7, 4, 1, 29.99),
(7, 5, 1, 29.99),
(7, 6, 1, 29.99),
(7, 8, 1, 29.99),

-- Sale 8 Items
(8, 1, 2, 49.99),
(8, 8, 1, 25.99),

-- Sale 9 Items
(9, 5, 3, 15.99),
(9, 10, 1, 49.99),

-- Sale 10 Items
(10, 7, 1, 12.99),
(10, 9, 2, 9.99),
(10, 10, 1, 49.99);



END TRY

BEGIN CATCH
    --show details of error
    SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
    ROLLBACK TRANSACTION;
END CATCH

COMMIT TRANSACTION;
GO