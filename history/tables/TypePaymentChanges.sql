CREATE TABLE IF NOT EXISTS history.typepaymentchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_typepaymentchanges PRIMARY KEY,
    payment_id  SMALLSERIAL NOT NULL,
    name        VARCHAR(32) NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);