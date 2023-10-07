CREATE TABLE IF NOT EXISTS dictionary.typerooms
(
    type_id      SMALLSERIAL   NOT NULL
        CONSTRAINT pk_typerooms PRIMARY KEY,
    name         VARCHAR(64)   NOT NULL,
    number_beds  VARCHAR(4)    NOT NULL,
    number_rooms SMALLINT      NOT NULL,
    cost         NUMERIC(7, 2) NOT NULL
);