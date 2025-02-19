DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INTEGER,
    customer_name TEXT,
    order_date DATE,
    CONSTRAINT PK_order_id PRIMARY KEY(order_id)
);

ALTER TABLE orders
DROP CONSTRAINT PK_order_id;

ALTER TABLE orders
    ADD CONSTRAINT PK_order_id PRIMARY KEY(order_id);