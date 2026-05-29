CREATE DATABASE ECOMMERCE_ASSIGNMENT_DB;

USE ECOMMERCE_ASSIGNMENT_DB;

CREATE TABLE Customer
(
  CustomerId INT PRIMARY KEY,
  CustomerName VARCHAR(100) NOT NULL,
  Email VARCHAR(100) UNIQUE NOT NULL,
  MobileNo VARCHAR(15) NOT NULL,
  City VARCHAR(50) NOT NULL,
   Address VARCHAR(200),
   IsActive BIT DEFAULT 1,
   CreatedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Seller
(
    SellerId INT PRIMARY KEY,
    SellerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    MobileNo VARCHAR(15) NOT NULL,
    City VARCHAR(50),
    Rating DECIMAL(2,1),
    IsActive BIT DEFAULT 1
);

CREATE TABLE Product
(
    ProductId INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price > 0),
    StockQuantity INT CHECK (StockQuantity >= 0),
    SellerId INT,
    CreatedDate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (SellerId)
    REFERENCES Seller(SellerId)
);

CREATE TABLE Orders
(
    OrderId INT PRIMARY KEY,
    CustomerId INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    OrderStatus VARCHAR(50) DEFAULT 'Pending',
    PaymentMode VARCHAR(50),
    DeliveryCity VARCHAR(50),

    FOREIGN KEY (CustomerId)
    REFERENCES Customer(CustomerId)
);

CREATE TABLE OrderItem
(
    OrderItemId INT PRIMARY KEY,
    OrderId INT,
    ProductId INT,
    Quantity INT CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2),

    FOREIGN KEY (OrderId)
    REFERENCES Orders(OrderId),

    FOREIGN KEY (ProductId)
    REFERENCES Product(ProductId)
);

INSERT INTO Customer
VALUES
(1,'Arun','arun@gmail.com','9876543210','Chennai','Anna Nagar',1,GETDATE()),
(2,'Bala','bala@gmail.com','9876543211','Bangalore','MG Road',1,GETDATE()),
(3,'Anitha','anitha@gmail.com','9876543212','Hyderabad','Ameerpet',1,GETDATE()),
(4,'David','david@gmail.com','9876543213','Chennai','T Nagar',1,GETDATE()),
(5,'Aakash','aakash@gmail.com','9876543214','Mumbai','Andheri',1,GETDATE());

SELECT * FROM Customer;

INSERT INTO Seller
VALUES
(1,'Tech World','tech@gmail.com','9000000001','Chennai',4.5,1),
(2,'Mobile Hub','mobile@gmail.com','9000000002','Bangalore',4.2,1),
(3,'Laptop Store','laptop@gmail.com','9000000003','Hyderabad',4.8,1),
(4,'Digital Shop','digital@gmail.com','9000000004','Mumbai',4.1,1);

SELECT * FROM Seller;

INSERT INTO Product
VALUES
(101,'iPhone 15','Mobile',80000,15,2,GETDATE()),
(102,'Samsung S24','Mobile',70000,20,2,GETDATE()),
(103,'Dell XPS','Laptop',95000,10,3,GETDATE()),
(104,'HP Pavilion','Laptop',65000,8,3,GETDATE()),
(105,'Boat Headset','Accessories',2000,50,1,GETDATE()),
(106,'Keyboard','Accessories',1500,40,1,GETDATE()),
(107,'Smart Watch','Wearable',12000,25,4,GETDATE()),
(108,'Tablet','Electronics',30000,12,4,GETDATE());

SELECT * FROM Product;

INSERT INTO Orders
VALUES
(1001,1,GETDATE(),'Delivered','UPI','Chennai'),
(1002,2,GETDATE(),'Pending','Card','Bangalore'),
(1003,3,GETDATE(),'Shipped','Cash','Hyderabad'),
(1004,1,GETDATE(),'Delivered','UPI','Chennai'),
(1005,5,GETDATE(),'Pending','Card','Mumbai');

SELECT * FROM Orders;

INSERT INTO OrderItem
VALUES
(1,1001,101,1,80000),
(2,1001,105,2,2000),
(3,1002,103,1,95000),
(4,1002,106,1,1500),
(5,1003,102,1,70000),
(6,1003,107,2,12000),
(7,1004,104,1,65000),
(8,1004,105,1,2000),
(9,1005,108,1,30000),
(10,1005,106,2,1500);

SELECT * FROM OrderItem;

UPDATE Customer
SET City = 'Coimbatore'
WHERE CustomerId = 2;

UPDATE Orders
SET OrderStatus = 'Delivered'
WHERE OrderId = 1002;

