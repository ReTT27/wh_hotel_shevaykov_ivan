CREATE TABLE IF NOT EXISTS history.guestchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestchanges PRIMARY KEY,
    guest_id    INT         NOT NULL,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    email       VARCHAR(32) NOT NULL,
    birth_day   DATE        NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);