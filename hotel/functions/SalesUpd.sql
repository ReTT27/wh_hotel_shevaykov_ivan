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
    _dt_ch          TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT COALESCE(s.sale_id, nextval('hotel.salessq')) AS sale_id,
           s.employee_id,
           s.visitors,
           s.reservation_id,
           s.typefeed_id,
           s.review_id
    INTO _sale_id,
         _employee_id,
         _visitors,
         _reservation_id,
         _typefeed_id,
         _review_id
    FROM jsonb_to_record(_src) AS s (sale_id        INT,
                                     employee_id    INT,
                                     visitors       JSONB,
                                     reservation_id INT,
                                     typefeed_id    SMALLINT,
                                     review_id      INT)
             LEFT JOIN hotel.sales sal
                       ON sal.sale_id = s.sale_id;

    CASE
        WHEN (SELECT 1 FROM hotel.employee e WHERE e.employee_id != _employee_id)
            THEN RETURN public.errmessage(_errcode := 'hotel.sales_ins.employee_not_exist',
                                          _msg     := 'Такого сотрудника не существует!',
                                          _detail  := concat('employee_id = ', _employee_id));
        WHEN (SELECT 1 FROM hotel.reservation r WHERE r.reservation_id != _reservation_id)
            THEN RETURN public.errmessage(_errcode := 'hotel.sales_ins.reservation_not_exist',
                                          _msg     := 'Такой брони не существует!',
                                          _detail  := concat('reservation_id = ', _reservation_id));
        WHEN (SELECT 1 FROM dictionary.typefeed tf WHERE tf.typefeed_id != _typefeed_id)
            THEN RETURN public.errmessage(_errcode := 'hotel.sales_ins.typefeed_not_exist',
                                          _msg     := 'Такого типа еды не существует!',
                                          _detail  := concat('typefeed_id = ', _typefeed_id));
        WHEN ((SELECT 1 FROM hotel.reviews r WHERE r.review_id != _review_id) AND (_review_id IS NOT NULL))
            THEN RETURN public.errmessage(_errcode := 'hotel.sales_ins.review_not_exist',
                                          _msg     := 'Такого отзыва не существует!',
                                          _detail  := concat('review_id = ', _review_id));
        ELSE NULL;
    END CASE;

    WITH ins_cte AS (
        INSERT INTO hotel.sales AS s (sale_id,
                                      employee_id,
                                      visitors,
                                      reservation_id,
                                      typefeed_id,
                                      review_id,
                                      dt_ch,
                                      ch_employee)
            SELECT _sale_id,
                   _employee_id,
                   _visitors,
                   _reservation_id,
                   _typefeed_id,
                   _review_id,
                   _dt_ch,
                   _ch_employee
            ON CONFLICT (sale_id) DO UPDATE
                SET employee_id    = excluded.employee_id,
                    visitors       = excluded.visitors,
                    reservation_id = excluded.reservation_id,
                    typefeed_id    = excluded.typefeed_id,
                    review_id      = excluded.review_id,
                    dt_ch          = excluded.dt_ch,
                    ch_employee    = excluded.ch_employee
        RETURNING s.*)

    INSERT INTO history.saleschanges AS rc (sale_id,
                                            employee_id,
                                            visitors,
                                            reservation_id,
                                            typefeed_id,
                                            review_id,
                                            dt_ch,
                                            ch_employee)
    SELECT ic.sale_id,
           ic.employee_id,
           ic.visitors,
           ic.reservation_id,
           ic.typefeed_id,
           ic.review_id,
           ic.dt_ch,
           ic.ch_employee
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;