CREATE TABLE IF NOT EXISTS history.passchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_passchanges PRIMARY KEY,
    pass_id     INT         NOT NULL,
    dt_input    TIMESTAMPTZ NOT NULL,
    dt_output   TIMESTAMPTZ NOT NULL,
    work        BOOLEAN     NOT NULL,
    ch_employee INT         NOT NULL
);