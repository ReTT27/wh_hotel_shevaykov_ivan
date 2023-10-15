# dictionary



# Таблицы
### Таблица должностей (Position)
Данная таблица хранит данные о должностях в отеле.

| Название столбца | Тип данных | Описание                       |
|:----------------:|:----------:|:-------------------------------|
|   position_id    |  SMALLINT  | Индивидуальный номер должности |
|       name       |  VARCHAR   | Название должности             |
|      salary      |  NUMERIC   | Зарплата                       |

### Таблица типов питания (TypeFeed)
Данная таблица хранит данные о типах питания в отеле.  

| Название столбца | Тип данных | Описание                          |
|:----------------:|:----------:|:----------------------------------|
|   typefeed_id    |  SMALLINT  | Индивидуальный номер типа питания |
|       name       |  VARCHAR   | Тип питания                       |
|     content      |  VARCHAR   | Входящие блюда                    |
|       cost       |  NUMERIC   | Стоимость питания за сутки        |

### Таблица типов номеров (TypeRooms)
Данная таблица хранит данные о типах номеров в отеле.  

| Название столбца | Тип данных | Описание                         |
|:----------------:|:----------:|:---------------------------------|
|     type_id      |  SMALLINT  | Индивидуальный номер типа номера |
|       name       |  VARCHAR   | Тип комнаты                      |
|   number_beds    |  VARCHAR   | Количество спальных мест         |
|   number_rooms   |  SMALLINT  | Количество комнат                |
|       cost       |  NUMERIC   | Стоимость номера за сутки        |

### Таблица вещей для уборки гостиничных номеров (Storage)
Данная таблица хранит данные о вещах для уборки гостиничных номеров.

| Название столбца | Тип данных | Описание                  |
|:----------------:|:----------:|:--------------------------|
|     thing_id     |  SMALLINT  | Индивидуальный номер вещи |
|       name       |  VARCHAR   | Название вещи             |
|      count       |  SMALLINT  | Количество вещей          |

# Функции
### Добавления должности (PositionUpd)
```sql
SELECT dictionary.positionupd('
{
     "name": "Бухгалтер",
     "salary": 49999.99
}
');
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```
Примеры ошибок
```jsonb 
{
	"errors": [
	    {
		    "error": "dictionary.position_ins.salary",
		    "detail": "salary = -89.00",
		    "message": "Зарплата не может быть отрицательной!"
    	}
	]
}
```

### Изменение зарплаты у должности (PositionUpd)
```sql
SELECT dictionary.positionupd('
{
  "position_id": 9,
  "name": "Бухгалтер",
  "salary": 47999
}
');
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```
Примеры ошибок
```jsonb 
{
	"errors": [
	    {
		    "error": "dictionary.position_ins.salary",
		    "detail": "salary = -89.00",
		    "message": "Зарплата не может быть отрицательной!"
    	}
	]
}
```

### Добавления вещи на склад (StorageUpd)
```sql
SELECT dictionary.storageupd('
{
  "name": "Гель для душа",
  "count": 134
}
');
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```
Примеры ошибок
```jsonb 
{
	"errors": [
	    {
		    "error": "dictionary.storage_ins.count",
		    "detail": "count = -67",
		    "message": "Колчество не может быть отрицательным!"
	    }
	]
}
```

### Изменение количество вещей на складе (StorageUpd)
```sql
SELECT dictionary.storageupd('
{
  "thing_id": 2,
  "name": "Гель для душа",
  "count": 123
}
');
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```
Примеры ошибок
```jsonb 
{
	"errors": [
	    {
		    "error": "dictionary.storage_ins.count",
		    "detail": "count = -67",
		    "message": "Колчество не может быть отрицательным!"
	    }
	]
}
```

### Добавление типа питания (TypeFeedUpd)
```sql
SELECT dictionary.typefeedupd('
{
  "name": "Завтрак",
  "content": "Каша, чай",
  "cost": 274.99
}
');
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```
Примеры ошибок
```jsonb 
{
	"errors": [
	    {
		    "error": "dictionary.typefeed_ins.cost",
		    "detail": "cost = -274.99",
		    "message": "Стоимость не может быть отрицательной!"
	    }
	]
}
```

### Изменение описания и стоимости типа питания (TypeFeedUpd)
```sql
SELECT dictionary.typefeedupd('
{
  "typefeed_id": 1,
  "name": "Завтрак",
  "content": "Каша, чай",
  "cost": 284.99
}
');
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```
Примеры ошибок
```jsonb 
{
	"errors": [
	    {
		    "error": "dictionary.typefeed_ins.cost",
		    "detail": "cost = -274.99",
		    "message": "Стоимость не может быть отрицательной!"
	    }
	]
}
```

### Добавление типа комнаты (TypeRoomsUpd)
```sql
SELECT dictionary.typeroomsupd('
{
  "name": "Стандартный номер",
  "number_beds": "SGL",
  "number_rooms": 1,
  "cost": 2799.99
}
');
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```
Примеры ошибок
```jsonb 
{
	"errors": [
	    {
		    "error": "dictionary.typerooms_ins.cost",
		    "detail": "cost = -2799.99",
		    "message": "Стоимость не может быть отрицательной!"
	    }
	]
}
```

### Изменение стоимости у типа комнаты (TypeRoomsUpd)
```sql
SELECT dictionary.typeroomsupd('
{
  "type_id": 1,
  "name": "Стандартный номер",
  "number_beds": "SGL",
  "number_rooms": 1,
  "cost": 2699.99
}
');
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : null}
```
Примеры ошибок
```jsonb 
{
	"errors": [
	    {
		    "error": "dictionary.typerooms_ins.cost",
		    "detail": "cost = -2799.99",
		    "message": "Стоимость не может быть отрицательной!"
	    }
	]
}
```