CREATE TABLE IF NOT EXISTS dictionary.post
(
    post_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_post PRIMARY KEY,
    name    VARCHAR(64) NOT NULL,
    salary  INT         NOT NULL
);