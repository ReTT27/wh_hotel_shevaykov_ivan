CREATE TABLE IF NOT EXISTS dictionary.position
(
    post_id     SMALLSERIAL   NOT NULL
        CONSTRAINT pk_post PRIMARY KEY,
    name        VARCHAR(64)   NOT NULL,
    salary      NUMERIC(7, 2) NOT NULL
);