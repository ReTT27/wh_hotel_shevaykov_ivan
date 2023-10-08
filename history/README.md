# customersource



# Таблицы
### Таблица логов уборки
Данная таблица хранит историчность изменений данных об уборки.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|   cleaning_id    |     INT     | Индивидуальный номер уборки                             |
|   employee_id    |     INT     | Индивидуальный номер сотрудника                         |
|     room_id      |  SMALLINT   | Индивидуальный номер гостничного номера                 |
|   dt_cleaning    |    DATE     | Дата уборки                                             |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.cleaningchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_cleaningchanges PRIMARY KEY,
    cleaning_id INT         NOT NULL,
    employee_id INT         NOT NULL,
    room_id     SMALLINT    NOT NULL,
    dt_cleaning DATE        NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);
```

### Таблица логов сотрудников
Данная таблица хранит историчность изменений данных о сотрудниках.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|   employee_id    |     INT     | Индивидуальный номер сотрудника                         |
|       name       |   VARCHAR   | Фамилия Имя Отчество (ФИО)                              |
|      phone       |   VARCHAR   | Номер телефона                                          |
|      email       |   VARCHAR   | Электронная почта                                       |
|     post_id      |  SMALLINT   | Индивидуальный номер должности                          |
|      reward      |   NUMERIC   | Дополнительное денежное вознагрождение (премия)         |
|     pass_id      |     INT     | Индивидуальный номер пропуска сотрудника                |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.employeechanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_employeechanges PRIMARY KEY,
    employee_id INT         NOT NULL,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    email       VARCHAR(32) NOT NULL,
    post_id     SMALLINT    NOT NULL,
    reward      INT         NOT NULL,
    pass_id     INT         NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);
```

### Таблица логов гостей
Данная таблица хранит историчность изменений данных о гостях.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|     guest_id     |     INT     | Индивидуальный номер гостя                              |
|       name       |   VARCHAR   | Фамилия Имя Отчество (ФИО)                              |
|      phone       |   VARCHAR   | Номер телефона                                          |
|      email       |   VARCHAR   | Электронная почта                                       |
|    birth_day     |    DATE     | День рождения                                           |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.guestchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestchanges PRIMARY KEY,
    guest_id    INT         NOT NULL,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    email       VARCHAR(32) NOT NULL,
    birth_day   DATE        NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);
```

### Таблица логов программы лояльности гостей
Данная таблица хранит историчность изменений данных о программе лояльности гостей.  

| Название столбца  | Тип данных  | Описание                                                |
|:-----------------:|:-----------:|:--------------------------------------------------------|
|      log_id       |  BIGSERIAL  | Индивидуальный номер лога                               |
|    loyalty_id     |     INT     | Номер карты лояльности                                  |
|     guest_id      |     INT     | Индивидуальный номер гостя                              |
|  cashback_points  |     INT     | Баллы (Кешбэк) на карте                                 |
| date_registration | TIMESTAMPTZ | Дата регистрации карты                                  |
|     date_use      | TIMESTAMPTZ | Дата последнего использования                           |
|     is_actual     |   BOOLEAN   | Актуальность карты                                      |
|       dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|    ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.guestloyaltychanges
(
    log_id            BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestloyaltychanges PRIMARY KEY,
    loyalty_id        INT         NOT NULL,
    guest_id          INT         NOT NULL,
    cashback_points   INT         NOT NULL,
    date_registration TIMESTAMPTZ NOT NULL,
    date_use          TIMESTAMPTZ NOT NULL,
    is_actual         BOOLEAN     NOT NULL,
    dt_ch             TIMESTAMPTZ NOT NULL,
    ch_employee       INT         NOT NULL
);
```

