CREATE OR REPLACE FUNCTION hotel.employeeget(_employee_id INT, _phone VARCHAR, _is_deleted BOOLEAN) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT e.employee_id,
                 e.name,
                 e.phone,
                 e.email,
                 e.position_id,
                 e.reward,
                 e.is_deleted,
                 e.ch_employee,
                 e.dt_ch
          FROM hotel.employee e
          WHERE e.employee_id = COALESCE(_employee_id, e.employee_id)
            AND e.phone       = COALESCE(_phone, e.phone)
            AND e.is_deleted  = COALESCE(_is_deleted, e.is_deleted)) res;

END
$$;
