# dictionary



# Таблицы
### Таблица должностей
Данная таблица хранит данные о должностях в отеле: название должности, зарплата.
```sql
CREATE TABLE IF NOT EXISTS dictionary.post
(
    post_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_post PRIMARY KEY,
    name    VARCHAR(64) NOT NULL,
    salary  INT         NOT NULL
);
```

### Таблица типов питания
Данная таблица хранит данные о типах питания в отеле: название типа питания, стоимость услуги в сутки.
```sql
CREATE TABLE IF NOT EXISTS dictianory.typefeed
(
    typefeed_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_typefeed PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    cost        SMALLINT    NOT NULL
);
```

### Таблица типов номеров
Данная таблица хранит данные о типах номеров в отеле: название типа номера, количество спальных мест, количество комнат, стоимость номера за сутки.
```sql
CREATE TABLE IF NOT EXISTS dictionary.typerooms
(
    type_id      SMALLSERIAL NOT NULL
        CONSTRAINT pk_typerooms PRIMARY KEY,
    name         VARCHAR(64) NOT NULL,
    number_beds  VARCHAR(4)  NOT NULL,
    number_rooms SMALLINT    NOT NULL,
    cost         INT         NOT NULL
);
```