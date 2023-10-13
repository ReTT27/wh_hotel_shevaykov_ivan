CREATE TABLE IF NOT EXISTS dictionary.typefeed
(
    typefeed_id SMALLINT      NOT NULL
        CONSTRAINT pk_typefeed PRIMARY KEY,
    name        VARCHAR(32)   NOT NULL,
    content     VARCHAR(128)  NOT NULL,
    cost        NUMERIC(7, 2) NOT NULL,
    CONSTRAINT ch_typefeed_cost CHECK ( cost > 0 )
);