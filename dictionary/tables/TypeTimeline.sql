CREATE TABLE IF NOT EXISTS dictionary.typetimeline
(
    timeline_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_typetimeline PRIMARY KEY,
    name        VARCHAR(32) NOT NULL
);