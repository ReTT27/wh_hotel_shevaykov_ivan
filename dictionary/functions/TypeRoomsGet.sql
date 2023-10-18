CREATE OR REPLACE FUNCTION dictionary.typeroomsget() RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT tr.name,
                 tr.number_beds,
                 tr.number_rooms,
                 tr.cost
          FROM dictionary.typerooms tr) res;

END
$$;