CREATE TABLE IF NOT EXISTS history.cleaningchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_cleaningchanges PRIMARY KEY,
    cleaning_id INT         NOT NULL,
    employee_id INT         NOT NULL,
    room_id     SMALLINT    NOT NULL,
    dt_cleaning DATE        NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);