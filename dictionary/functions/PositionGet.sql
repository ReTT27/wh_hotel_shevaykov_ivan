CREATE OR REPLACE FUNCTION dictionary.positionget(_position_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT p.position_id,
                 p.name,
                 p.salary
          FROM dictionary.position p
          WHERE p.position_id = COALESCE(_position_id, p.position_id)) res;

END
$$;