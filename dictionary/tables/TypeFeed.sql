CREATE TABLE IF NOT EXISTS dictianory.typefeed
(
    typefeed_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_typefeed PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    cost        SMALLINT    NOT NULL
);