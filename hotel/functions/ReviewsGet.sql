CREATE OR REPLACE FUNCTION hotel.reviewsget(_review_id INT, _category SMALLINT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT r.review_id,
                 r.date_review,
                 r.category,
                 r.content
          FROM hotel.reviews r
          WHERE r.review_id = COALESCE(_review_id, r.review_id)
            AND r.category  = COALESCE(_category, r.category)) res;

END
$$;