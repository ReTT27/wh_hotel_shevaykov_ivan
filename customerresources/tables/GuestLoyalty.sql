CREATE TABLE IF NOT EXISTS customerresources.guestloyalty
(
    card_id         INT         NOT NULL
        CONSTRAINT pk_guestloyalty PRIMARY KEY,
    cashback_points INT         NOT NULL,
    dt_registration TIMESTAMPTZ NOT NULL,
    dt_use          TIMESTAMPTZ NOT NULL,
    is_actual       BOOLEAN DEFAULT TRUE,
    ch_employee     INT         NOT NULL,
    dt_ch           TIMESTAMPTZ NOT NULL
);