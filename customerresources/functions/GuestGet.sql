CREATE OR REPLACE FUNCTION customerresources.guestget(_guest_id INT, _phone VARCHAR, _card_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
    FROM (SELECT g.guest_id,
                 g.name,
                 g.phone,
                 g.email,
                 g.birth_day,
                 g.card_id,
                 g.ch_employee,
                 g.dt_ch
          FROM customerresources.guest g
          WHERE g.guest_id = COALESCE(_guest_id, g.guest_id)
            AND g.phone    = COALESCE(_phone, g.phone)
            AND g.card_id  = COALESCE(_card_id, g.card_id)) res;

END
$$;