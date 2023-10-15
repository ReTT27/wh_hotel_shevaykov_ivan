CREATE OR REPLACE FUNCTION hotel.cleaningupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _cleaning_id   INT;
    _employee_id   INT;
    _room_id       SMALLINT;
    _date_cleaning DATE        := now()::DATE AT TIME ZONE 'Europe/Moscow';
    _dt_ch         TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT COALESCE(c.cleaning_id, nextval('hotel.cleaningsq')) AS cleaning_id,
           s.employee_id,
           s.room_id,
           s.date_cleaning
    INTO _cleaning_id,
         _employee_id,
         _room_id,
         _date_cleaning
    FROM jsonb_to_recordset(_src) AS s (cleaning_id   INT,
                                        employee_id   INT,
                                        room_id       SMALLINT,
                                        date_cleaning DATE)
             LEFT JOIN hotel.cleaning c
                       ON c.cleaning_id = s.cleaning_id;

    CASE
        WHEN (SELECT 1 FROM hotel.employee e WHERE e.employee_id != _employee_id)
            THEN RETURN public.errmessage(_errcode := 'hotel.cleaning_ins.employee_not_exist',
                                          _msg     := 'Такого сотрудника не существует!',
                                          _detail  := concat('employee_id = ', _employee_id));
        WHEN (SELECT 1 FROM hotel.rooms r WHERE r.room_id != _room_id)
            THEN RETURN public.errmessage(_errcode := 'hotel.cleaning_ins.room_not_exist',
                                          _msg     := 'Такой комнаты не существует!',
                                          _detail  := concat('room_id = ', _room_id));
        ELSE NULL;
    END CASE;

    WITH ins_cte AS (
        INSERT INTO hotel.cleaning AS c (cleaning_id,
                                         employee_id,
                                         room_id,
                                         date_cleaning,
                                         dt_ch,
                                         ch_employee)
            SELECT _cleaning_id,
                   _employee_id,
                   _room_id,
                   _date_cleaning,
                   _dt_ch,
                   _ch_employee
            ON CONFLICT (cleaning_id) DO UPDATE
                SET employee_id   = excluded.employee_id,
                    room_id       = excluded.room_id,
                    dt_ch         = excluded.dt_ch,
                    ch_employee   = excluded.ch_employee
        RETURNING c.*)

    INSERT INTO history.cleaningchanges AS cc (cleaning_id,
                                               employee_id,
                                               room_id,
                                               date_cleaning,
                                               dt_ch,
                                               ch_employee)
    SELECT ic.cleaning_id,
           ic.employee_id,
           ic.room_id,
           ic.date_cleaning,
           ic.dt_ch,
           ic.ch_employee
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;