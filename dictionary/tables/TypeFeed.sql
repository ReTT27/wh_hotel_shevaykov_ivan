CREATE TABLE IF NOT EXISTS dictionary.typefeed
(
    typefeed_id SMALLSERIAL   NOT NULL
        CONSTRAINT pk_typefeed PRIMARY KEY,
    name        VARCHAR(32)   NOT NULL,
    cost        NUMERIC(6, 2) NOT NULL
);