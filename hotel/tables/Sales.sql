CREATE TABLE IF NOT EXISTS hotel.sales
(
    sale_id        INT         NOT NULL
        CONSTRAINT pk_sales PRIMARY KEY,
    employee_id    INT         NOT NULL,
    visitors       JSONB,
    reservation_id INT         NOT NULL,
    typefeed_id    SMALLINT    NOT NULL,
    review_id      INT,
    ch_employee    INT         NOT NULL,
    dt_ch          TIMESTAMPTZ NOT NULL,
    CONSTRAINT uq_sales_reservation_sale UNIQUE (reservation_id, sale_id)
);