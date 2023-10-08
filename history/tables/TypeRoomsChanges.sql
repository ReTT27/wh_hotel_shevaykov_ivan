CREATE TABLE IF NOT EXISTS history.typeroomschanges
(
    log_id       BIGSERIAL     NOT NULL
        CONSTRAINT pk_typeroomschanges PRIMARY KEY,
    type_id      SMALLINT      NOT NULL,
    name         VARCHAR(64)   NOT NULL,
    number_beds  VARCHAR(4)    NOT NULL,
    number_rooms SMALLINT      NOT NULL,
    cost         NUMERIC(7, 2) NOT NULL,
    dt_ch        TIMESTAMPTZ   NOT NULL,
    ch_employee  INT           NOT NULL
);