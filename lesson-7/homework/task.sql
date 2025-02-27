DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);


INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

-- 1️ Retrieve All Customers With Their Orders (Include Customers Without Orders)
-- Use an appropriate JOIN to list all customers, their order IDs, and order dates.
-- Ensure that customers with no orders still appear.

SELECT 
    c.*, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o
    on c.CustomerID = o.CustomerID;

-- 2️ Find Customers Who Have Never Placed an Order
-- Return customers who have no orders.

SELECT 
    c.*
FROM Customers c
LEFT JOIN Orders o
    on c.CustomerID = o.CustomerID
WHERE o.OrderID is NULL;

-- 3️ List All Orders With Their Products
-- Show each order with its product names and quantity.

SELECT
    o.OrderID, p.ProductName, p.Category, o.Quantity, o.Price
FROM OrderDetails o
INNER JOIN Products p
    on o.ProductID = p.ProductID;

-- 4️ Find Customers With More Than One Order
-- List customers who have placed more than one order.

SELECT
    c.CustomerName
FROM Customers c
INNER JOIN Orders o
    on o.CustomerID = c.CustomerID
GROUP BY c.CustomerName
HAVING COUNT(*) > 1;

-- 5️ Find the Most Expensive Product in Each Order

SELECT 
    ProductName, Category, Price
FROM
(SELECT
    p.ProductName, p.Category, o.Price,
    ROW_NUMBER() OVER(PARTITION BY o.OrderID ORDER BY Price DESC) as rank
FROM OrderDetails o
INNER JOIN Products p
    on p.ProductID = o.ProductID) as t
WHERE t.rank < 2;

-- 6️ Find the Latest Order for Each Customer

SELECT 
    c.CustomerName, MAX(o.OrderDate)
FROM Customers c
INNER JOIN Orders o
    on o.CustomerID = c.CustomerID
GROUP BY c.CustomerName;

-- 7️ Find Customers Who Ordered Only 'Electronics' Products
-- List customers who only purchased items from the 'Electronics' category.

SELECT
    c.CustomerName
FROM Customers c
INNER JOIN Orders o
    on o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od
    on o.OrderID = od.OrderID
INNER JOIN Products p
    on p.ProductID = od.ProductID
GROUP BY c.CustomerName
HAVING SUM(
    CASE 
        WHEN p.Category = 'Electronics' THEN 1
        ELSE 0
    END
) = COUNT(p.Category);

-- 8️ Find Customers Who Ordered at Least One 'Stationery' Product
-- List customers who have purchased at least one product from the 'Stationery' category.

SELECT
    c.CustomerName
FROM Customers c
INNER JOIN Orders o
    on o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od
    on o.OrderID = od.OrderID
INNER JOIN Products p
    on p.ProductID = od.ProductID
GROUP BY c.CustomerName
HAVING SUM(
    CASE 
        WHEN p.Category = 'Stationery' THEN 1
        ELSE 0
    END
) > 0;

-- 9️ Find Total Amount Spent by Each Customer
-- Show CustomerID, CustomerName, and TotalSpent.

SELECT 
    c.CustomerID, c.CustomerName, SUM(od.Price) as TotalSpent
FROM Customers c
INNER JOIN Orders o
    on o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od
    on o.OrderID = od.OrderID
GROUP BY c.CustomerName, c.CustomerID;