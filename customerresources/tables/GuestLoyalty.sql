CREATE TABLE IF NOT EXISTS customerresources.guestloyalty
(
    loyalty_id        BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestloyalty PRIMARY KEY,
    guest_id          BIGINT      NOT NULL,
    cashback_points   INT         NOT NULL,
    date_registration TIMESTAMPTZ NOT NULL,
    date_use          TIMESTAMPTZ NOT NULL,
    is_actual         BOOLEAN     NOT NULL,
    CONSTRAINT uq_guest_loyalty UNIQUE (guest_id, loyalty_id)
);