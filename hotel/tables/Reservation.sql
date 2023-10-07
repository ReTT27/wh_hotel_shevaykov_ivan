CREATE TABLE IF NOT EXISTS hotel.reservation
(
    reservation_id SERIAL      NOT NULL
        CONSTRAINT pk_reservation PRIMARY KEY,
    room_id        SMALLINT    NOT NULL,
    guest_id       INT         NOT NULL,
    dt_entry       TIMESTAMPTZ NOT NULL,
    dt_exit        TIMESTAMPTZ NOT NULL
);