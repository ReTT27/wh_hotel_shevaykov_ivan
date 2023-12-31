# customersource



# Таблицы
### Таблица гостей (Guest)
Данная таблица хранит данные о гостях отеля.

| Название столбца | Тип данных  | Описание                                                 |
|:----------------:|:-----------:|:---------------------------------------------------------|
|     guest_id     |     INT     | Индивидуальный номер гостя                               |
|       name       |   VARCHAR   | Фамилия Имя Отчество (ФИО)                               |
|      phone       |   VARCHAR   | Номер телефона                                           |
|      email       |   VARCHAR   | Электронная почта                                        |
|    birth_day     |    DATE     | День рождения                                            |
|     card_id      |     INT     | Номер карты лояльности                                   |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменяет запись |
|      dt_ch       | TIMESTAMPTZ | Дата изменения записи                                    |

### Таблица программы лояльности гостей (GuestLoyalty)
Данная таблица хранит данные о программе лояльности гостей.  

| Название столбца | Тип данных  | Описание                                                  |
|:----------------:|:-----------:|:----------------------------------------------------------|
|     card_id      |     INT     | Номер карты лояльности                                    |
| cashback_points  |     INT     | Баллы (Кешбэк) на карте                                   |
| dt_registration  | TIMESTAMPTZ | Дата регистрации карты                                    |
|      dt_use      | TIMESTAMPTZ | Дата последнего использования                             |
|    is_actual     |   BOOLEAN   | Актуальность карты (TRUE - актуальна, FALSE - заморожена) |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменяет запись  |
|      dt_ch       | TIMESTAMPTZ | Дата изменения записи                                     |

# Функции
### Добавления гостя и карты лояльности (GuestUpd)
```sql
SELECT customerresources.guestupd(_src := '
                                  {
                                    "name": "Овсянникова Софья Андреевна",
                                    "phone": "89991232211",
                                    "email": "yakov37@ya.ru",
                                    "birth_day": "1998-10-8"
                                  }
                                  ', _ch_employee := 2);
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```

### Изменение гостя (GuestUpd)
```sql
SELECT customerresources.guestupd(_src := '
                                  {
                                    "guest_id": 2,
                                    "name": "Щенин Иван Васильевич",
                                    "phone": "89991232233",
                                    "email": "ivan2602@gmail.com",
                                    "birth_day": "1988-10-08"
                                  }
                                  ', _ch_employee := 2);
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```

### Изменение карты (GuestLoyaltyUpd)
```sql
SELECT customerresources.guestloyaltyupd(_src :=  '
                                  {
                                    "card_id": 2,
                                    "is_actual": false
                                  }
                                  ',
                                        _ch_employee := 2);
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```

### Вывод гостя (GuestGet)
На вход есть необязательные параметры, с их помощью осуществляется фильтрация данных.

| Название столбца | Тип данных  | Описание                   |
|:----------------:|:-----------:|:---------------------------|
|    _guest_id     |     INT     | Индивидуальный номер гостя |
|      _phone      |   VARCHAR   | Номер телефона             |
|     _card_id     |     INT     | Номер карты лояльности     |
```sql
SELECT customerresources.guestget(_guest_id := null, _phone := null, _card_id := null);
```
Пример ответа при правильном выполнении:
```jsonb
{
	"data": [
	{
		"name": "Овсянникова Софья Андреевна",
		"dt_ch": "2023-10-15T20:40:35.058037+00:00",
		"email": "yakov37@ya.ru",
		"phone": "89991232211",
		"card_id": 2,
		"guest_id": 1,
		"birth_day": "1998-10-08",
		"ch_employee": 2
	},
	{
		"name": "Щенин Иван Васильевич",
		"dt_ch": "2023-10-15T20:44:25.568751+00:00",
		"email": "ivan2602@gmail.com",
		"phone": "89991232233",
		"card_id": 5,
		"guest_id": 2,
		"birth_day": "1988-10-08",
		"ch_employee": 2
	},
	{
		"name": "Покровская Александра Константиновна",
		"dt_ch": "2023-10-17T14:57:54.418607+00:00",
		"email": "yakov34@ya.ru",
		"phone": "89991232214",
		"card_id": 7,
		"guest_id": 4,
		"birth_day": "1998-10-08",
		"ch_employee": 2
	},
	{
		"name": "Окулов Андрей Владимирович",
		"dt_ch": "2023-10-17T14:58:14.914764+00:00",
		"email": "yakov34@ya.ru",
		"phone": "89991232255",
		"card_id": 8,
		"guest_id": 5,
		"birth_day": "1998-10-08",
		"ch_employee": 2
	}]
}
```

### Вывод карты лояльности (GuestLoyaltyGet)
На вход есть необязательные параметры, с их помощью осуществляется фильтрация данных.

| Название столбца | Тип данных | Описание               |
|:----------------:|:----------:|:-----------------------|
|     _card_id     |    INT     | Номер карты лояльности |
```sql
SELECT customerresources.guestloyaltyget(_card_id := null);
```
Пример ответа при правильном выполнении:
```jsonb
{
	"data": [
	{
		"dt_ch": "2023-10-15T20:40:35.058037+00:00",
		"dt_use": "2023-10-15T20:40:35.058037+00:00",
		"card_id": 2,
		"is_actual": true,
		"ch_employee": 2,
		"cashback_points": 1188,
		"dt_registration": "2023-10-15T20:40:35.058037+00:00"
	},
	{
		"dt_ch": "2023-10-15T20:44:25.568751+00:00",
		"dt_use": "2023-10-15T20:44:25.568751+00:00",
		"card_id": 5,
		"is_actual": true,
		"ch_employee": 2,
		"cashback_points": 1188,
		"dt_registration": "2023-10-15T20:44:25.568751+00:00"
	},
	{
		"dt_ch": "2023-10-17T14:58:14.914764+00:00",
		"dt_use": "2023-10-17T14:58:14.914764+00:00",
		"card_id": 8,
		"is_actual": true,
		"ch_employee": 2,
		"cashback_points": 1188,
		"dt_registration": "2023-10-17T14:58:14.914764+00:00"
	},
	{
		"dt_ch": "2023-10-17T14:57:54.418607+00:00",
		"dt_use": "2023-10-17T14:57:54.418607+00:00",
		"card_id": 7,
		"is_actual": true,
		"ch_employee": 2,
		"cashback_points": 2376,
		"dt_registration": "2023-10-17T14:57:54.418607+00:00"
	}]
}
```