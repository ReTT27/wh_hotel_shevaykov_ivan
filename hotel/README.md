# hotel



# Таблицы
### Таблица персонала
Данная таблица хранит данные о персонале.  

| Название столбца | Тип данных | Описание                                        |
|:----------------:|:----------:|:------------------------------------------------|
|   employee_id    |   SERIAL   | Индивидуальный номер сотрудника                 |
|       name       |  VARCHAR   | Фамилия Имя Отчество (ФИО)                      |
|      phone       |  VARCHAR   | Номер телефона                                  |
|      email       |  VARCHAR   | Электронная почта                               |
|     post_id      |  SMALLINT  | Индивидуальный номер должности                  |
|      reward      |  NUMERIC   | Дополнительное денежное вознагрождение (премия) |
|     pass_id      |    INT     | Индивидуальный номер пропуска сотрудника        |
```sql
CREATE TABLE IF NOT EXISTS hotel.employee
(
    employee_id SERIAL        NOT NULL
        CONSTRAINT pk_employee PRIMARY KEY,
    name        VARCHAR(64)   NOT NULL,
    phone       VARCHAR(11)   NOT NULL,
    email       VARCHAR(32)   NOT NULL,
    post_id     SMALLINT      NOT NULL,
    reward      NUMERIC(7, 2) NOT NULL,
    pass_id     INT           NOT NULL
);
```

### Таблица уборки
Данная таблица хранит данные об уборке номеров.  

| Название столбца | Тип данных | Описание                                |
|:----------------:|:----------:|:----------------------------------------|
|   cleaning_id    |   SERIAL   | Индивидуальный номер уборки             |
|   employee_id    |  VARCHAR   | Индивидуальный номер сотрудника         |
|     room_id      |  VARCHAR   | Индивидуальный номер гостничного номера |
|   dt_cleaning    |  VARCHAR   | Дата уборки                             |
```sql
CREATE TABLE IF NOT EXISTS hotel.cleaning
(
    cleaning_id SERIAL   NOT NULL
        CONSTRAINT pk_cleaning PRIMARY KEY,
    employee_id INT      NOT NULL,
    room_id     SMALLINT NOT NULL,
    dt_cleaning DATE     NOT NULL
);
```

### Таблица брони
Данная таблица хранит данные о брони гостиничного номера.  

| Название столбца | Тип данных  | Описание                                 |
|:----------------:|:-----------:|:-----------------------------------------|
|  reservation_id  |   SERIAL    | Индивидуальный номер брони               |
|     room_id      |  SMALLINT   | Индивидуальный номер гостиничного номера |
|     guest_id     |     INT     | Индивидуальный номер гостя               |
|     dt_entry     | TIMESTAMPTZ | Дата въезда                              |
|     dt_exit      | TIMESTAMPTZ | Дата выезда                              |
```sql
CREATE TABLE IF NOT EXISTS hotel.reservation
(
    reservation_id SERIAL      NOT NULL
        CONSTRAINT pk_reservation PRIMARY KEY,
    room_id        SMALLINT    NOT NULL,
    guest_id       INT         NOT NULL,
    dt_entry       TIMESTAMPTZ NOT NULL,
    dt_exit        TIMESTAMPTZ NOT NULL
);
```

### Таблица гостиничного номера
Данная таблица хранит данные о гостиничном номере.  

| Название столбца | Тип данных | Описание                                      |
|:----------------:|:----------:|:----------------------------------------------|
|     room_id      |  SMALLINT  | Индивидуальный номер гостиничного номера      |
|     type_id      |  SMALLINT  | Индивидуальный номер типа гостиничного номера |
|      level       |  SMALLINT  | Этаж гостиничного номера                      |
|    actuality     |  BOOLEAN   | Актуальность гостиничного номера              |
```sql
CREATE TABLE IF NOT EXISTS hotel.rooms
(
    room_id   SMALLINT NOT NULL
        CONSTRAINT pk_rooms PRIMARY KEY,
    type_id   SMALLINT NOT NULL,
    level     SMALLINT NOT NULL,
    actuality BOOLEAN  NOT NULL
);
```

### Таблица продаж
Данная таблица хранит данные о продажах.  

| Название столбца | Тип данных | Описание                                                                  |
|:----------------:|:----------:|:--------------------------------------------------------------------------|
|     sale_id      |   SERIAL   | Индивидуальный номер продаж                                               |
|   employee_id    |    INT     | Индивидуальный номер сотрудника                                           |
|     visitors     |   JSONB    | Фамилия Имя Отчество (ФИО) заселяющихся людей вместе с гостем (если есть) |
|  reservation_id  |    INT     | Индивидуальный номер брони                                                |
|   typefeed_id    |  SMALLINT  | Индивидуальный номер тип питания                                          |
|    review_id     |    INT     | Индивидуальный номер отзыва                                               |
|    payment_id    |  SMALLINT  | Индивидуальный номер вида оплаты                                          |
```sql
CREATE TABLE IF NOT EXISTS hotel.sales
(
    sale_id        SERIAL   NOT NULL
        CONSTRAINT pk_sales PRIMARY KEY,
    employee_id    INT      NOT NULL,
    visitors       JSONB,
    reservation_id INT      NOT NULL,
    typefeed_id    SMALLINT NOT NULL,
    review_id      INT,
    payment_id     SMALLINT NOT NULL
);
```

### Таблица отзывов
Данная таблица хранит данные об отзывах.  

| Название столбца | Тип данных | Описание                                           |
|:----------------:|:----------:|:---------------------------------------------------|
|    review_id     |   SERIAL   | Индивидуальный номер отзыва                        |
|     category     |  VARCHAR   | Категория отзыва (положительный или отрицательный) |
|     content      |  VARCHAR   | Содержание отзыва                                  |
```sql
CREATE TABLE IF NOT EXISTS hotel.reviews
(
    review_id SERIAL       NOT NULL
        CONSTRAINT pk_reviews PRIMARY KEY,
    category  VARCHAR(16)  NOT NULL,
    content   VARCHAR(500) NOT NULL
);
```

### Таблица пропусков сотрудников
Данная таблица хранит данные о пропусках сотрудников.  

| Название столбца | Тип данных  | Описание                       |
|:----------------:|:-----------:|:-------------------------------|
|     pass_id      |     INT     | Индивидуальный номер пропуска  |
|     dt_input     | TIMESTAMPTZ | Дата входа сотрудника в отель  |
|    dt_output     | TIMESTAMPTZ | Дата выхода сотрудника в отель |
|       work       |   BOOLEAN   | На работе ли сотрудник         |
```sql
CREATE TABLE IF NOT EXISTS hotel.pass
(
    pass_id   INT         NOT NULL
        CONSTRAINT pk_pass PRIMARY KEY,
    dt_input  TIMESTAMPTZ NOT NULL,
    dt_output TIMESTAMPTZ NOT NULL,
    work      BOOLEAN     NOT NULL
);
```