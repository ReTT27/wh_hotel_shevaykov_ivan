CREATE TABLE IF NOT EXISTS customerresources.guest
(
    guest_id    INT         NOT NULL
        CONSTRAINT pk_guest PRIMARY KEY,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    email       VARCHAR(32) NOT NULL,
    birth_day   DATE        NOT NULL,
    card_id     INT,
    ch_employee INT         NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    CONSTRAINT uq_guest_guest_card UNIQUE (guest_id, card_id)
);