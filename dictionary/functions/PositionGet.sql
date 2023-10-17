CREATE OR REPLACE FUNCTION dictionary.positionget() RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT p.name,
                 p.salary
          FROM dictionary.position p) res;

END
$$;