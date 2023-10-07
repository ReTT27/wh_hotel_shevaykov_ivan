CREATE TABLE IF NOT EXISTS hotel.employee
(
    employee_id SERIAL        NOT NULL
        CONSTRAINT pk_employee PRIMARY KEY,
    name        VARCHAR(64)   NOT NULL,
    phone       VARCHAR(11)   NOT NULL,
    email       VARCHAR(32)   NOT NULL,
    post_id     SMALLINT      NOT NULL,
    reward      NUMERIC(7, 2) NOT NULL,
    pass_id     INT           NOT NULL
);