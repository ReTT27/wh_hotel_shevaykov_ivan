CREATE TABLE IF NOT EXISTS customerresources.guestloyalty
(
    id_loyalty        BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestloyalty PRIMARY KEY,
    id_guest          BIGINT      NOT NULL,
    cashback_points   INT         NOT NULL,
    date_registration TIMESTAMPTZ NOT NULL,
    date_use          TIMESTAMPTZ NOT NULL,
    is_actual         BOOLEAN     NOT NULL,
    CONSTRAINT uq_guest_loyalty UNIQUE (id_guest, id_loyalty)
);