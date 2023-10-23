CREATE OR REPLACE FUNCTION dictionary.positionget(_position_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
    FROM (SELECT p.position_id,
                 p.name,
                 p.salary
          FROM dictionary.position p
          WHERE p.position_id = COALESCE(_position_id, p.position_id)) res;

END
$$;