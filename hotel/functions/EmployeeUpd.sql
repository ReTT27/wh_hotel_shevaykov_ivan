CREATE OR REPLACE FUNCTION hotel.employeeupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _employee_id INT;
    _name        VARCHAR(64);
    _phone       VARCHAR(11);
    _email       VARCHAR(32);
    _position_id SMALLINT;
    _reward      NUMERIC(7, 2);
    _is_deleted  BOOLEAN;
    _dt_ch       TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT COALESCE(e.employee_id, nextval('hotel.employeesq')) AS employee_id,
           s.name,
           s.phone,
           s.email,
           s.position_id,
           s.reward,
           s.is_deleted
    INTO _employee_id,
         _name,
         _phone,
         _email,
         _position_id,
         _reward,
         _is_deleted
    FROM jsonb_to_record(_src) AS s (employee_id INT,
                                     name        VARCHAR(64),
                                     phone       VARCHAR(11),
                                     email       VARCHAR(32),
                                     position_id SMALLINT,
                                     reward      NUMERIC(7, 2),
                                     is_deleted  BOOLEAN)
             LEFT JOIN hotel.employee e
                       ON e.employee_id = s.employee_id;

    WITH ins_cte AS (
        INSERT INTO hotel.employee AS e (employee_id,
                                         name,
                                         phone,
                                         email,
                                         position_id,
                                         reward,
                                         is_deleted,
                                         dt_ch,
                                         ch_employee)
            SELECT _employee_id,
                   _name,
                   _phone,
                   _email,
                   _position_id,
                   _reward,
                   _is_deleted,
                   _dt_ch,
                   _ch_employee
            ON CONFLICT (employee_id) DO UPDATE
                SET name        = excluded.name,
                    phone       = excluded.phone,
                    email       = excluded.email,
                    position_id = excluded.position_id,
                    reward      = excluded.reward,
                    is_deleted  = excluded.is_deleted,
                    dt_ch       = excluded.dt_ch,
                    ch_employee = excluded.ch_employee
        RETURNING e.*)
        , ins_his AS (INSERT INTO history.employeechanges AS ec (employee_id,
                                                                 name,
                                                                 phone,
                                                                 email,
                                                                 position_id,
                                                                 reward,
                                                                 is_deleted,
                                                                 dt_ch,
                                                                 ch_employee)
                            SELECT ic.employee_id,
                                   ic.name,
                                   ic.phone,
                                   ic.email,
                                   ic.position_id,
                                   ic.reward,
                                   ic.is_deleted,
                                   ic.dt_ch,
                                   ic.ch_employee
                            FROM ins_cte ic)

    INSERT INTO whsync.employeesync AS es (employee_id,
                                           name,
                                           phone,
                                           email,
                                           position_id,
                                           reward,
                                           is_deleted,
                                           dt_ch,
                                           ch_employee)
    SELECT ic.employee_id,
           ic.name,
           ic.phone,
           ic.email,
           ic.position_id,
           ic.reward,
           ic.is_deleted,
           ic.dt_ch,
           ic.ch_employee
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;