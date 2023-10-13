CREATE OR REPLACE FUNCTION dictionary.storageupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _thing_id SMALLINT;
    _name     VARCHAR(32);
    _count    SMALLINT;
BEGIN

    SELECT COALESCE(st.thing_id, nextval('dictionary.positionsq')) AS thing_id,
           s.name,
           s.count
    INTO _thing_id,
         _name,
         _count
    FROM jsonb_to_record(_src) AS s (thing_id SMALLINT,
                                     name     VARCHAR(32),
                                     count    SMALLINT)
             LEFT JOIN dictionary.storage st
                       ON st.thing_id = _thing_id;

    IF (_count < 0 AND _count IS NOT NULL)
    THEN
        RETURN public.errmessage(_errcode := 'dictionary.storage_ins.count',
                                 _msg     := 'Колчество не может быть отрицательным!',
                                 _detail  := concat('count = ', _count));
    END IF;

    INSERT INTO dictionary.storage AS st (thing_id,
                                          name,
                                          count)
    SELECT _thing_id,
           _name,
           _count
    ON CONFLICT (thing_id) DO UPDATE
        SET name   = excluded.name,
            count  = excluded.count;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;