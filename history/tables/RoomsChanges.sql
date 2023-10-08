CREATE TABLE IF NOT EXISTS history.roomschanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_roomschanges PRIMARY KEY,
    room_id     SMALLINT    NOT NULL,
    type_id     SMALLINT    NOT NULL,
    level       SMALLINT    NOT NULL,
    actuality   BOOLEAN     NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);