CREATE OR REPLACE FUNCTION hotel.reviewsupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _date_review DATE := now()::DATE AT TIME ZONE 'Europe/Moscow';
    _category    SMALLINT;
    _content     VARCHAR(500);
BEGIN

    SELECT s.category,
           s.content
    INTO _category,
         _content
    FROM jsonb_to_record(_src) AS s (category SMALLINT,
                                     content  VARCHAR(500));


    INSERT INTO hotel.reviews AS c (date_review,
                                    category,
                                    content)
    SELECT _date_review,
           _category,
           _content;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;