CREATE TABLE IF NOT EXISTS history.guestchanges
(
    lord_id     BIGSERIAL   NOT NULL,
    guest_id    INT         NOT NULL,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    email       VARCHAR(32) NOT NULL,
    birth_day   DATE        NOT NULL,
    card_id     INT,
    ch_employee INT         NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL
);