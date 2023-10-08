CREATE TABLE IF NOT EXISTS history.reviewschanges
(
    log_id      BIGSERIAL    NOT NULL
        CONSTRAINT pk_reviewschanges PRIMARY KEY,
    review_id   INT          NOT NULL,
    category    VARCHAR(16)  NOT NULL,
    content     VARCHAR(500) NOT NULL,
    dt_ch       TIMESTAMPTZ  NOT NULL,
    ch_employee INT          NOT NULL
);