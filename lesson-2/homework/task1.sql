DROP TABLE IF EXISTS test_identity;

CREATE TABLE test_identity (
    id INTEGER PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255)
);

INSERT INTO test_identity (name)
VALUES ('Alice'), ('John'), ('Bob'), ('Cristiano'), ('Leo');

SELECT * FROM test_identity;

DELETE FROM test_identity WHERE id = 4;

SELECT * FROM test_identity;

TRUNCATE TABLE test_identity;

SELECT * FROM test_identity;

INSERT INTO test_identity (name)
VALUES ('Alice'), ('John'), ('Bob'), ('Cristiano'), ('Leo');

SELECT * FROM test_identity;

DROP TABLE test_identity;