DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);


INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES 
    (1, 'Alice', 'Johnson', 'HR', 60000, '2019-03-15'),
    (2, 'Bob', 'Smith', 'IT', 85000, '2018-07-20'),
    (3, 'Charlie', 'Brown', 'Finance', 95000, '2017-01-10'),
    (4, 'David', 'Williams', 'HR', 50000, '2021-05-22'),
    (5, 'Emma', 'Jones', 'IT', 110000, '2016-12-02'),
    (6, 'Frank', 'Miller', 'Finance', 40000, '2022-06-30'),
    (7, 'Grace', 'Davis', 'Marketing', 75000, '2020-09-14'),
    (8, 'Henry', 'White', 'Marketing', 72000, '2020-10-10'),
    (9, 'Ivy', 'Taylor', 'IT', 95000, '2017-04-05'),
    (10, 'Jack', 'Anderson', 'Finance', 105000, '2015-11-12');


WITH TopEmployees AS (
    SELECT TOP 10 PERCENT *
    FROM Employees
    ORDER BY Salary DESC
)
SELECT 
    Department,
    AVG(Salary) AS AverageSalary,
    CASE 
        WHEN AVG(Salary) > 80000 THEN 'High'
        WHEN AVG(Salary) >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM TopEmployees
GROUP BY Department
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;