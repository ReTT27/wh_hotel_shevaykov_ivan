CREATE OR REPLACE FUNCTION customerresources.guestloyaltyupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _card_id         INT;
    _cashback_points INT;
    _dt_registration TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
    _dt_use          TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
    _is_actual       BOOLEAN;
    _dt_ch           TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
    _is_deleted      BOOLEAN     := FALSE;
BEGIN

    SELECT COALESCE(gl.card_id, nextval('customerresources.guestloyaltysq')) AS card_id,
           s.cashback_points,
           s.dt_registration,
           s.is_actual,
           s.is_deleted
    INTO _card_id,
         _cashback_points,
         _dt_registration,
         _is_actual,
         _is_deleted
    FROM jsonb_to_record(_src) AS s (card_id         INT,
                                     cashback_points INT,
                                     dt_registration TIMESTAMPTZ,
                                     is_actual       BOOLEAN,
                                     is_deleted      BOOLEAN)
             LEFT JOIN customerresources.guestloyalty gl
                       ON gl.card_id = s.card_id;

    IF _is_deleted = TRUE
    THEN
        DELETE FROM customerresources.guestloyalty gl WHERE gl.card_id = _card_id;
        RETURN JSONB_BUILD_OBJECT('data', NULL);
    END IF;

    WITH ins_cte AS (
        INSERT INTO customerresources.guestloyalty AS gl (card_id,
                                                          cashback_points,
                                                          dt_registration,
                                                          dt_use,
                                                          is_actual,
                                                          dt_ch,
                                                          ch_employee)
            SELECT _card_id,
                   _cashback_points,
                   _dt_registration,
                   _dt_use,
                   _is_actual,
                   _dt_ch,
                   _ch_employee
            ON CONFLICT (card_id) DO UPDATE
                SET cashback_points = excluded.cashback_points,
                    dt_use          = excluded.dt_use,
                    is_actual       = excluded.is_actual,
                    dt_ch           = excluded.dt_ch,
                    ch_employee     = excluded.ch_employee
        RETURNING gl.*)

    INSERT INTO history.guestloyaltychanges AS glc (card_id,
                                                    cashback_points,
                                                    dt_registration,
                                                    dt_use,
                                                    is_actual,
                                                    dt_ch,
                                                    ch_employee)
    SELECT ic.card_id,
           ic.cashback_points,
           ic.dt_registration,
           ic.dt_use,
           ic.is_actual,
           ic.dt_ch,
           ic.ch_employee
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;