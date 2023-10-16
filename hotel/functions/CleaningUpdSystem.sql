CREATE OR REPLACE FUNCTION hotel.cleaningupdsystem(_ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _dt_ch       TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
    _employee_id INT[];
    _count_emp   INT:=0::INT;
    _total INT:=1::INT;
    i INT:= 10::INT;
BEGIN

        SELECT array_agg(e.employee_id)
        INTO _employee_id
        FROM hotel.employee e
        WHERE e.position_id = 6
          AND e.employee_id IN
              (SELECT w.employee_id FROM hotel.working w WHERE now()::DATE = w.dt_touches::DATE);


    SELECT count(*)
    INTO _count_emp
        FROM hotel.employee e
        WHERE e.position_id = 6
          AND e.employee_id IN
              (SELECT w.employee_id FROM hotel.working w WHERE now()::DATE = w.dt_touches::DATE);

        WHILE (i < 30)
        LOOP

                    INSERT INTO hotel.cleaning AS c(cleaning_id,
                                                    employee_id,
                                                    room_id,
                                                    date_cleaning,
                                                    ch_employee,
                                                    dt_ch)
                    SELECT nextval('hotel.cleaningsq'),
                           _employee_id[_total]::INT,
                           i,
                           _dt_ch::DATE,
                           _ch_employee,
                           _dt_ch
                    FROM hotel.employee e
                    WHERE e.employee_id::INT = _employee_id[_total]::INT;

                    SELECT CASE
                        WHEN (_total::INT = _count_emp::INT)
                            THEN  (SELECT 1)
                        ELSE (SELECT _total+1)
                    END
                    INTO _total;

                    SELECT i+1
                    INTO i;

                    END LOOP;


        RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;