DROP TABLE IF EXISTS student;

CREATE TABLE student (
    id INTEGER,
    name TEXT,
    age INTEGER
);

ALTER TABLE student
ALTER COLUMN id INTEGER NOT NULL;

INSERT INTO student
VALUES (1, 'John', 20),
        (2, 'Alice', NULL);

SELECT * FROM student;