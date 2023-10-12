CREATE OR REPLACE FUNCTION hotel.reservationupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _reservation_id INT;
    _room_id        SMALLINT;
    _guest_id       INT;
    _dt_entry       TIMESTAMPTZ;
    _dt_exit        TIMESTAMPTZ;
    _is_reserved    BOOLEAN;
    _dt_ch          TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT COALESCE(r.reservation_id, nextval('hotel.reservationsq')) AS reservation_id,
           s.room_id,
           s.guest_id,
           s.dt_entry,
           s.dt_exit,
           s.is_reserved
    INTO _reservation_id,
         _room_id,
         _guest_id,
         _dt_entry,
         _dt_exit,
         _is_reserved
    FROM jsonb_to_record(_src) AS s (reservation_id INT,
                                     room_id        SMALLINT,
                                     guest_id       INT,
                                     dt_entry       TIMESTAMPTZ,
                                     dt_exit        TIMESTAMPTZ,
                                     is_reserved    BOOLEAN)
             LEFT JOIN hotel.reservation r
                       ON r.reservation_id = s.reservation_id;

    CASE
        WHEN (SELECT 1 FROM hotel.rooms r WHERE r.room_id != _room_id)
            THEN RETURN public.errmessage(_errcode := 'hotel.reservation_ins.room_not_exist',
                                          _msg     := 'Такого гостиночного номера не существует!',
                                          _detail  := concat('room_id = ', _room_id));
        WHEN (SELECT 1 FROM customerresources.guest g WHERE g.guest_id != _guest_id)
            THEN RETURN public.errmessage(_errcode := 'hotel.reservation_ins.guest_not_exist',
                                          _msg     := 'Такого гостя не существует!',
                                          _detail  := concat('guest_id = ', _guest_id));
        ELSE NULL;
    END CASE;

    WITH ins_cte AS (
        INSERT INTO hotel.reservation AS r (reservation_id,
                                            room_id,
                                            guest_id,
                                            dt_entry,
                                            dt_exit,
                                            is_reserved,
                                            dt_ch,
                                            ch_employee)
            SELECT _reservation_id,
                   _room_id,
                   _guest_id,
                   _dt_entry,
                   _dt_exit,
                   _is_reserved,
                   _dt_ch,
                   _ch_employee
            ON CONFLICT (reservation_id) DO UPDATE
                SET room_id     = excluded.room_id,
                    guest_id    = excluded.guest_id,
                    dt_entry    = excluded.dt_entry,
                    dt_exit     = excluded.dt_exit,
                    is_reserved = excluded.is_reserved,
                    dt_ch       = excluded.dt_ch,
                    ch_employee = excluded.ch_employee
        RETURNING r.*)

    INSERT INTO history.reservationchanges AS rc (reservation_id,
                                                  room_id,
                                                  guest_id,
                                                  dt_entry,
                                                  dt_exit,
                                                  is_reserved,
                                                  dt_ch,
                                                  ch_employee)
    SELECT ic.reservation_id,
           ic.room_id,
           ic.guest_id,
           ic.dt_entry,
           ic.dt_exit,
           ic.is_reserved,
           ic.dt_ch,
           ic.ch_employee
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;