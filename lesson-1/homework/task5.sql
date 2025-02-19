DROP TABLE IF EXISTS account;

CREATE TABLE account (
    account_id INTEGER PRIMARY KEY,
    balance DECIMAL,
    account_type VARCHAR(8),
    CONSTRAINT account_balance_check CHECK (balance >= 0),
    CONSTRAINT account_type_check CHECK (account_type IN ('Saving', 'Checking'))
);

ALTER TABLE account 
DROP CONSTRAINT account_balance_check;

ALTER TABLE account 
DROP CONSTRAINT account_type_check;

ALTER TABLE account 
ADD CONSTRAINT account_balance_check 
CHECK (balance >= 0);

ALTER TABLE account 
ADD CONSTRAINT account_type_check 
CHECK (account_type IN ('Saving', 'Checking'));