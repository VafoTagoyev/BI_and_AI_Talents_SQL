DROP TABLE IF EXISTS [dbo].[EMPLOYEES_N];

CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
)
 
INSERT INTO [dbo].[EMPLOYEES_N]
VALUES
	(1001,'Pawan','1975-02-21'),
	(1002,'Ramesh','1976-02-21'),
	(1003,'Avtaar','1977-02-21'),
	(1004,'Marank','1979-02-21'),
	(1008,'Ganesh','1979-02-21'),
	(1007,'Prem','1980-02-21'),
	(1016,'Qaue','1975-02-21'),
	(1155,'Rahil','1975-02-21'),
	(1102,'Suresh','1975-02-21'),
	(1103,'Tisha','1975-02-21'),
	(1104,'Umesh','1972-02-21'),
	(1024,'Veeru','1975-02-21'),
	(1207,'Wahim','1974-02-21'),
	(1046,'Xhera','1980-02-21'),
	(1025,'Wasil','1975-02-21'),
	(1052,'Xerra','1982-02-21'),
	(1073,'Yash','1983-02-21'),
	(1084,'Zahar','1984-02-21'),
	(1094,'Queen','1985-02-21'),
	(1027,'Ernst','1980-02-21'),
	(1116,'Ashish','1990-02-21'),
	(1225,'Bushan','1997-02-21');

SELECT * FROM DBO.EMPLOYEES_N;

WITH YEARS_TABLE AS (
    -- Generate all years from 1975 to the current year
    SELECT 1975 + T.N AS HIRE_YEAR
    FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS N
        FROM MASTER..SPT_VALUES
    ) AS T
    WHERE 1975 + T.N <= YEAR(GETDATE())
),
MISSING_YEARS AS (
    -- Find years where no employees were hired
    SELECT Y.HIRE_YEAR
    FROM YEARS_TABLE Y
    LEFT JOIN (SELECT DISTINCT YEAR(HIRE_DATE) AS HIRE_YEAR FROM DBO.EMPLOYEES_N) AS E
    ON Y.HIRE_YEAR = E.HIRE_YEAR
    WHERE E.HIRE_YEAR IS NULL
),
GAP_GROUPS AS (
    -- Create groups of consecutive missing years
    SELECT HIRE_YEAR, HIRE_YEAR - ROW_NUMBER() OVER (ORDER BY HIRE_YEAR) AS GROUP_ID
    FROM MISSING_YEARS
)
-- Get the start and end of each missing year interval
SELECT CONCAT(MIN(HIRE_YEAR), ' - ', MAX(HIRE_YEAR)) AS YEARS
FROM GAP_GROUPS
GROUP BY GROUP_ID
ORDER BY MIN(HIRE_YEAR);





