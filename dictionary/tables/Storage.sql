CREATE TABLE IF NOT EXISTS dictionary.storage
(
    thing_id SMALLINT    NOT NULL,
    name     VARCHAR(32) NOT NULL,
    count    SMALLINT    NOT NULL,
    CONSTRAINT ch_storage_count CHECK (count > 0)
);