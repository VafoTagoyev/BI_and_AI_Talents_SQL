DROP TABLE IF EXISTS data_types_demo;

CREATE TABLE data_types_demo (
    intsample INTEGER,
    tinyintsample TINYINT,
    smallintsample SMALLINT,
    bigintsample BIGINT,
    decimalsample DECIMAL(10,2),
    floatsample FLOAT,
    charsample CHAR(4),
    ncharsample NCHAR(5),
    varcharsample VARCHAR(50),
    nvarcharsample NVARCHAR(50),
    textsample TEXT,
    ntextsample NTEXT,
    datesample DATE,
    timesample TIME,
    datetimesample DATETIME,
    UQIsample UNIQUEIDENTIFIER,
    varbinarysample VARBINARY(MAX)
);

INSERT INTO data_types_demo
SELECT 1, 2, 3, 4, 5.6, 6.7, 'char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext', 
    '2025-02-16', '7:43:15', GETDATE(), NEWID(), BulkColumn from openrowset(BULK '/picture.jpg', SINGLE_BLOB) AS img;

SELECT * FROM data_types_demo;