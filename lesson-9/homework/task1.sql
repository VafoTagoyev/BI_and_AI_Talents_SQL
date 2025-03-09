drop table if exists Employees;

CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);

INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

;WITH cte AS (
    SELECT *, 0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.*, Depth + 1
    FROM Employees e 
	JOIN cte 
	ON e.ManagerID = cte.EmployeeID
)
SELECT * FROM cte;