### Таблица логов пропусков сотрудников
Данная таблица хранит историчность изменений данных о пропусках сотрудников.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|     pass_id      |     INT     | Индивидуальный номер пропуска                           |
|     dt_input     | TIMESTAMPTZ | Дата входа сотрудника в отель                           |
|    dt_output     | TIMESTAMPTZ | Дата выхода сотрудника в отель                          |
|       work       |   BOOLEAN   | На работа ли сотрудник                                  |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.passchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_passchanges PRIMARY KEY,
    pass_id     INT         NOT NULL,
    dt_input    TIMESTAMPTZ NOT NULL,
    dt_output   TIMESTAMPTZ NOT NULL,
    work        BOOLEAN     NOT NULL,
    ch_employee INT         NOT NULL
);
```

### Таблица логов должностей
Данная таблица хранит историчность изменений данных о должностях сотрудников.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|     post_id      |  SMALLINT   | Индивидуальный номер должности                          |
|       name       |   VARCHAR   | Название должности                                      |
|   timeline_id    |  SMALLINT   | Индивидуальный номер графика                            |
|      salary      |   NUMERIC   | Зарплата                                                |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.postchanges
(
    log_id      BIGSERIAL     NOT NULL
        CONSTRAINT pk_postchanges PRIMARY KEY,
    post_id     SMALLINT      NOT NULL,
    name        VARCHAR(64)   NOT NULL,
    timeline_id SMALLINT      NOT NULL,
    salary      NUMERIC(7, 2) NOT NULL,
    dt_ch       TIMESTAMPTZ   NOT NULL,
    ch_employee INT           NOT NULL
);
```

### Таблица логов брони
Данная таблица хранит историчность изменений данных о брони.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|  reservation_id  |     INT     | Индивидуальный номер брони                              |
|     room_id      |  SMALLINT   | Индивидуальный номер гостиничного номера                |
|     guest_id     |     INT     | Индивидуальный номер гостя                              |
|     dt_entry     | TIMESTAMPTZ | Дата въезда                                             |
|     dt_exit      | TIMESTAMPTZ | Дата выезда                                             |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.reservationchanges
(
    log_id         BIGSERIAL   NOT NULL
        CONSTRAINT pk_reservationchanges PRIMARY KEY,
    reservation_id INT         NOT NULL,
    room_id        SMALLINT    NOT NULL,
    guest_id       INT         NOT NULL,
    dt_entry       TIMESTAMPTZ NOT NULL,
    dt_exit        TIMESTAMPTZ NOT NULL,
    dt_ch          TIMESTAMPTZ NOT NULL,
    ch_employee    INT         NOT NULL
);
```

### Таблица логов отзывов
Данная таблица хранит историчность изменений данных об отзывах.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|    review_id     |     INT     | Индивидуальный номер отзыва                             |
|     category     |   VARCHAR   | Категория отзыва (положительный или отрицательный)      |
|     content      |   VARCHAR   | Содержание отзыва                                       |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.reviewschanges
(
    log_id      BIGSERIAL    NOT NULL
        CONSTRAINT pk_reviewschanges PRIMARY KEY,
    review_id   INT          NOT NULL,
    category    VARCHAR(16)  NOT NULL,
    content     VARCHAR(500) NOT NULL,
    dt_ch       TIMESTAMPTZ  NOT NULL,
    ch_employee INT          NOT NULL
);
```

### Таблица логов гостиничных номеров
Данная таблица хранит историчность изменений данных о гостиничном номере.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|     room_id      |  SMALLINT   | Индивидуальный номер гостиничного номера                |
|     type_id      |  SMALLINT   | Индивидуальный номер типа гостиничного номера           |
|      level       |  SMALLINT   | Этаж гостиничного номера                                |
|    actuality     |   BOOLEAN   | Актуальность гостиничного номера                        |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.roomschanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_roomschanges PRIMARY KEY,
    room_id     SMALLINT    NOT NULL,
    type_id     SMALLINT    NOT NULL,
    level       SMALLINT    NOT NULL,
    actuality   BOOLEAN     NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);
