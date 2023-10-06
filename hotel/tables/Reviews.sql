CREATE TABLE IF NOT EXISTS hotel.reviews
(
    review_id SERIAL       NOT NULL
        CONSTRAINT pk_reviews PRIMARY KEY,
    category  VARCHAR(16)  NOT NULL,
    content   VARCHAR(500) NOT NULL
);