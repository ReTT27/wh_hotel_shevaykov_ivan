CREATE TABLE IF NOT EXISTS history.postchanges
(
    log_id      BIGSERIAL     NOT NULL
        CONSTRAINT pk_postchanges PRIMARY KEY,
    post_id     SMALLINT      NOT NULL,
    name        VARCHAR(64)   NOT NULL,
    timeline_id SMALLINT      NOT NULL,
    salary      NUMERIC(7, 2) NOT NULL,
    dt_ch       TIMESTAMPTZ   NOT NULL,
    ch_employee INT           NOT NULL
);