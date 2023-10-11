CREATE TABLE IF NOT EXISTS history.saleschanges
(
    log_id         BIGSERIAL   NOT NULL
        CONSTRAINT pk_saleschanges PRIMARY KEY,
    sale_id        INT         NOT NULL,
    employee_id    INT         NOT NULL,
    visitors       JSONB,
    reservation_id INT         NOT NULL,
    typefeed_id    SMALLINT    NOT NULL,
    review_id      INT,
    ch_employee    INT         NOT NULL,
    dt_ch          TIMESTAMPTZ NOT NULL
);