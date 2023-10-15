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
    _is_del      BOOLEAN     := FALSE;
BEGIN

    SELECT COALESCE(s.employee_id, nextval('hotel.employeesq')) AS employee_id,
           s.name,
           s.phone,
           s.email,
           s.position_id,
           s.reward,
           s.is_deleted,
           s.is_del
    INTO _employee_id,
         _name,
         _phone,
         _email,
         _position_id,
         _reward,
         _is_deleted,
         _is_del
    FROM jsonb_to_record(_src) AS s (employee_id INT,
                                     name        VARCHAR(64),
                                     phone       VARCHAR(11),
                                     email       VARCHAR(32),
                                     position_id SMALLINT,
                                     reward      NUMERIC(7, 2),
                                     is_deleted  BOOLEAN,
                                     is_del      BOOLEAN);

    IF _is_del = TRUE
    THEN
        DELETE FROM hotel.employee e WHERE e.employee_id = _employee_id;
        RETURN JSONB_BUILD_OBJECT('data', NULL);
    END IF;

    CASE
        WHEN (SELECT 1 FROM hotel.employee e WHERE e.phone = _phone AND e.employee_id = _employee_id)
            THEN RETURN public.errmessage(_errcode := 'customerresources.employee_ins.phone_exists',
                                          _msg     := 'Такой номер телефона уже принадлежит этому пользователю!',
                                          _detail  := concat('phone = ', _phone));
        WHEN (SELECT 1 FROM hotel.employee e WHERE e.phone = _phone)
            THEN RETURN public.errmessage(_errcode := 'customerresources.employee_ins.phone_exists',
                                          _msg     := 'Такой номер телефона уже принадлежит другому пользователю!',
                                          _detail  := concat('phone = ', _phone));
        ELSE NULL;
    END CASE;

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

    INSERT INTO history.employeechanges AS ec (employee_id,
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