# dictionary



# Таблицы
### Таблица должностей
Данная таблица хранит данные о должностях в отеле: название должности, зарплата.
```sql
CREATE TABLE IF NOT EXISTS dictionary.post
(
    post_id     SMALLSERIAL   NOT NULL
        CONSTRAINT pk_post PRIMARY KEY,
    name        VARCHAR(64)   NOT NULL,
    timeline_id SMALLINT      NOT NULL,
    salary      NUMERIC(7, 2) NOT NULL
);
```

### Таблица типов питания
Данная таблица хранит данные о типах питания в отеле: название типа питания, стоимость услуги в сутки.
```sql
CREATE TABLE IF NOT EXISTS dictianory.typefeed
(
    typefeed_id SMALLSERIAL   NOT NULL
        CONSTRAINT pk_typefeed PRIMARY KEY,
    name        VARCHAR(32)   NOT NULL,
    cost        NUMERIC(6, 2) NOT NULL
);
```

### Таблица типов номеров
Данная таблица хранит данные о типах номеров в отеле: название типа номера, количество спальных мест, количество комнат, стоимость номера за сутки.
```sql
CREATE TABLE IF NOT EXISTS dictionary.typerooms
(
    type_id      SMALLSERIAL   NOT NULL
        CONSTRAINT pk_typerooms PRIMARY KEY,
    name         VARCHAR(64)   NOT NULL,
    number_beds  VARCHAR(4)    NOT NULL,
    number_rooms SMALLINT      NOT NULL,
    cost         NUMERIC(7, 2) NOT NULL
);
```

### Таблица типов оплаты
Данная таблица хранит данные о типах оплаты гостей: название вида оплаты
```sql
CREATE TABLE IF NOT EXISTS dictionary.typepayment
(
    payment_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_typepayment PRIMARY KEY,
    name       VARCHAR(32) NOT NULL
);
```

### Таблица графиков работы
Данная таблица хранит данные о графиков работы: название графика работы
```sql
CREATE TABLE IF NOT EXISTS dictionary.typetimeline
(
    timeline_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_typetimeline PRIMARY KEY,
    name        VARCHAR(32) NOT NULL
);
```