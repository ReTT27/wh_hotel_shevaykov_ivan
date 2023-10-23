CREATE OR REPLACE FUNCTION hotel.reviewsget(_review_id INT, _category INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
    FROM (SELECT r.review_id,
                 r.date_review,
                 r.category,
                 r.content
          FROM hotel.reviews r
          WHERE r.review_id = COALESCE(_review_id, r.review_id)
            AND r.category  = COALESCE(_category, r.category)) res;

END
$$;