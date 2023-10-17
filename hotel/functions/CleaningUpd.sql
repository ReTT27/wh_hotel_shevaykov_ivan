CREATE OR REPLACE FUNCTION hotel.cleaningupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _cleaning_id INT;
    _employee_id INT;
    _room_id     SMALLINT;
    _dt_ch       TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT COALESCE(cl.cleaning_id, nextval('hotel.cleaningsq')) AS cleaning_id,
           s.employee_id,
           s.room_id
    INTO _cleaning_id,
         _employee_id,
         _room_id
    FROM jsonb_to_record(_src) AS s (cleaning_id INT,
                                     employee_id INT,
                                     room_id     SMALLINT)
             LEFT JOIN hotel.cleaning cl
                       ON cl.cleaning_id = s.cleaning_id;

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
                   _dt_ch::DATE,
                   _dt_ch,
                   _ch_employee
            ON CONFLICT (cleaning_id) DO UPDATE
                SET employee_id   = excluded.employee_id,
                    room_id       = excluded.room_id,
                    date_cleaning = excluded.date_cleaning,
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