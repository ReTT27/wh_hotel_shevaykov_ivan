CREATE OR REPLACE FUNCTION hotel.workingget(_employee_id INT, _dt_touches DATE) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT w.at_work,
                 w.employee_id,
                 w.dt_touches
          FROM hotel.working w
          WHERE w.employee_id      = COALESCE(_employee_id, w.employee_id)
            AND w.dt_touches::DATE = COALESCE(_dt_touches, w.dt_touches::DATE)) res;

END
$$;