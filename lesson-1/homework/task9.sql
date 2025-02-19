DROP TABLE IF EXISTS loan;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS member;

CREATE TABLE book (
    book_id INTEGER PRIMARY KEY IDENTITY,
    title NVARCHAR(255),
    author NVARCHAR(255),
    published_year INTEGER
);

CREATE TABLE member (
    member_id INTEGER PRIMARY KEY IDENTITY,
    name NVARCHAR(255),
    email NVARCHAR(255),
    phone_number NVARCHAR(255)
);

CREATE TABLE loan (
    loan_id INTEGER PRIMARY KEY IDENTITY,
    book_id INTEGER FOREIGN KEY REFERENCES book(book_id),
    member_id INTEGER FOREIGN KEY REFERENCES member(member_id),
    loan_date DATE,
    return_date DATE NULL
);

INSERT INTO Book (title, author, published_year) VALUES
('The Catcher in the Rye', 'J.D. Salinger', 1951),
('To Kill a Mockingbird', 'Harper Lee', 1960),
('1984', 'George Orwell', 1949);

INSERT INTO Member (name, email, phone_number) VALUES
('Alice', 'alice@gmail.com', '+1234567890'),
('Bob', 'bob@gmail.com', '+9876543210'),
('John', 'john@gmail.com', '+5556667777');

INSERT INTO Loan (book_id, member_id, loan_date, return_date) VALUES
(1, 2, '2025-02-01', '2025-02-10'),
(2, 1, '2025-02-05', NULL),
(2, 2, '2025-02-07', NULL);

SELECT * FROM book;
SELECT * FROM member;
SELECT * FROM loan;