CREATE TABLE IF NOT EXISTS history.employeechanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_employeechanges PRIMARY KEY,
    employee_id INT         NOT NULL,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    email       VARCHAR(32) NOT NULL,
    post_id     SMALLINT    NOT NULL,
    reward      INT         NOT NULL,
    pass_id     INT         NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);