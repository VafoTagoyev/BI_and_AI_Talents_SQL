DROP TABLE IF EXISTS worker;

CREATE TABLE worker (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50)
);

BULK INSERT worker
FROM '/task5.csv'
WITH (
    firstrow=2,
    fieldterminator=',',
    rowterminator='\n'
);

SELECT * FROM worker;