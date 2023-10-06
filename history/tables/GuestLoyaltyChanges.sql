CREATE TABLE IF NOT EXISTS history.guestloyaltychanges
(
    log_id            BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestloyaltychanges PRIMARY KEY,
    loyalty_id        INT         NOT NULL,
    guest_id          INT         NOT NULL,
    cashback_points   INT         NOT NULL,
    date_registration TIMESTAMPTZ NOT NULL,
    date_use          TIMESTAMPTZ NOT NULL,
    is_actual         BOOLEAN     NOT NULL,
    dt_ch             TIMESTAMPTZ NOT NULL,
    ch_employee       INT         NOT NULL
);