CREATE OR REPLACE FUNCTION dictionary.typefeedupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _typefeed_id SMALLINT;
    _name        VARCHAR(32);
    _content     VARCHAR(128);
    _cost        NUMERIC(7, 2);
BEGIN

    SELECT COALESCE(tf.typefeed_id, nextval('dictionary.typefeedsq')) AS typefeed_id,
           s.name,
           s.content,
           s.cost
    INTO _typefeed_id,
         _name,
         _content,
         _cost
    FROM jsonb_to_record(_src) AS s (typefeed_id SMALLINT,
                                     name        VARCHAR(32),
                                     content     VARCHAR(128),
                                     cost        NUMERIC(6, 2))
             LEFT JOIN dictionary.typefeed tf
                       ON tf.typefeed_id = s.typefeed_id;

    IF (_cost < 0 AND _cost IS NOT NULL)
    THEN
        RETURN public.errmessage(_errcode := 'dictionary.typefeed_ins.cost',
                                 _msg     := 'Стоимость не может быть отрицательной!',
                                 _detail  := concat('cost = ', _cost));
    END IF;

    INSERT INTO dictionary.typefeed AS tf (typefeed_id,
                                           name,
                                           content,
                                           cost)
    SELECT _typefeed_id,
           _name,
           _content,
           _cost
    ON CONFLICT (typefeed_id) DO UPDATE
        SET content = excluded.content,
            cost    = excluded.cost;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;