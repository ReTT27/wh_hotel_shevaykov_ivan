CREATE TABLE IF NOT EXISTS public.hotelinfo
(
    id_settings SMALLSERIAL  NOT NULL
        CONSTRAINT pk_hotelinfo PRIMARY KEY,
    name        VARCHAR(64)  NOT NULL,
    address     VARCHAR(128) NOT NULL,
    floor       SMALLINT     NOT NULL,
    rooms       SMALLINT     NOT NULL,
    owner       VARCHAR(64)  NOT NULL
);