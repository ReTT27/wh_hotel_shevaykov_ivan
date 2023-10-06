CREATE TABLE IF NOT EXISTS hotel.reservation
(
    reservation_id BIGSERIAL   NOT NULL
        CONSTRAINT pk_reservation PRIMARY KEY,
    dt_entry       TIMESTAMPTZ NOT NULL,
    dt_exit        TIMESTAMPTZ NOT NULL
);