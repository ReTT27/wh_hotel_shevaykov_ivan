CREATE TABLE IF NOT EXISTS dictionary.cleaningthing
(
    thing_id SMALLSERIAL NOT NULL,
    name     VARCHAR(32) NOT NULL,
    count    SMALLINT    NOT NULL,
    CONSTRAINT ch_cleaningthing_count CHECK (count > 0)
);