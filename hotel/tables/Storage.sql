CREATE TABLE IF NOT EXISTS hotel.storage
(
    set_id      INT         NOT NULL,
    cleaning_id SMALLINT    NOT NULL,
    thing_id    SMALLINT    NOT NULL,
    thing_count SMALLINT    NOT NULL,
    ch_employee INT         NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    CONSTRAINT ch_storage_thing_count CHECK (thing_count > 0)
);