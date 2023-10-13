CREATE TABLE IF NOT EXISTS dictionary.typerooms
(
    type_id      SMALLINT      NOT NULL
        CONSTRAINT pk_typerooms PRIMARY KEY,
    name         VARCHAR(64)   NOT NULL,
    number_beds  VARCHAR(4)    NOT NULL,
    number_rooms SMALLINT      NOT NULL,
    cost         NUMERIC(8, 2) NOT NULL,
    CONSTRAINT ch_typerooms_cost CHECK ( cost > 0 )
);