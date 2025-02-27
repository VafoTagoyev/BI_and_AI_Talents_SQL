DROP TABLE IF EXISTS letters;
create table letters(
    letter char(1)
);

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

SELECT *
FROM letters
ORDER BY 
    CASE
        WHEN letter = 'b' THEN 1
        ELSE 2
    END,
letter;

SELECT *
FROM letters
ORDER BY
    CASE 
        WHEN letter = 'b' THEN 2
        ELSE 1
    END,
letter;

SELECT *
FROM letters
ORDER BY
    CASE
        WHEN letter = 'b' THEN 2.5
        ELSE ROW_NUMBER() OVER (ORDER BY letter)
    END,
letter;