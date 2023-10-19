CREATE OR REPLACE FUNCTION dictionary.storageget(_thing_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT s.thing_id,
                 s.name,
                 s.count
          FROM dictionary.storage s
          WHERE s.thing_id = COALESCE(_thing_id, s.thing_id)) res;

END
$$;