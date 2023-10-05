# public



# Функции
### Функция вывода ошибки
Функция ошибки используется для вывода неккоректных данных в различных ситуациях.
```sql
CREATE OR REPLACE FUNCTION public.errmessage(_errcode VARCHAR, _msg VARCHAR, _detail VARCHAR) RETURNS JSONB
    LANGUAGE plpgsql
AS
$$
DECLARE
    _errors JSONB;
BEGIN
    SELECT JSONB_AGG(ROW_TO_JSON(s))
    FROM (
        SELECT _errcode error,
               _msg     message,
               _detail  detail) s
    INTO _errors;

    RETURN JSONB_OBJECT_AGG('errors', _errors)::JSONB;
END;
$$;
```

# Таблицы
### Таблица информации об отеле
Данная таблица хранит данные об изменениях в отеле: название отеля, адрес отеля, владелец отеля.
```sql
CREATE TABLE IF NOT EXISTS public.hotelinfo
(
    id_settings SMALLSERIAL  NOT NULL
        CONSTRAINT pk_hotelinfo PRIMARY KEY,
    name        VARCHAR(64)  NOT NULL,
    address     VARCHAR(128) NOT NULL,
    owner       VARCHAR(64)  NOT NULL
);
```