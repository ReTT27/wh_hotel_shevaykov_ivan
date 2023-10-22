CREATE OR REPLACE FUNCTION customerresources.guestloyaltyupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _card_id   INT;
    _is_actual BOOLEAN;
    _dt_ch     TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT s.card_id,
           s.is_actual
    INTO _card_id,
         _is_actual
    FROM jsonb_to_record(_src) AS s (card_id   INT,
                                     is_actual BOOLEAN);

    UPDATE customerresources.guestloyalty gl
    SET is_actual   = FALSE,
        dt_ch       = _dt_ch,
        ch_employee = _ch_employee
    WHERE gl.card_id = _card_id;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;