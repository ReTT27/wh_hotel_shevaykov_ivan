CREATE OR REPLACE FUNCTION dictionary.typeroomsupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _type_id      SMALLINT;
    _name         VARCHAR(64);
    _number_beds  VARCHAR(4);
    _number_rooms SMALLINT;
    _cost         NUMERIC(7, 2);
BEGIN

    SELECT COALESCE(tr.type_id, NEXTVAL('dictionary.typeroomssq')) AS type_id,
           s.name,
           s.number_beds,
           s.number_rooms,
           s.cost
    INTO _type_id,
         _name,
         _number_beds,
         _number_rooms,
         _cost
    FROM JSONB_TO_RECORD(_src) AS s(type_id      SMALLINT,
                                    name         VARCHAR(64),
                                    number_beds  VARCHAR(4),
                                    number_rooms SMALLINT,
                                    cost         NUMERIC(7, 2))
             LEFT JOIN dictionary.typerooms tr
                       ON tr.type_id = s.type_id;

    IF (_cost < 0 OR _cost IS NOT NULL)
    THEN
        RETURN public.errmessage(_errcode := 'dictionary.typerooms_ins.cost',
                                 _msg     := 'Стоимость не может быть отрицательной!',
                                 _detail  := CONCAT('cost = ', _cost));
    END IF;

    INSERT INTO dictionary.typerooms AS tr(type_id,
                                           name,
                                           number_beds,
                                           number_rooms,
                                           cost)
    SELECT _type_id,
           _name,
           _number_beds,
           _number_rooms,
           _cost
    ON CONFLICT (type_id) DO UPDATE
        SET cost = EXCLUDED.cost;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;