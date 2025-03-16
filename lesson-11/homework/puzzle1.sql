DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);

drop table if exists #employeetransfers;
CREATE TABLE #EmployeeTransfers (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO #EmployeeTransfers
SELECT EmployeeID,
    Name,
    IIF(Department = 'HR', 'IT', 
        IIF(Department = 'IT', 
            'Sales', 
            'HR'
        )
    ) as Department,
    salary
FROM Employees;


SELECT * FROM #EmployeeTransfers;