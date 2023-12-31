CREATE TABLE IF NOT EXISTS history.saleschanges
(
    log_id         BIGSERIAL     NOT NULL,
    sale_id        INT           NOT NULL,
    employee_id    INT           NOT NULL,
    visitors       JSONB,
    reservation_id INT           NOT NULL,
    typefeed_id    SMALLINT      NOT NULL,
    review_id      INT,
    sale           NUMERIC(9, 2) NOT NULL,
    ch_employee    INT           NOT NULL,
    dt_ch          TIMESTAMPTZ   NOT NULL
);