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