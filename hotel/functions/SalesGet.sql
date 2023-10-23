CREATE OR REPLACE FUNCTION hotel.salesget(_sale_id INT, _employee_id INT, _reservation_id INT,  _review_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
    FROM (SELECT s.sale_id,
                 s.employee_id,
                 s.visitors,
                 s.reservation_id,
                 s.typefeed_id,
                 s.review_id,
                 s.sale,
                 s.ch_employee,
                 s.dt_ch
          FROM hotel.sales s
          WHERE s.sale_id        = COALESCE(_sale_id, s.sale_id)
            AND s.employee_id    = COALESCE(_employee_id, s.employee_id)
            AND s.reservation_id = COALESCE(_reservation_id, s.reservation_id)
            AND s.review_id      = COALESCE(_review_id, s.review_id)) res;

END
$$;