```

### Таблица логов продаж
Данная таблица хранит историчность изменений данных о продажах.  

| Название столбца | Тип данных  | Описание                                                                  |
|:----------------:|:-----------:|:--------------------------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                                                 |
|     sale_id      |     INT     | Индивидуальный номер продаж                                               |
|   employee_id    |     INT     | Индивидуальный номер сотрудника                                           |
|     visitors     |    JSONB    | Фамилия Имя Отчество (ФИО) заселяющихся людей вместе с гостем (если есть) |
|  reservation_id  |     INT     | Индивидуальный номер брони                                                |
|   typefeed_id    |  SMALLINT   | Индивидуальный номер тип питания                                          |
|    review_id     |     INT     | Индивидуальный номер отзыва                                               |
|    payment_id    |  SMALLINT   | Индивидуальный номер вида оплаты                                          |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                                            |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные                   |
```sql
CREATE TABLE IF NOT EXISTS history.saleschanges
(
    log_id         BIGSERIAL   NOT NULL
        CONSTRAINT pk_saleschanges PRIMARY KEY,
    sale_id        INT         NOT NULL,
    employee_id    INT         NOT NULL,
    visitors       JSONB,
    reservation_id INT         NOT NULL,
    typefeed_id    SMALLINT    NOT NULL,
    review_id      INT,
    payment_id     SMALLINT    NOT NULL,
    dt_ch          TIMESTAMPTZ NOT NULL,
    ch_employee    INT         NOT NULL
);
```

### Таблица логов типов питания
Данная таблица хранит историчность изменений данных о типах питания в отеле.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|   typefeed_id    |  SMALLINT   | Индивидуальный номер типа питания                       |
|       name       |   VARCHAR   | Тип питания                                             |
|       cost       |   NUMERIC   | Стоимость питания за сутки                              |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.typefeedchanges
(
    log_id      BIGSERIAL     NOT NULL
        CONSTRAINT pk_typefeedchanges PRIMARY KEY,
    typefeed_id SMALLINT      NOT NULL,
    name        VARCHAR(32)   NOT NULL,
    cost        NUMERIC(6, 2) NOT NULL,
    dt_ch       TIMESTAMPTZ   NOT NULL,
    ch_employee INT           NOT NULL
);
```

### Таблица логов типов оплаты
Данная таблица хранит историчность изменений данных о типах оплаты.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|    payment_id    |  SMALLINT   | Индивидуальный номер типа оплаты                        |
|       name       |   VARCHAR   | Вид оплаты                                              |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.typepaymentchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_typepaymentchanges PRIMARY KEY,
    payment_id  SMALLSERIAL NOT NULL,
    name        VARCHAR(32) NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);
```

### Таблица логов типов номеров
Данная таблица хранит историчность изменений данных о типах номеров в отеле.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|     type_id      |  SMALLINT   | Индивидуальный номер типа номера                        |
|       name       |   VARCHAR   | Тип комнаты                                             |
|   number_beds    |   VARCHAR   | Количество спальных мест                                |
|   number_rooms   |  SMALLINT   | Количество комнат                                       |
|       cost       |   NUMERIC   | Стоимость номера за сутки                               |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.typeroomschanges
(
    log_id       BIGSERIAL     NOT NULL
        CONSTRAINT pk_typeroomschanges PRIMARY KEY,
    type_id      SMALLINT      NOT NULL,
    name         VARCHAR(64)   NOT NULL,
    number_beds  VARCHAR(4)    NOT NULL,
    number_rooms SMALLINT      NOT NULL,
    cost         NUMERIC(7, 2) NOT NULL,
    dt_ch        TIMESTAMPTZ   NOT NULL,
    ch_employee  INT           NOT NULL
);
```

### Таблица логов графиков работы
Данная таблица хранит историчность изменений данных о графиков работы.  

| Название столбца | Тип данных  | Описание                                                |
|:----------------:|:-----------:|:--------------------------------------------------------|
|      log_id      |  BIGSERIAL  | Индивидуальный номер лога                               |
|   timeline_id    |  SMALLINT   | Индивидуальный номер типа графика работы                |
|       name       |   VARCHAR   | График работы                                           |
|      dt_ch       | TIMESTAMPTZ | Дата изменения                                          |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменил данные |
```sql
CREATE TABLE IF NOT EXISTS history.typetimelinechanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_typetimelinechanges PRIMARY KEY,
    timeline_id SMALLINT    NOT NULL,
    name        VARCHAR(32) NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);
```