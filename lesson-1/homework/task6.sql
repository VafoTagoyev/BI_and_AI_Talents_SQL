DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255) CONSTRAINT df_customer_city DEFAULT 'Unknown'
);

ALTER TABLE customer
DROP CONSTRAINT df_customer_city;

ALTER TABLE customer
ADD CONSTRAINT df_customer_city DEFAULT 'Unknown' FOR city;