DELETE FROM Product
WHERE ProductId = 107
AND ProductId NOT IN
(
    SELECT ProductId FROM OrderItem
);

SELECT * FROM Customer;

SELECT * FROM Seller;

SELECT * FROM Product;

SELECT * FROM Orders;

SELECT * FROM OrderItem;

SELECT * FROM Customer
WHERE City = 'Chennai';

SELECT * FROM Product
WHERE Price > 50000;

SELECT * FROM Product
WHERE Price BETWEEN 10000 AND 60000;

SELECT * FROM Product
WHERE Category IN ('Mobile','Laptop');

SELECT * FROM Customer
WHERE CustomerName LIKE 'A%';

SELECT * FROM Customer
WHERE Email LIKE '%gmail%';

SELECT * FROM Product
WHERE ProductName LIKE '%Phone%';

SELECT * FROM Orders
WHERE OrderStatus = 'Delivered';

SELECT * FROM Product
WHERE StockQuantity < 10;

SELECT City, COUNT(*) AS TotalCustomers
FROM Customer
GROUP BY City;

SELECT Category, COUNT(*) AS TotalProducts
FROM Product
GROUP BY Category;

SELECT Category, SUM(StockQuantity) AS TotalStock
FROM Product
GROUP BY Category;

SELECT Category, MAX(Price) AS MaxPrice
FROM Product
GROUP BY Category;

SELECT Category, AVG(Price) AS AveragePrice
FROM Product
GROUP BY Category;

SELECT * FROM Product
ORDER BY Price ASC;

SELECT * FROM Product
ORDER BY Price DESC;

SELECT * FROM Orders
ORDER BY OrderDate DESC;

SELECT TOP 3 *
FROM Product
ORDER BY Price DESC;

SELECT
    o.OrderId,
    c.CustomerName,
    o.OrderDate,
    o.OrderStatus
FROM Orders o
INNER JOIN Customer c
ON o.CustomerId = c.CustomerId;

SELECT
    p.ProductName,
    p.Price,
    s.SellerName
FROM Product p
INNER JOIN Seller s
ON p.SellerId = s.SellerId;

SELECT
    oi.OrderItemId,
    p.ProductName,
    oi.Quantity,
    oi.UnitPrice
FROM OrderItem oi
INNER JOIN Product p
ON oi.ProductId = p.ProductId;

SELECT
    c.CustomerName,
    o.OrderId,
    p.ProductName,
    s.SellerName,
    oi.Quantity,
    oi.UnitPrice
FROM Customer c
INNER JOIN Orders o
ON c.CustomerId = o.CustomerId
INNER JOIN OrderItem oi
ON o.OrderId = oi.OrderId
INNER JOIN Product p
ON oi.ProductId = p.ProductId
INNER JOIN Seller s
ON p.SellerId = s.SellerId;

SELECT
    c.CustomerName,
    o.OrderId
FROM Customer c
LEFT JOIN Orders o
ON c.CustomerId = o.CustomerId;

SELECT
    c.CustomerName,
    o.OrderId
FROM Customer c
RIGHT JOIN Orders o
ON c.CustomerId = o.CustomerId;

SELECT
    c.CustomerName,
    o.OrderId
FROM Customer c
FULL OUTER JOIN Orders o
ON c.CustomerId = o.CustomerId;

SELECT
    c.CustomerName,
    p.ProductName
FROM Customer c
CROSS JOIN Product p;

SELECT *
FROM Customer
WHERE CustomerId NOT IN
(
    SELECT CustomerId FROM Orders
);

SELECT *
FROM Product
WHERE ProductId NOT IN
(
    SELECT ProductId FROM OrderItem
);

SELECT
    s.SellerName,
    p.ProductName
FROM Seller s
INNER JOIN Product p
ON s.SellerId = p.SellerId;

SELECT
    c.CustomerName,
    p.ProductName
FROM Customer c
INNER JOIN Orders o
ON c.CustomerId = o.CustomerId
INNER JOIN OrderItem oi
ON o.OrderId = oi.OrderId
INNER JOIN Product p
ON oi.ProductId = p.ProductId;

SELECT
    o.OrderId,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalAmount
FROM Orders o
INNER JOIN OrderItem oi
ON o.OrderId = oi.OrderId
GROUP BY o.OrderId;

SELECT
    s.SellerName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Seller s
INNER JOIN Product p
ON s.SellerId = p.SellerId
INNER JOIN OrderItem oi
ON p.ProductId = oi.ProductId
GROUP BY s.SellerName;

SELECT
    p.ProductName,
    SUM(oi.Quantity) AS TotalQuantitySold
FROM Product p
INNER JOIN OrderItem oi
ON p.ProductId = oi.ProductId
GROUP BY p.ProductName;

