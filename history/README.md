# customersource



# Таблицы
### Таблица логов гостей
Данная таблица хранит историчность изменений данных о гостях: индивидуальный номер гостя, ФИО, номер телефона, электронная почта, день рождение, дата изменения записи, индивдуальный номер сотрудника, который изменил запись.
```sql
CREATE TABLE IF NOT EXISTS history.guestchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestchanges PRIMARY KEY,
    id_guest    BIGINT      NOT NULL,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    email       VARCHAR(32) NOT NULL,
    birth_day   DATE        NOT NULL,
    dt_ch       TIMESTAMPTZ NOT NULL,
    ch_employee INT         NOT NULL
);
```

### Таблица логов программы лояльности гостей
Данная таблица хранит историчность изменений данных о программе лояльности гостей: индивидуальный номер карты лояльности, индивудальный номер гостя, баллы гостя, дата регистрации карты, дата последнего использования карты, актуальность карты, дата изменения записи, индивдуальный номер сотрудника, который изменил запись.
```sql
CREATE TABLE IF NOT EXISTS history.guestloyaltychanges
(
    log_id            BIGSERIAL   NOT NULL
        CONSTRAINT pk_guestloyaltychanges PRIMARY KEY,
    id_loyalty        BIGINT      NOT NULL,
    id_guest          BIGINT      NOT NULL,
    cashback_points   INT         NOT NULL,
    date_registration TIMESTAMPTZ NOT NULL,
    date_use          TIMESTAMPTZ NOT NULL,
    is_actual         BOOLEAN     NOT NULL,
    dt_ch             TIMESTAMPTZ NOT NULL,
    ch_employee       INT         NOT NULL
);
```