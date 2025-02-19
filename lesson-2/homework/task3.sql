DROP TABLE IF EXISTS photos;

CREATE TABLE photos (
    id INTEGER PRIMARY KEY IDENTITY(1,1),
    photo VARBINARY(MAX)
);

INSERT INTO photos (photo)
SELECT BulkColumn FROM OPENROWSET(
    BULK '/picture.jpg', SINGLE_BLOB
) AS img;

SELECT * FROM photos;