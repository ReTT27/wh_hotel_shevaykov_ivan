CREATE OR REPLACE FUNCTION hotel.cleaningget(_cleaning_id INT, _employee_id INT, _room_id INT, _date DATE) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
    FROM (SELECT c.cleaning_id,
                 c.employee_id,
                 c.room_id,
                 c.date_cleaning,
                 c.ch_employee,
                 c.dt_ch
          FROM hotel.cleaning c
          WHERE c.cleaning_id   = COALESCE(_cleaning_id, c.cleaning_id)
            AND c.employee_id   = COALESCE(_employee_id, c.employee_id)
            AND c.room_id       = COALESCE(_room_id, c.room_id)
            AND c.date_cleaning = COALESCE(_date, c.date_cleaning)) res;

END
$$;