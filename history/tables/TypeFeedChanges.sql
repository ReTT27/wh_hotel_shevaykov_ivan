CREATE TABLE IF NOT EXISTS history.typefeedchanges
(
    log_id      BIGSERIAL     NOT NULL
        CONSTRAINT pk_typefeedchanges PRIMARY KEY,
    typefeed_id SMALLINT      NOT NULL,
    name        VARCHAR(32)   NOT NULL,
    cost        NUMERIC(6, 2) NOT NULL,
    dt_ch       TIMESTAMPTZ   NOT NULL,
    ch_employee INT           NOT NULL
);