DROP TABLE IF EXISTS invoice;

CREATE TABLE invoice (
    invoice_id INTEGER IDENTITY PRIMARY KEY,
    amount DECIMAL(10,2)
);

INSERT INTO invoice (amount) 
VALUES 
    (1.14), (3.14), (2.71), (2.54), (0.967);


SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount) VALUES (100, 5.6);

SET IDENTITY_INSERT invoice OFF;

SELECT * FROM invoice;