CREATE OR REPLACE FUNCTION hotel.reservationget(_reservation_id INT, _room_id SMALLINT, _guest_id INT, _is_reserved BOOLEAN) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT r.reservation_id,
                 r.room_id,
                 r.guest_id,
                 r.dt_entry,
                 r.dt_exit,
                 r.is_reserved,
                 r.ch_employee,
                 r.dt_ch
          FROM hotel.reservation r
          WHERE r.reservation_id = COALESCE(_reservation_id, r.reservation_id)
            AND r.room_id        = COALESCE(_room_id, r.room_id)
            AND r.guest_id       = COALESCE(_guest_id, r.guest_id)
            AND r.is_reserved    = COALESCE(_is_reserved, r.is_reserved)) res;

END
$$;