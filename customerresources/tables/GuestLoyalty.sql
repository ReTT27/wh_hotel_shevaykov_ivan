CREATE TABLE IF NOT EXISTS customerresources.guestloyalty
(
    card_id         SERIAL      NOT NULL
        CONSTRAINT pk_guestloyalty PRIMARY KEY,
    guest_id        INT         NOT NULL,
    cashback_points INT         NOT NULL,
    dt_registration TIMESTAMPTZ NOT NULL,
    dt_use          TIMESTAMPTZ NOT NULL,
    is_actual       BOOLEAN     NOT NULL
);