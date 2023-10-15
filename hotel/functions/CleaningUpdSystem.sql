CREATE OR REPLACE FUNCTION hotel.cleaningupdsystem(_ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _dt_ch TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
/*
    WITH cte AS (SELECT e.employee_id,
                        r.level,
                        row_number() OVER (PARTITION BY e.employee_id, r.level) rn,
                        row_number() OVER (PARTITION BY r.level) rn2
                 FROM hotel.employee e, hotel.rooms r
                 WHERE e.position_id = 6)
    SELECT concat(c2.employee_id, ' = ', c.level), c.rn, c2.rn
    FROM cte c
        INNER JOIN cte c2 ON c.rn = c2.rn2;*/

CREATE TEMPORARY TABLE IF NOT EXISTS tmp
(

) ON COMMIT DROP;

WITH cte AS (SELECT e.employee_id
             FROM hotel.employee e
             WHERE e.position_id = 6
             ORDER BY random())
SELECT

/*
    SELECT nextval('hotel.cleaningsq') AS cleaning_id,
           s.employee_id,
           s.room_id
    INTO _cleaning_id,
         _employee_id,
         _room_id
    FROM jsonb_to_recordset(_src) AS s (cleaning_id INT,
                                        employee_id INT,
                                        room_id     SMALLINT);

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
    FROM ins_cte ic;*/

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;