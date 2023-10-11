CREATE TABLE IF NOT EXISTS history.guestloyaltychanges
(
    lord_id         BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestloyaltychanges PRIMARY KEY,
    card_id         INT         NOT NULL,
    cashback_points INT         NOT NULL,
    dt_registration TIMESTAMPTZ NOT NULL,
    dt_use          TIMESTAMPTZ NOT NULL,
    is_actual       BOOLEAN     NOT NULL,
    ch_employee     INT         NOT NULL,
    dt_ch           TIMESTAMPTZ NOT NULL
);