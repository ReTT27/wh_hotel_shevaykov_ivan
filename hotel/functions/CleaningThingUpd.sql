CREATE OR REPLACE FUNCTION hotel.cleaningthingupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _cleaning_id INT;
    _thing_id    SMALLINT;
    _thing_count SMALLINT;
    _dt_ch       TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT s.cleaning_id,
           s.thing_id,
           s.thing_count
    INTO _cleaning_id,
         _thing_id,
         _thing_count
    FROM jsonb_to_record(_src) AS s (cleaning_id INT,
                                     thing_id    INT,
                                     thing_count SMALLINT);

    CASE
        WHEN (SELECT 1 FROM hotel.cleaning c WHERE c.cleaning_id != _cleaning_id)
            THEN RETURN public.errmessage(_errcode := 'hotel.cleaningthing_ins.cleaning_not_exist',
                                          _msg     := 'Нет такой уборки!',
                                          _detail  := concat('cleaning_id = ', _cleaning_id));
        WHEN (SELECT 1 FROM dictionary.storage s WHERE s.thing_id != _thing_id)
            THEN RETURN public.errmessage(_errcode := 'hotel.cleaning_ins.room_not_exist',
                                          _msg     := 'Нет такой вещи!',
                                          _detail  := concat('thing_id = ', _thing_id));
        ELSE NULL;
    END CASE;


    INSERT INTO hotel.cleaningthing AS c (cleaning_id,
                                          thing_id,
                                          thing_count,
                                          dt_ch,
                                          ch_employee)
    SELECT _cleaning_id,
           _thing_id,
           _thing_count,
           _dt_ch,
           _ch_employee;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;