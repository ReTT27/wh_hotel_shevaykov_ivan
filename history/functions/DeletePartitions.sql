CREATE OR REPLACE FUNCTION history.deletepartitions(_name_inh TEXT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _name_part VARCHAR(64)[];
BEGIN

    SELECT array_agg(c.relname)
    INTO _name_part
    FROM pg_catalog.pg_inherits i
             INNER JOIN pg_catalog.pg_class c on c.oid = i.inhrelid
    WHERE date_trunc('month', split_part(pg_get_expr(c.relpartbound, c.oid, true), 'TO', 2)::DATE) <=
          date_trunc('month', now() - interval '3 month')::DATE
      AND i.inhparent::regclass::TEXT = concat('history.',_name_inh);

    FOR i IN 1..array_length(_name_part, 1)
        LOOP
             EXECUTE format('DROP TABLE history.%I', _name_part[i]);
        END LOOP;

    RETURN JSONB_BUILD_OBJECT('data', null);

END
$$;