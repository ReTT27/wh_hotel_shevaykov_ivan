CREATE OR REPLACE FUNCTION dictionary.storageupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _thing_id SMALLINT;
    _name    VARCHAR(64);
    _salary  NUMERIC(7, 2);
BEGIN

    SELECT COALESCE(p.post_id, nextval('dictionary.positionsq')) AS post_id,
           s.name,
           s.salary
    INTO _post_id,
         _name,
         _salary
    FROM jsonb_to_record(_src) AS s (post_id SMALLINT,
                                     name    VARCHAR(64),
                                     salary  NUMERIC(7, 2))
             LEFT JOIN dictionary.position p
                       ON p.post_id = _post_id;

    IF (_salary < 0 AND _salary IS NOT NULL )
    THEN
        RETURN public.errmessage(_errcode := 'dictionary.position_ins.salary',
                                 _msg     := 'Зарплата не может быть отрицательной!',
                                 _detail  := concat('salary = ', _salary));
    END IF;

    INSERT INTO dictionary.position AS p (post_id,
                                          name,
                                          salary)
    SELECT _post_id,
           _name,
           _salary
    ON CONFLICT (post_id) DO UPDATE
        SET name   = excluded.name,
            salary = excluded.salary;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;