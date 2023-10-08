CREATE TABLE IF NOT EXISTS history.typetimelinechanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_typetimelinechanges PRIMARY KEY,
    timeline_id SMALLINT    NOT NULL,
    name        VARCHAR(32) NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);