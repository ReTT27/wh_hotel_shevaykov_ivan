CREATE OR REPLACE FUNCTION hotel.cleaningthingget(_set_id INT, _cleaning_id INT, _thing_id SMALLINT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT ct.set_id,
                 ct.cleaning_id,
                 ct.thing_id,
                 ct.thing_count,
                 ct.ch_employee,
                 ct.dt_ch
          FROM hotel.cleaningthing ct
          WHERE ct.set_id      = COALESCE(_set_id, ct.set_id)
            AND ct.cleaning_id = COALESCE(_cleaning_id, ct.cleaning_id)
            AND ct.thing_id    = COALESCE(_thing_id, ct.thing_id)) res;

END
$$;