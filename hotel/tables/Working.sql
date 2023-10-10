CREATE TABLE IF NOT EXISTS hotel.working
(
    at_work     BIGSERIAL   NOT NULL
        CONSTRAINT pk_pass PRIMARY KEY,
    employee_id INT         NOT NULL,
    dt_touches  TIMESTAMPTZ NOT NULL
);