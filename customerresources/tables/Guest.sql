CREATE TABLE IF NOT EXISTS customerresources.guest
(
    guest_id  BIGSERIAL   NOT NULL
        CONSTRAINT pk_guest PRIMARY KEY,
    name      VARCHAR(64) NOT NULL,
    phone     VARCHAR(11) NOT NULL,
    email     VARCHAR(32) NOT NULL,
    birth_day DATE        NOT NULL
);