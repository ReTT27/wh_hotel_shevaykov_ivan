CREATE TABLE IF NOT EXISTS history.guestloyaltychanges
(
    log_id            BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestloyaltychanges PRIMARY KEY,
    id_loyalty        BIGINT      NOT NULL,
    id_guest          BIGINT      NOT NULL,
    cashback_points   INT         NOT NULL,
    date_registration TIMESTAMPTZ NOT NULL,
    date_use          TIMESTAMPTZ NOT NULL,
    is_actual         BOOLEAN     NOT NULL,
    dt_ch             TIMESTAMPTZ NOT NULL,
    ch_employee       INT         NOT NULL
);
