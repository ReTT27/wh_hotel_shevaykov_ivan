CREATE TABLE IF NOT EXISTS history.reservationchanges
(
    log_id         BIGSERIAL   NOT NULL,
    reservation_id INT         NOT NULL,
    room_id        SMALLINT    NOT NULL,
    guest_id       INT         NOT NULL,
    dt_entry       DATE        NOT NULL,
    dt_exit        DATE        NOT NULL,
    is_reserved    BOOLEAN     NOT NULL,
    ch_employee    INT         NOT NULL,
    dt_ch          TIMESTAMPTZ NOT NULL
);