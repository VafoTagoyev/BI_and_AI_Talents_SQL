DROP TABLE IF EXISTS WorkLog;
CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

DROP VIEW IF EXISTS vw_MonthlyWorkSummary;
CREATE VIEW vw_MonthlyWorkSummary AS
SELECT EmployeeID, 
    EmployeeName, 
    Department, 
    SUM(HoursWorked) as TotalHoursWorked,
    (SELECT SUM(HoursWorked) FROM WorkLog wl2 WHERE wl2.Department = wl1.Department) as TotalHoursDepartment,
    (SELECT AVG(HoursWorked) FROM Worklog wl2 WHERE wl2.Department = wl1.Department) as AvgHoursDepartment
FROM WorkLog wl1
GROUP BY EmployeeID, EmployeeName, Department;

SELECT * FROM vw_MonthlyWorkSummary;