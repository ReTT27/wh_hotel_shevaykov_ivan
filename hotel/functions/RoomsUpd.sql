CREATE OR REPLACE FUNCTION hotel.roomsupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _room_id SMALLINT;
    _type_id SMALLINT;
    _level   SMALLINT;
BEGIN

    SELECT COALESCE(r.room_id, NEXTVAL('hotel.roomssq')) AS room_id,
           s.type_id,
           s.level
    INTO _room_id,
         _type_id,
         _level
    FROM JSONB_TO_RECORD(_src) AS s(room_id SMALLINT,
                                    type_id SMALLINT,
                                    level   SMALLINT)
             LEFT JOIN hotel.rooms r
                       ON s.room_id = r.room_id;

    INSERT INTO hotel.rooms AS r(room_id,
                                 type_id,
                                 level)
    SELECT _room_id,
           _type_id,
           _level
    ON CONFLICT (room_id) DO UPDATE
        SET type_id = EXCLUDED.type_id;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;