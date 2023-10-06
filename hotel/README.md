# hotel



# Таблицы
### Таблица персонала
Данная таблица хранит данные о персонале: ФИО, номер телефона, электронная почта, номер должности, дополнительное денежное вознагрождение(премия).
```sql
CREATE TABLE IF NOT EXISTS hotel.employee
(
    employee_id SERIAL      NOT NULL
        CONSTRAINT pk_employee PRIMARY KEY,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    email       VARCHAR(32) NOT NULL,
    post_id     SMALLINT    NOT NULL,
    reward      INT         NOT NULL
);
```

### Таблица уборки
Данная таблица хранит данные об уборке: индивидуальный номер работника, индивидуальный номер гостиничного номера, дата уборки.
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
Данная таблица хранит данные о брони гостиничного номера: дата въезда, дата выезда.
```sql
CREATE TABLE IF NOT EXISTS hotel.reservation
(
    reservation_id BIGSERIAL   NOT NULL
        CONSTRAINT pk_reservation PRIMARY KEY,
    dt_entry       TIMESTAMPTZ NOT NULL,
    dt_exit        TIMESTAMPTZ NOT NULL
);
```

### Таблица гостиничного номера
Данная таблица хранит данные о гостиничном номере: тип гостининого номера, этаж номера, актуальность номера.
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
Данная таблица хранит данные о продажах: индивидуальный номер гостиничного номера, индивидуальный номер сотрудника, индивидуальный номер гостя, ФИО заселяющихся людей вместе с гостем (если есть), индивидуальный номер брони, тип питания.
```sql
CREATE TABLE IF NOT EXISTS hotel.sales
(
    sale_id        BIGSERIAL NOT NULL
        CONSTRAINT pk_sales PRIMARY KEY,
    room_id        SMALLINT  NOT NULL,
    employee_id    INT       NOT NULL,
    guest_id       BIGINT    NOT NULL,
    visitors       JSONB,
    reservation_id BIGINT    NOT NULL,
    typefeed_id    SMALLINT  NOT NULL
);
```