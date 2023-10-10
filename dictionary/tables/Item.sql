CREATE TABLE IF NOT EXISTS dictionary.item
(
    item_id SMALLSERIAL NOT NULL,
    name    VARCHAR(32) NOT NULL,
    count   SMALLINT    NOT NULL
);