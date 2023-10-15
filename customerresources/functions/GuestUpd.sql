CREATE OR REPLACE FUNCTION customerresources.guestupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _guest_id        INT;
    _name            VARCHAR(64);
    _phone           VARCHAR(11);
    _email           VARCHAR(32);
    _birth_day       DATE;
    _card_id         INT;
    _cashback_points INT         := 0;
    _dt_ch           TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT COALESCE(s.guest_id, nextval('customerresources.guestsq')) AS guest_id,
           s.name,
           s.phone,
           s.email,
           s.birth_day,
           COALESCE(s.card_id, nextval('customerresources.guestloyaltysq')) AS card_id
    INTO _guest_id,
         _name,
         _phone,
         _email,
         _birth_day,
         _card_id
    FROM jsonb_to_record(_src) AS s (guest_id  INT,
                                     name      VARCHAR(64),
                                     phone     VARCHAR(11),
                                     email     VARCHAR(32),
                                     birth_day DATE,
                                     card_id   INT);

    CASE
        WHEN (SELECT 1 FROM customerresources.guest g WHERE g.phone = _phone AND g.guest_id = _guest_id)
            THEN RETURN public.errmessage(_errcode := 'customerresources.guest_ins.phone_exists',
                                          _msg     := 'Такой номер телефона уже принадлежит этому пользователю!',
                                          _detail  := concat('phone = ', _phone));
        WHEN (SELECT 1 FROM customerresources.guest g WHERE g.phone = _phone)
            THEN RETURN public.errmessage(_errcode := 'customerresources.guest_ins.phone_exists',
                                          _msg     := 'Такой номер телефона уже принадлежит другому пользователю!',
                                          _detail  := concat('phone = ', _phone));
        WHEN (SELECT 1 FROM customerresources.guestloyalty gl WHERE gl.card_id = _card_id)
            THEN RETURN public.errmessage(_errcode := 'customerresources.guest_ins.card_not_exists',
                                          _msg     := 'Такая карта лояльности существует!',
                                          _detail  := concat('card_id = ', _card_id));
        ELSE NULL;
    END CASE;

    INSERT INTO customerresources.guestloyalty AS gl (card_id,
                                                      cashback_points,
                                                      dt_registration,
                                                      dt_use,
                                                      dt_ch,
                                                      ch_employee)
    SELECT _card_id,
           _cashback_points,
           _dt_ch,
           _dt_ch,
           _dt_ch,
           _ch_employee
    ON CONFLICT (card_id) DO NOTHING;

    WITH ins_cte AS (
        INSERT INTO customerresources.guest AS g (guest_id,
                                                  name,
                                                  phone,
                                                  email,
                                                  birth_day,
                                                  card_id,
                                                  dt_ch,
                                                  ch_employee)
            SELECT _guest_id,
                   _name,
                   _phone,
                   _email,
                   _birth_day,
                   _card_id,
                   _dt_ch,
                   _ch_employee
            ON CONFLICT (guest_id) DO UPDATE
                SET name        = excluded.name,
                    phone       = excluded.phone,
                    email       = excluded.email,
                    birth_day   = excluded.birth_day,
                    card_id     = excluded.card_id,
                    dt_ch       = excluded.dt_ch,
                    ch_employee = excluded.ch_employee
            RETURNING g.*)


    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;