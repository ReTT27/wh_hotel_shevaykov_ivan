CREATE TABLE IF NOT EXISTS hotel.sales
(
    sale_id        SERIAL      NOT NULL
        CONSTRAINT pk_sales PRIMARY KEY,
    employee_id    INT         NOT NULL,
    visitors       JSONB,
    reservation_id INT         NOT NULL,
    typefeed_id    SMALLINT    NOT NULL,
    review_id      INT,
    ch_employee    INT         NOT NULL,
    dt_ch          TIMESTAMPTZ NOT NULL
);