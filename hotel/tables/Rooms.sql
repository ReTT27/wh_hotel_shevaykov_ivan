CREATE TABLE IF NOT EXISTS hotel.rooms
(
    room_id   SMALLINT NOT NULL
        CONSTRAINT pk_rooms PRIMARY KEY,
    type_id   SMALLINT NOT NULL,
    level     SMALLINT NOT NULL,
    actuality BOOLEAN  NOT NULL
);