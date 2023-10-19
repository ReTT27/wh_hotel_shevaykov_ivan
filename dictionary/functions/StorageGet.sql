CREATE OR REPLACE FUNCTION dictionary.storageget() RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT s.thing_id,
                 s.name,
                 s.count
          FROM dictionary.storage s) res;

END
$$;