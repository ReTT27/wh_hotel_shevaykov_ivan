CREATE TABLE IF NOT EXISTS dictionary.typepayment
(
    payment_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_typepayment PRIMARY KEY,
    name       VARCHAR(32) NOT NULL
);