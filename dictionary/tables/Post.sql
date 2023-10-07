CREATE TABLE IF NOT EXISTS dictionary.post
(
    post_id     SMALLSERIAL   NOT NULL
        CONSTRAINT pk_post PRIMARY KEY,
    name        VARCHAR(64)   NOT NULL,
    timeline_id SMALLINT      NOT NULL,
    salary      NUMERIC(7, 2) NOT NULL
);