# objects



# Схемы для использования в проекте
### Схема public
```sql
CREATE SCHEMA IF NOT EXISTS public;
```
Схема public используется для хранения общих функций и сведенье об отеле.

### Схема customerresources
```sql
CREATE SCHEMA IF NOT EXISTS customerresources;
```
Схема customerresources используется для хранения функций и сведений связанных с гостями отеля.

### Схема history
```sql
CREATE SCHEMA IF NOT EXISTS history;
```
Схема history используется для историчности сведений связанных с отелем.

### Схема dictionary
```sql
CREATE SCHEMA IF NOT EXISTS dictionary;
```
Схема dictionary является словарем.

### Схема hotel
```sql
CREATE SCHEMA IF NOT EXISTS hotel;
```
Схема hotel используется для хранения функций и сведений происходящих в отеле.
