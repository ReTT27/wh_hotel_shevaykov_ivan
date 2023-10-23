CREATE OR REPLACE FUNCTION hotel.reviewsupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _review_id   INT;
    _date_review DATE := NOW()::DATE AT TIME ZONE 'Europe/Moscow';
    _category    SMALLINT;
    _content     VARCHAR(500);
    _sale_id     INT;
BEGIN

    SELECT COALESCE(r.review_id, NEXTVAL('hotel.reviewssq')) AS review_id,
           s.category,
           s.content,
           s.sale_id
    INTO _review_id,
         _category,
         _content,
         _sale_id
    FROM JSONB_TO_RECORD(_src) AS s(review_id INT,
                                    category  SMALLINT,
                                    content   VARCHAR(500),
                                    sale_id   INT)
             LEFT JOIN hotel.reviews r
                       ON s.review_id = r.review_id;


    INSERT INTO hotel.reviews AS r(review_id,
                                   date_review,
                                   category,
                                   content)
    SELECT _review_id,
           _date_review,
           _category,
           _content;

    WITH ins_cte AS (
        UPDATE hotel.sales s SET review_id = _review_id
            WHERE s.sale_id = _sale_id
            RETURNING s.*)

    INSERT INTO history.saleschanges AS sc(sale_id,
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