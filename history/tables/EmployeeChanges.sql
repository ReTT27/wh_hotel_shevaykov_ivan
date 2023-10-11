CREATE TABLE IF NOT EXISTS history.employeechanges
(
    log_id      BIGSERIAL     NOT NULL
        CONSTRAINT pk_employeechanges PRIMARY KEY,
    employee_id INT           NOT NULL,
    name        VARCHAR(64)   NOT NULL,
    phone       VARCHAR(11)   NOT NULL,
    email       VARCHAR(32)   NOT NULL,
    position_id SMALLINT      NOT NULL,
    reward      NUMERIC(7, 2) NOT NULL,
    is_deleted  BOOLEAN       NOT NULL,
    ch_employee INT           NOT NULL,
    dt_ch       TIMESTAMPTZ   NOT NULL
);