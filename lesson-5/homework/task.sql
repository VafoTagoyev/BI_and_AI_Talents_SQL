DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

-- 1. Assign a Unique Rank to Each Employee Based on Salary

SELECT 
    *,
    ROW_NUMBER() OVER(ORDER BY Salary DESC) as rank
FROM Employees
ORDER BY EmployeeID;

-- 2. Find Employees Who Have the Same Salary Rank


-- 3. Identify the Top 2 Highest Salaries in Each Department

SELECT * 
FROM
    (
        SELECT *, 
            ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) as rank 
        FROM Employees
    ) as t
WHERE rank <= 2;

-- 4. Find the Lowest-Paid Employee in Each Department

SELECT * 
FROM
    (
        SELECT *, 
            ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary) as rank 
        FROM Employees
    ) as t
WHERE rank <= 1;

-- 5. Calculate the Running Total of Salaries in Each Department
  
SELECT *,
    SUM(Salary) OVER(PARTITION BY Department ORDER BY EmployeeID) as sum_salary
FROM Employees

-- 6. Find the Total Salary of Each Department Without GROUP BY
  
SELECT *,
    SUM(Salary) OVER(PARTITION BY Department) as sum_salary
FROM Employees
  
-- 7. Calculate the Average Salary in Each Department Without GROUP BY
   
SELECT *,
    AVG(Salary) OVER(PARTITION BY Department) as average_salary
FROM Employees

-- 8. Find the Difference Between an Employee’s Salary and Their Department’s Average

SELECT *,
    Salary - AVG(Salary) OVER(PARTITION BY Department) as difference_salary
FROM Employees

-- 9. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

SELECT *,
    AVG(Salary) OVER(ORDER BY EmployeeID rows between 1 preceding and 1 following) as moving_average_salary
FROM Employees

-- 10. Find the Sum of Salaries for the Last 3 Hired Employees
   
SELECT SUM(Salary)
FROM
    (
        SELECT TOP 3 * 
        FROM Employees 
        ORDER BY HireDate DESC
    ) as t;
   
-- 11. Calculate the Running Average of Salaries Over All Previous Employees
   
SELECT *,
    AVG(Salary) OVER(ORDER BY EmployeeID)
FROM Employees;

-- 12. Find the Maximum Salary Over a Sliding Window of 2 Employees Before and After

SELECT *,
    MAX(Salary) OVER(ORDER BY EmployeeID rows between 2 preceding and 2 following)
FROM Employees;

-- 13. Determine the Percentage Contribution of Each Employee’s Salary to Their Department’s Total Salary

SELECT *,
    cast(Salary * 100 / SUM(Salary) OVER(PARTITION BY Department) as DECIMAL(10,2))
FROM Employees;