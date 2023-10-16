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
                                     review_id      INT);


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
            ON CONFLICT (sale_id) DO UPDATE
                SET employee_id    = excluded.employee_id,
                    visitors       = excluded.visitors,
                    reservation_id = excluded.reservation_id,
                    typefeed_id    = excluded.typefeed_id,
                    review_id      = excluded.review_id,
                    sale           = excluded.sale,
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