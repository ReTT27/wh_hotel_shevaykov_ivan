CREATE OR REPLACE FUNCTION whsync.employeessyncimport(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN

    INSERT INTO hotel.employee AS e (employee_id,
                                     name,
                                     phone,
                                     email,
                                     position_id,
                                     reward,
                                     is_deleted,
                                     ch_employee,
                                     dt_ch)
    SELECT s.employee_id,
           s.name,
           s.phone,
           s.email,
           s.position_id,
           s.reward,
           s.is_deleted,
           s.ch_employee,
           s.dt_ch
    FROM jsonb_to_recordset(_src) AS s (employee_id INT,
                                        name        VARCHAR(64),
                                        phone       VARCHAR(11),
                                        email       VARCHAR(32),
                                        position_id SMALLINT,
                                        reward      NUMERIC(8, 2),
                                        is_deleted  BOOLEAN,
                                        ch_employee INT,
                                        dt_ch       TIMESTAMPTZ)
    ON CONFLICT (employee_id) DO UPDATE
        SET name        = excluded.name,
            phone       = excluded.phone,
            email       = excluded.email,
            position_id = excluded.position_id,
            reward      = excluded.reward,
            is_deleted  = excluded.is_deleted,
            dt_ch       = excluded.dt_ch,
            ch_employee = excluded.ch_employee
    WHERE e.dt_ch < excluded.dt_ch;

    RETURN JSONB_BUILD_OBJECT('data',NULL);
END
$$;