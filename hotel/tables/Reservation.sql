CREATE TABLE IF NOT EXISTS hotel.reservation
(
    reservation_id INT         NOT NULL
        CONSTRAINT pk_reservation PRIMARY KEY,
    room_id        SMALLINT    NOT NULL,
    guest_id       INT         NOT NULL,
    dt_entry       TIMESTAMPTZ NOT NULL,
    dt_exit        TIMESTAMPTZ NOT NULL,
    is_reserved    BOOLEAN     NOT NULL,
    ch_employee    INT         NOT NULL,
    dt_ch          TIMESTAMPTZ NOT NULL,
    CONSTRAINT ch_reservation_entry_exit CHECK (dt_entry < dt_exit)
);