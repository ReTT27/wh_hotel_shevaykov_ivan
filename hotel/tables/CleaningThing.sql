CREATE TABLE IF NOT EXISTS hotel.cleaningthing
(
    set_id      BIGSERIAL   NOT NULL,
    cleaning_id INT         NOT NULL,
    thing_id    SMALLINT    NOT NULL,
    thing_count SMALLINT    NOT NULL,
    ch_employee INT         NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    CONSTRAINT ch_cleaningthing_thing_count CHECK (thing_count > 0)
);