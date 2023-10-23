CREATE OR REPLACE FUNCTION dictionary.typefeedget(_typefeed_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
    FROM (SELECT tf.typefeed_id,
                 tf.name,
                 tf.content,
                 tf.cost
          FROM dictionary.typefeed tf
          WHERE tf.typefeed_id = COALESCE(_typefeed_id, tf.typefeed_id)) res;

END
$$;