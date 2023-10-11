CREATE TABLE IF NOT EXISTS hotel.reviews
(
    review_id   SERIAL       NOT NULL
        CONSTRAINT pk_reviews PRIMARY KEY,
    date_review DATE         NOT NULL,
    category    SMALLINT     NOT NULL,
    content     VARCHAR(500) NOT NULL
);