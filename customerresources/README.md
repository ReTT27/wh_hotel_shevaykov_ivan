# customersource



# Таблицы
### Таблица гостей
Данная таблица хранит данные о гостях отеля.

| Название столбца | Тип столбца | Описание                   |
|:----------------:|:-----------:|:---------------------------|
|     guest_id     |   SERIAL    | Индивидуальный номер гостя |
|       name       |   VARCHAR   | Фамилия Имя Отчество (ФИО) |
|      phone       |   VARCHAR   | Номер телефона             |
|      email       |   VARCHAR   | Электронная почта          |
|    birth_day     |    DATE     | День рождения              |
```sql
CREATE TABLE IF NOT EXISTS customerresources.guest
(
    guest_id  SERIAL      NOT NULL
        CONSTRAINT pk_guest PRIMARY KEY,
    name      VARCHAR(64) NOT NULL,
    phone     VARCHAR(11) NOT NULL,
    email     VARCHAR(32) NOT NULL,
    birth_day DATE        NOT NULL
);
```

### Таблица программы лояльности гостей
Данная таблица хранит данные о программе лояльности гостей.  

| Название столбца  | Тип столбца | Описание                      |
|:-----------------:|:-----------:|:------------------------------|
|    loyalty_id     |   SERIAL    | Номер карты лояльности        |
|     guest_id      |     INT     | Индивидуальный номер гостя    |
|  cashback_points  |     INT     | Баллы (Кешбэк) на карте       |
| date_registration | TIMESTAMPTZ | Дата регистрации карты        |
|     date_use      | TIMESTAMPTZ | Дата последнего использования |
|     is_actual     |   BOOLEAN   | Актуальность карты            |
```sql
CREATE TABLE IF NOT EXISTS customerresources.guestloyalty
(
    loyalty_id        SERIAL      NOT NULL
        CONSTRAINT pk_guestloyalty PRIMARY KEY,
    guest_id          INT         NOT NULL,
    cashback_points   INT         NOT NULL,
    date_registration TIMESTAMPTZ NOT NULL,
    date_use          TIMESTAMPTZ NOT NULL,
    is_actual         BOOLEAN     NOT NULL
);
```