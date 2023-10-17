CREATE OR REPLACE FUNCTION dictionary.storageupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _name TEXT;
    _dt   DATE := now()::DATE AT TIME ZONE 'Europe/Moscow';
BEGIN



    EXECUTE format('DROP TABLE history.%I', _name);



    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;