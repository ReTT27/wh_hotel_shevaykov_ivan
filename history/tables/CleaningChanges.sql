CREATE TABLE IF NOT EXISTS history.cleaningchanges
(
    log_id        BIGSERIAL   NOT NULL,
    cleaning_id   INT         NOT NULL,
    employee_id   INT         NOT NULL,
    room_id       SMALLINT    NOT NULL,
    date_cleaning DATE        NOT NULL,
    ch_employee   INT         NOT NULL,
    dt_ch         TIMESTAMPTZ NOT NULL
) PARTITION BY RANGE (date_cleaning);