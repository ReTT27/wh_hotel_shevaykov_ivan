CREATE TABLE IF NOT EXISTS dictionary.position
(
    position_id SMALLINT      NOT NULL
        CONSTRAINT pk_position PRIMARY KEY,
    name        VARCHAR(64)   NOT NULL,
    salary      NUMERIC(8, 2) NOT NULL,
    CONSTRAINT ch_position_salary CHECK ( salary > 0 )
);