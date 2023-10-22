CREATE OR REPLACE FUNCTION whsync.employeessyncimport(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN

    WITH ins_cte AS (SELECT s.employee_id,
                            s.name,
                            s.phone,
                            s.email,
                            s.position_id,
                            s.reward,
                            s.is_deleted,
                            s.ch_employee,
                            s.dt_ch,
                            row_number() OVER (PARTITION BY s.ch_employee ORDER BY s.dt_ch DESC) rn
                     FROM jsonb_to_recordset(_src) AS s(employee_id INT,
                                                        name        VARCHAR(64),
                                                        phone       VARCHAR(11),
                                                        email       VARCHAR(32),
                                                        position_id SMALLINT,
                                                        reward      NUMERIC(8, 2),
                                                        is_deleted  BOOLEAN,
                                                        ch_employee INT,
                                                        dt_ch       TIMESTAMPTZ))
       , inc_t AS (INSERT INTO hotel.employee AS e (employee_id,
                                                    name,
                                                    phone,
                                                    email,
                                                    position_id,
                                                    reward,
                                                    is_deleted,
                                                    ch_employee,
                                                    dt_ch)
                   SELECT ic.employee_id,
                          ic.name,
                          ic.phone,
                          ic.email,
                          ic.position_id,
                          ic.reward,
                          ic.is_deleted,
                          ic.ch_employee,
                          ic.dt_ch
                   FROM ins_cte ic
                   WHERE ic.rn = 1
                   ON CONFLICT (employee_id) DO UPDATE
                        SET name        = excluded.name,
                            phone       = excluded.phone,
                            email       = excluded.email,
                            position_id = excluded.position_id,
                            reward      = excluded.reward,
                            is_deleted  = excluded.is_deleted,
                            dt_ch       = excluded.dt_ch,
                            ch_employee = excluded.ch_employee
                   WHERE e.dt_ch <= excluded.dt_ch
                   RETURNING e.*)

    INSERT INTO history.employeechanges AS ec (employee_id,
                                               name,
                                               phone,
                                               email,
                                               position_id,
                                               reward,
                                               is_deleted,
                                               ch_employee,
                                               dt_ch)
    SELECT it.employee_id,
           it.name,
           it.phone,
           it.email,
           it.position_id,
           it.reward,
           it.is_deleted,
           it.ch_employee,
           it.dt_ch
    FROM inc_t it;

    RETURN JSONB_BUILD_OBJECT('data',NULL);
END
$$;