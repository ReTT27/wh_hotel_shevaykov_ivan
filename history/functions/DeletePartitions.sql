CREATE OR REPLACE FUNCTION history.deletepartitions(_name_inh TEXT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _name_part VARCHAR(64)[];
BEGIN

    SELECT ARRAY_AGG(c.relname)
    INTO _name_part
    FROM pg_catalog.pg_inherits i
             INNER JOIN pg_catalog.pg_class c ON c.oid = i.inhrelid
    WHERE DATE_TRUNC('month', SPLIT_PART(PG_GET_EXPR(c.relpartbound, c.oid, TRUE), 'TO', 2)::DATE) <=
          DATE_TRUNC('month', NOW() - INTERVAL '3 month')::DATE
      AND i.inhparent::REGCLASS::TEXT = CONCAT('history.',_name_inh);

    IF (ARRAY_LENGTH(_name_part, 1) IS NULL)
    THEN
        RETURN public.errmessage(_errcode := 'history.partitions_del',
                                 _msg     := 'Таблиц для удаления нет!',
                                 _detail  := 'Длина массива = 0');
    END IF;

    FOR i IN 1..ARRAY_LENGTH(_name_part, 1)
        LOOP
             EXECUTE FORMAT('DROP TABLE history.%I', _name_part[i]);
        END LOOP;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;