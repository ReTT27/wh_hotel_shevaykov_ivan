CREATE OR REPLACE FUNCTION history.deletepartitionscleaning() RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _name VARCHAR(64)[];
BEGIN

    SELECT array_agg(c.relname)
    INTO _name
    FROM pg_class c
    WHERE extract(month from split_part(pg_get_expr(c.relpartbound, c.oid, true), 'TO', 2)::DATE) <
          extract(month from now() - interval '3 month')
      AND extract(years from split_part(pg_get_expr(c.relpartbound, c.oid, true), 'TO', 2)::DATE) =
          extract(years from now());

    FOR i IN 1..array_length(_name, 1)
        LOOP
             EXECUTE format('DROP TABLE history.%I', _name[i]);
        END LOOP;

    RETURN JSONB_BUILD_OBJECT('data', null);

END
$$;