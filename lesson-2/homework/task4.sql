DROP TABLE IF EXISTS student;

CREATE TABLE student (
    id INTEGER PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL,
    classes INTEGER NOT NULL,
    tuition_per_class INTEGER NOT NULL,
    total_tuition AS classes*tuition_per_class
);

INSERT INTO student (name, classes, tuition_per_class)
VALUES 
    ('Alice', 5, 150),
    ('Bob', 3, 200),
    ('Johm', 4, 175);

SELECT * FROM student;