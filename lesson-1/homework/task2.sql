DROP TABLE IF EXISTS product

CREATE TABLE product (
    product_id INTEGER,
    product_name VARCHAR(255),
    price DECIMAL,
    CONSTRAINT unique_product_id UNIQUE(product_id)
)

ALTER TABLE product 
DROP CONSTRAINT unique_product_id;

ALTER TABLE product 
ADD CONSTRAINT unique_product UNIQUE (product_id, product_name);