DROP TABLE IF EXISTS books;

CREATE TABLE books (
    book_id INTEGER IDENTITY PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),
    genre VARCHAR(255) DEFAULT 'Unknown'
); 

INSERT INTO books
VALUES
    ('Book1', 45.6, 'Genre1'),
    ('Book2', 50, 'Genre2');

INSERT INTO books (title)
VALUES
    ('Book3');

SELECT * FROM books;