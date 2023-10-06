CREATE TABLE IF NOT EXISTS hotel.sales
(
    sale_id        BIGSERIAL NOT NULL
        CONSTRAINT pk_sales PRIMARY KEY,
    room_id        SMALLINT  NOT NULL,
    employee_id    INT       NOT NULL,
    guest_id       BIGINT    NOT NULL,
    visitors       JSONB,
    reservation_id BIGINT    NOT NULL,
    typefeed_id    SMALLINT  NOT NULL
);