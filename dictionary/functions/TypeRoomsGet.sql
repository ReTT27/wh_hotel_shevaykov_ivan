CREATE OR REPLACE FUNCTION dictionary.typeroomsget(_type_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT tr.type_id,
                 tr.name,
                 tr.number_beds,
                 tr.number_rooms,
                 tr.cost
          FROM dictionary.typerooms tr
          WHERE tr.type_id = COALESCE(_type_id, tr.type_id)) res;

END
$$;