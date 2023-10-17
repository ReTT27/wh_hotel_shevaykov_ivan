CREATE OR REPLACE FUNCTION hotel.salesupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _sale_id        INT;
    _employee_id    INT;
    _visitors       JSONB;
    _reservation_id INT;
    _typefeed_id    SMALLINT;
    _review_id      INT;
    _sale           NUMERIC(9, 2);
    _count_visitors SMALLINT;
    _day            SMALLINT;
    _card_id        INT;
    _cash_c         SMALLINT;
    _cash           SMALLINT;
    _dt_ch          TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT COALESCE(sal.sale_id, nextval('hotel.salessq')) AS sale_id,
           s.employee_id,
           s.visitors,
           s.reservation_id,
           s.typefeed_id,
           s.review_id,
           s.cash
    INTO _sale_id,
         _employee_id,
         _visitors,
         _reservation_id,
         _typefeed_id,
         _review_id,
         _cash
    FROM jsonb_to_record(_src) AS s (sale_id        INT,
                                     employee_id    INT,
                                     visitors       JSONB,
                                     reservation_id INT,
                                     typefeed_id    SMALLINT,
                                     review_id      INT,
                                     cash           SMALLINT)
             LEFT JOIN hotel.sales sal
                 ON s.sale_id = sal.sale_id;

    SELECT jsonb_array_length(_visitors)
    INTO _count_visitors;

    SELECT r.dt_exit::DATE - r.dt_entry::DATE
    INTO _day
    FROM hotel.reservation r
    WHERE r.reservation_id = _reservation_id;

    SELECT (tf.cost * (_count_visitors + 1) * _day) + (tr.cost * _day)
    INTO _sale
    FROM dictionary.typefeed tf,
         hotel.reservation res
             INNER JOIN hotel.rooms r on r.room_id = res.room_id
             INNER JOIN dictionary.typerooms tr on r.type_id = tr.type_id
    WHERE tf.typefeed_id = _typefeed_id
      AND res.reservation_id = _reservation_id;

    SELECT gly.card_id,
           gly.cashback_points
    INTO _card_id,
         _cash_c
    FROM hotel.reservation res
             INNER JOIN customerresources.guest g ON g.guest_id = res.guest_id
             INNER JOIN customerresources.guestloyalty gly ON gly.card_id = g.card_id
    WHERE res.reservation_id = _reservation_id;

    CASE
        WHEN (_cash > _cash_c OR _cash > _sale)
            THEN SELECT public.errmessage(_errcode := 'hotel.sales_ins.cash',
                                          _msg     := 'Кешбэк введен не верно!',
                                          _detail  := concat('cash = ', _cash));

        WHEN (_cash = 0)
            THEN UPDATE customerresources.guestloyalty gl
                 SET cashback_points = gl.cashback_points + _sale * (SELECT hi.loyalty_percent
                                                                     FROM public.hotelinfo hi
                                                                     ORDER BY hi.id_settings DESC
                                                                     LIMIT 1)
                 WHERE gl.card_id = _card_id;

        ELSE
            UPDATE customerresources.guestloyalty gl SET cashback_points = gl.cashback_points - _cash
            WHERE gl.card_id = _card_id;

            SELECT _sale - _cash
            INTO _sale;
    END CASE;

    WITH ins_cte AS (
        INSERT INTO hotel.sales AS s (sale_id,
                                      employee_id,
                                      visitors,
                                      reservation_id,
                                      typefeed_id,
                                      review_id,
                                      sale,
                                      dt_ch,
                                      ch_employee)
            SELECT _sale_id,
                   _employee_id,
                   _visitors,
                   _reservation_id,
                   _typefeed_id,
                   _review_id,
                   _sale,
                   _dt_ch,
                   _ch_employee
        RETURNING s.*)

    INSERT INTO history.saleschanges AS sc (sale_id,
                                            employee_id,
                                            visitors,
                                            reservation_id,
                                            typefeed_id,
                                            review_id,
                                            sale,
                                            dt_ch,
                                            ch_employee)
    SELECT ic.sale_id,
           ic.employee_id,
           ic.visitors,
           ic.reservation_id,
           ic.typefeed_id,
           ic.review_id,
           ic.sale,
           ic.dt_ch,
           ic.ch_employee
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;