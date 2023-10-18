CREATE OR REPLACE FUNCTION customerresources.guestloyaltyget(_card_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT gl.card_id,
                 gl.cashback_points,
                 gl.dt_registration,
                 gl.dt_use,
                 gl.is_actual,
                 gl.ch_employee,
                 gl.dt_ch
          FROM customerresources.guestloyalty gl
          WHERE gl.card_id  = COALESCE(_card_id, gl.card_id)) res;

END
$$;