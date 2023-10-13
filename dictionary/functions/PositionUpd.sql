CREATE OR REPLACE FUNCTION dictionary.positionupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _position_id SMALLINT;
    _name        VARCHAR(64);
    _salary      NUMERIC(8, 2);
BEGIN

    SELECT COALESCE(p.position_id, nextval('dictionary.positionsq')) AS position_id,
           s.name,
           s.salary
    INTO _position_id,
         _name,
         _salary
    FROM jsonb_to_record(_src) AS s (position_id SMALLINT,
                                     name        VARCHAR(64),
                                     salary      NUMERIC(8, 2))
             LEFT JOIN dictionary.position p
                       ON p.position_id = s.position_id;

    IF (_salary < 0 AND _salary IS NOT NULL)
    THEN
        RETURN public.errmessage(_errcode := 'dictionary.position_ins.salary',
                                 _msg     := 'Зарплата не может быть отрицательной!',
                                 _detail  := concat('salary = ', _salary));
    END IF;

    INSERT INTO dictionary.position AS p (position_id,
                                          name,
                                          salary)
    SELECT _position_id,
           _name,
           _salary
    ON CONFLICT (position_id) DO UPDATE
        SET salary = excluded.salary;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;