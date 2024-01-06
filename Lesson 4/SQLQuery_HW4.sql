/*3. При каких значениях оконные функции Row Number, Rank и Dense Rank вернут одинаковый результат?

Если упорядовачивать таблицу только по какому-то столбцу (ORDER BY), не используя разбиение PARTITION BY,
то при использовании функций ROW_NUMBER, RANK и DENSE_RANK для пронумерации строк,
эти функции присвоят одинаковые номера или ранги тем строкам, у которых значения в упорядочиваемом столбце совпадают. 
Так, если значения одинаковые, то функции присвоят им одинаковые номера или ранги сохранив порядок сортировки.*/

/*4. 4.	Решите на базе данных AdventureWorks2017 следующие задачи. 
a)	Изучите данные в таблице Production.UnitMeasure. Проверьте, есть ли здесь UnitMeasureCode, начинающиеся на букву ‘Т’. 
Сколько всего различных кодов здесь есть? 
Вставьте следующий набор данных в таблицу:
•	TT1, Test 1, 9 сентября 2020
•	TT2, Test 2, getdate()

Проверьте теперь, есть ли здесь UnitMeasureCode, начинающиеся на букву ‘Т’. */

SELECT COUNT (DISTINCT UnitMeasureCode) AS TotlalCode
FROM Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'
--0

INSERT INTO Production.UnitMeasure (UnitMeasureCode, Name, ModifiedDate)
VALUES ('TT1', 'Test 1', '2020-09-09')

SELECT COUNT (DISTINCT UnitMeasureCode) AS TotlalCode
FROM Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'
--1

--вставка TT2, Test 2, getdate()
INSERT INTO Production.UnitMeasure (UnitMeasureCode, Name, ModifiedDate)
VALUES ('TT2', 'Test 2', GETDATE())

SELECT COUNT (DISTINCT UnitMeasureCode) AS TotlalCode
FROM Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'
--2

/*b)Теперь загрузите вставленный набор в новую, не существующую таблицу Production.UnitMeasureTest. 
Догрузите сюда информацию из Production.UnitMeasure по UnitMeasureCode = ‘CAN’.
Посмотрите результат в отсортированном виде по коду"*/

CREATE TABLE Production.UnitMeasureTest (UnitMeasureCode NCHAR (3),
                                         Name NVARCHAR(50),
                                         ModifiedDate DATETIME

INSERT INTO Production.UnitMeasureTest (UnitMeasureCode, Name, ModifiedDate)
VALUES ('TT1', 'Test 1', '2020-09-09'),
       ('TT2', 'Test 2', GETDATE())
--Догрузка информации из Production.UnitMeasure по UnitMeasureCode = 'CAN'

INSERT INTO Production.UnitMeasureTest (UnitMeasureCode, Name, ModifiedDate)
SELECT UnitMeasureCode, Name, ModifiedDate
FROM Production.UnitMeasure
WHERE UnitMeasureCode = 'CAN'

SELECT *
FROM Production.UnitMeasureTest
ORDER BY UnitMeasureCode

/*c)Измените UnitMeasureCode для всего набора из Production.UnitMeasureTest на ‘TTT’.*/

UPDATE Production.UnitMeasureTest
SET UnitMeasureCode = 'TTT'
/*d)	Удалите все строки из Production.UnitMeasureTest.*/
DELETE FROM Production.UnitMeasureTest

/*e)Найдите информацию из Sales.SalesOrderDetail по заказам 43659,43664. 
С помощью оконных функций MAX, MIN, AVG найдем агрегаты по LineTotal для каждого SalesOrderID.*/

SELECT SalesOrderID,LineTotal, MAX(LineTotal) OVER (PARTITION BY SalesOrderID) AS MaxLineTotal,
                               MIN(LineTotal) OVER (PARTITION BY SalesOrderID) AS MinLineTotal,
                               AVG(LineTotal) OVER (PARTITION BY SalesOrderID) AS AvgLineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664)

/* f)f)	Изучите данные в объекте Sales.vSalesPerson. Создайте рейтинг cреди продавцов на основе годовых продаж SalesYTD, используя ранжирующую оконную функцию. 
Добавьте поле Login, состоящий из 3 первых букв фамилии в верхнем регистре + ‘login’ + TerritoryGroup (Null заменить на пустое значение). 
Кто возглавляет рейтинг? А кто возглавлял рейтинг в прошлом году (SalesLastYear). */


SELECT BusinessEntityID,SalesYTD,
    RANK() OVER (ORDER BY SalesYTD DESC) AS SalesRank,
    COALESCE(UPPER(SUBSTRING(LastName, 1, 3)) + 'login' + ISNULL(TerritoryGroup, ''), '') AS Login
FROM Sales.vSalesPerson
--Кто возглавляет рейтинг? MITloginNorth America

--А кто возглавлял рейтинг в прошлом году (SalesLastYear)? VARloginEurope
SELECT BusinessEntityID,SalesLastYear,
    RANK() OVER (ORDER BY SalesLastYear DESC) AS SalesRank,
    COALESCE(UPPER(SUBSTRING(LastName, 1, 3)) + 'login' + ISNULL(TerritoryGroup, ''), '') AS Login
FROM Sales.vSalesPerson

/*g)	Найдите первый будний день месяца (FROM не используем). Нужен стандартный код на все времена.*/

DECLARE @CurrentDate DATE = GETDATE()
DECLARE @FirstWeekday DATE
-- Вычисляем первый день месяца
SET @FirstWeekday = DATEADD(DAY, 1 - DATEPART(DAY, @CurrentDate), @CurrentDate)
-- Если понедельник-выходной день 
IF DATEPART(WEEKDAY, @FirstWeekday) = 1
SET @FirstWeekday = DATEADD(DAY, 1, @FirstWeekday)
SELECT @FirstWeekday AS FirstWeekdayOfMonth

/*Давайте еще раз остановимся и отточим понимание функции count. Найдите значения count(1), count(name), count(id), count(*) для следующей таблицы:
Id(PK)	              Name		           DepName
1	                 null		             A
2	                 null		            null
3	                  A		                 C
4	                  B		                 C

СOUNT (1) - посчитать все записи в таблице. Ответ: 4
СOUNT (name) - посчитать количество непустых значений в столбце Name. Ответ: 2
COUNT (ID)- посчитать количество непустых значений в столбце ID. Oтвет: 4
COUNT * - посчитать все записи в таблице. Ответ: 4*/





