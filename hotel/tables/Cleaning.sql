CREATE TABLE IF NOT EXISTS hotel.cleaning
(
    cleaning_id   SERIAL   NOT NULL
        CONSTRAINT pk_cleaning PRIMARY KEY,
    employee_id   INT      NOT NULL,
    room_id       SMALLINT NOT NULL,
    date_cleaning DATE     NOT NULL
);