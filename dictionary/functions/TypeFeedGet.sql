CREATE OR REPLACE FUNCTION dictionary.typefeedget() RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN

    RETURN JSONB_BUILD_OBJECT('data', jsonb_agg(row_to_json(res)))
    FROM (SELECT tf.typefeed_id,
                 tf.name,
                 tf.content,
                 tf.cost
          FROM dictionary.typefeed tf) res;

END
$$;