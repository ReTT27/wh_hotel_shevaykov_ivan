# dictionary



# Таблицы
### Таблица должностей
Данная таблица хранит данные о должностях в отеле.

| Название столбца | Тип данных  | Описание                       |
|:----------------:|:-----------:|:-------------------------------|
|     post_id      | SMALLSERIAL | Индивидуальный номер должности |
|       name       |   VARCHAR   | Название должности             |
|   timeline_id    |  SMALLINT   | Индивидуальный номер графика   |
|      salary      |   NUMERIC   | Зарплата                       |
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
Данная таблица хранит данные о типах питания в отеле.  

| Название столбца | Тип данных  | Описание                          |
|:----------------:|:-----------:|:----------------------------------|
|   typefeed_id    | SMALLSERIAL | Индивидуальный номер типа питания |
|       name       |   VARCHAR   | Тип питания                       |
|       cost       |   NUMERIC   | Стоимость питания за сутки        |
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
Данная таблица хранит данные о типах номеров в отеле.  

| Название столбца | Тип данных  | Описание                         |
|:----------------:|:-----------:|:---------------------------------|
|     type_id      | SMALLSERIAL | Индивидуальный номер типа номера |
|       name       |   VARCHAR   | Тип комнаты                      |
|   number_beds    |   VARCHAR   | Количество спальных мест         |
|   number_rooms   |  SMALLINT   | Количество комнат                |
|       cost       |   NUMERIC   | Стоимость номера за сутки        |
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
Данная таблица хранит данные о типах оплаты.  

| Название столбца | Тип данных  | Описание                         |
|:----------------:|:-----------:|:---------------------------------|
|    payment_id    | SMALLSERIAL | Индивидуальный номер типа оплаты |
|       name       |   VARCHAR   | Вид оплаты                       |
```sql
CREATE TABLE IF NOT EXISTS dictionary.typepayment
(
    payment_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_typepayment PRIMARY KEY,
    name       VARCHAR(32) NOT NULL
);
```

### Таблица графиков работы
Данная таблица хранит данные о графиков работы.  

| Название столбца | Тип данных  | Описание                                 |
|:----------------:|:-----------:|:-----------------------------------------|
|   timeline_id    | SMALLSERIAL | Индивидуальный номер типа графика работы |
|       name       |   VARCHAR   | График работы                            |
```sql
CREATE TABLE IF NOT EXISTS dictionary.typetimeline
(
    timeline_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_typetimeline PRIMARY KEY,
    name        VARCHAR(32) NOT NULL
);
```