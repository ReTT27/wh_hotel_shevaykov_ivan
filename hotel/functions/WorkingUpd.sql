CREATE OR REPLACE FUNCTION hotel.workingupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _employee_id INT;
    _dt_touches  TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT s.employee_id
    INTO _employee_id
    FROM jsonb_to_record(_src) AS s (employee_id INT);

    INSERT INTO hotel.working AS w (employee_id,
                                    dt_touches)
    SELECT _employee_id,
           _dt_touches;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;