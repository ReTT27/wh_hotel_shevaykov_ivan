# customersource



# Таблицы
### Таблица гостей
Данная таблица хранит данные о гостях: ФИО, номер телефона, электронная почта, день рождение.
```sql
CREATE TABLE IF NOT EXISTS customerresources.guest
(
    id_guest  BIGSERIAL   NOT NULL
        CONSTRAINT pk_guest PRIMARY KEY,
    name      VARCHAR(64) NOT NULL,
    phone     VARCHAR(11) NOT NULL,
    email     VARCHAR(32) NOT NULL,
    birth_day DATE        NOT NULL
);
```

### Таблица программы лояльности гостей
Данная таблица хранит данные о программе лояльности гостей: индивудальный номер гостя, баллы гостя (кешбэк), дата регистрации карты, дата последнего использования карты, актуальность карты.
```sql
CREATE TABLE IF NOT EXISTS customerresources.guestloyalty
(
    id_loyalty        BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestloyalty PRIMARY KEY,
    id_guest          BIGINT      NOT NULL,
    cashback_points   INT         NOT NULL,
    date_registration TIMESTAMPTZ NOT NULL,
    date_use          TIMESTAMPTZ NOT NULL,
    is_actual         BOOLEAN     NOT NULL,
    CONSTRAINT uq_guest_loyalty UNIQUE (id_guest, id_loyalty)
);
```

# Функции