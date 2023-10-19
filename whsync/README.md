# hotel



# Таблицы
### Таблица персонала (EmployeeSync)
Данная таблица хранит данные о персонале.  

| Название столбца | Тип данных  | Описание                                                 |
|:----------------:|:-----------:|:---------------------------------------------------------|
|   employee_id    |     INT     | Индивидуальный номер сотрудника                          |
|       name       |   VARCHAR   | Фамилия Имя Отчество (ФИО)                               |
|      phone       |   VARCHAR   | Номер телефона                                           |
|      email       |   VARCHAR   | Электронная почта                                        |
|   position_id    |  SMALLINT   | Индивидуальный номер должности                           |
|      reward      |   NUMERIC   | Дополнительное денежное вознаграждение (премия)          |
|    is_deleted    |   BOOLEAN   | Уволен ли сотрудник (TRUE - да, FALSE - нет)             |
|   ch_employee    |     INT     | Индивидуальный номер сотрудника, который изменяет запись |
|      dt_ch       | TIMESTAMPTZ | Дата изменения записи                                    |
|     dt_sync      | TIMESTAMPTZ | Дата экспорта в синке                                    |


# Функции
### Экспорт сотрудника (EmployeeSyncExport)
```sql
SELECT whsync.employeesyncexport(_log_id := 1);
```

### Импорт сотрудника (EmployeeSyncImport)
```sql
SELECT whsync.employeessyncimport(_src := '[{
		"name": "Шевяков Иван Максимович",
		"dt_ch": "2023-10-15T16:41:23.877933+00:00",
		"email": "sh@gmail.com",
		"phone": "89221441133",
		"reward": 25000.00,
		"is_deleted": false,
		"ch_employee": 0,
		"employee_id": 1,
		"position_id": 1
	}]');
```