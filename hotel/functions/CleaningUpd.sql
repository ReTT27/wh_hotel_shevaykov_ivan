CREATE OR REPLACE FUNCTION hotel.cleaningupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _cleaning_id INT;
    _employee_id INT;
    _room_id     SMALLINT;
    _dt_ch       TIMESTAMPTZ := NOW() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT COALESCE(cl.cleaning_id, NEXTVAL('hotel.cleaningsq')) AS cleaning_id,
           s.employee_id,
           s.room_id
    INTO _cleaning_id,
         _employee_id,
         _room_id
    FROM JSONB_TO_RECORD(_src) AS s(cleaning_id INT,
                                    employee_id INT,
                                    room_id     SMALLINT)
             LEFT JOIN hotel.cleaning cl
                       ON cl.cleaning_id = s.cleaning_id;

    WITH ins_cte AS (
        INSERT INTO hotel.cleaning AS c(cleaning_id,
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
                SET employee_id   = EXCLUDED.employee_id,
                    room_id       = EXCLUDED.room_id,
                    date_cleaning = EXCLUDED.date_cleaning,
                    dt_ch         = EXCLUDED.dt_ch,
                    ch_employee   = EXCLUDED.ch_employee
        RETURNING c.*)

    INSERT INTO history.cleaningchanges AS cc(cleaning_id,
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