# public



# Таблицы
### Таблица информации об отеле
Данная таблица хранит данные об изменениях в отеле.  

| Название столбца | Тип данных  | Описание                       |
|:----------------:|:-----------:|:-------------------------------|
|   id_settings    | SMALLSERIAL | Индивидуальный номер изменения |
|       name       |   VARCHAR   | Название отеля                 |
|     address      |   VARCHAR   | Адрес отеля                    |
|      floor       |  SMALLINT   | Этажей в отеле                 |
|      rooms       |  SMALLINT   | Гостиничных номеров в отеле    |
|      owner       |   VARCHAR   | Владелец отеля                 |

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