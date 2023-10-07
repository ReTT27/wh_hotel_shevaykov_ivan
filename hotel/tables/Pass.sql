CREATE TABLE IF NOT EXISTS hotel.pass
(
    pass_id   INT         NOT NULL
        CONSTRAINT pk_pass PRIMARY KEY,
    dt_input  TIMESTAMPTZ NOT NULL,
    dt_output TIMESTAMPTZ NOT NULL,
    work      BOOLEAN     NOT NULL
);