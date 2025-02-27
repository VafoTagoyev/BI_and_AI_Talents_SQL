DROP TABLE IF EXISTS Projects;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments (
    DepartmentID INTEGER PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    DepartmentID INTEGER,
    Salary INTEGER
);

CREATE TABLE Projects (
    ProjectID INTEGER PRIMARY KEY IDENTITY(1,1),
    ProjectName VARCHAR(50),
    EmployeeID INTEGER
);

INSERT INTO Departments
VALUES (101, 'IT'), 
    (102, 'HR'), 
    (103, 'Finance'),
    (104, 'Marketing');

INSERT INTO Employees(name, DepartmentID, Salary)
VALUES ('Alice', 101, 60000),
    ('Bob', 102, 70000),
    ('Charlie', 101, 65000),
    ('David', 103, 72000),
    ('Eva', NULL, 68000);

INSERT INTO Projects
VALUES ('Alpha', 1),
    ('Beta', 2),
    ('Gamma', 1),
    ('Delta', 4),
    ('Omega', NULL);


SELECT * FROM Employees;
SELECT * FROM Projects;
SELECT * FROM Departments;

-- 1. **INNER JOIN**  
--    - Write a query to get a list of employees along with their department names.  

SELECT
    e.EmployeeID, e.Name, e.Salary, d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    on d.DepartmentID = e.DepartmentID;

-- 2. **LEFT JOIN**  
--    - Write a query to list all employees, including those who are not assigned to any department.  

SELECT
    e.EmployeeID, e.Name, e.Salary, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
    on d.DepartmentID = e.DepartmentID;

-- 3. **RIGHT JOIN**  
--    - Write a query to list all departments, including those without employees.  

SELECT
    e.EmployeeID, e.Name, e.Salary, d.DepartmentName
FROM Employees e
RIGHT JOIN Departments d
    on d.DepartmentID = e.DepartmentID;

-- 4. **FULL OUTER JOIN**  
--    - Write a query to retrieve all employees and all departments, even if there’s no match between them.   

SELECT
    e.EmployeeID, e.Name, e.Salary, d.DepartmentID, d.DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d
    on e.DepartmentID = d.DepartmentID;

-- 5. **JOIN with Aggregation**  
--    - Write a query to find the total salary expense for each department.  

SELECT
    d.DepartmentName, SUM(e.Salary)
FROM Employees e
RIGHT JOIN Departments d
    on d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

-- 6. **CROSS JOIN**  
--    - Write a query to generate all possible combinations of departments and projects.  

SELECT
    e.EmployeeID, e.Name, e.Salary, d.DepartmentID, d.DepartmentName
FROM Employees e
CROSS JOIN Departments d;

-- 7. **MULTIPLE JOINS**  
--    - Write a query to get a list of employees with their department names and assigned project names. Include employees even if they don’t have a project.  

SELECT
    e.Name, d.DepartmentName, p.ProjectName
FROM Employees e
LEFT JOIN Departments d
    on d.DepartmentID = e.DepartmentID
LEFT JOIN Projects p
    on p.EmployeeID = e.EmployeeID;