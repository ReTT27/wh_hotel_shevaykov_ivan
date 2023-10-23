CREATE OR REPLACE FUNCTION hotel.roomsget(_room_id INT, _type_id INT, _level INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
    FROM (SELECT r.room_id,
                 r.type_id,
                 r.level
          FROM hotel.rooms r
          WHERE r.room_id = COALESCE(_room_id, r.room_id)
            AND r.type_id = COALESCE(_type_id, r.type_id)
            AND r.level   = COALESCE(_level, r.level)) res;

END
$$;