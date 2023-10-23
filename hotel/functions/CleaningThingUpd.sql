CREATE OR REPLACE FUNCTION hotel.cleaningthingupd(_src JSONB, _ch_employee INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _cleaning_id INT;
    _thing_id    SMALLINT;
    _thing_count SMALLINT;
    _dt_ch       TIMESTAMPTZ := NOW() AT TIME ZONE 'Europe/Moscow';
BEGIN

    SELECT s.cleaning_id,
           s.thing_id,
           s.thing_count
    INTO _cleaning_id,
         _thing_id,
         _thing_count
    FROM JSONB_TO_RECORD(_src) AS s(cleaning_id INT,
                                    thing_id    INT,
                                    thing_count SMALLINT);
    WITH ins_cte AS (
        INSERT INTO hotel.cleaningthing AS c(cleaning_id,
                                             thing_id,
                                             thing_count,
                                             dt_ch,
                                             ch_employee)
            SELECT _cleaning_id,
                   _thing_id,
                   _thing_count,
                   _dt_ch,
                   _ch_employee
            RETURNING c.*)

    UPDATE dictionary.storage st
    SET count = (count - ic.thing_count)
    FROM ins_cte ic
    WHERE st.thing_id = ic.thing_id;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;