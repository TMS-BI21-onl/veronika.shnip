/*a)	Извлечь все столбцы из таблицы Sales.SalesTerritory.*/

SELECT *
FROM Sales.SalesTerritory

/*b)	Извлечь столбцы TerritoryID и Name из таблицы Sales.SalesTerritory.*/
SELECT TerritoryID,Name
FROM Sales.SalesTerritory

/*c)	Найдите все данные, которые существует для людей из Person.Person с LastName = ‘Norman’.*/
SELECT *
FROM Person.Person
WHERE LastName = 'Norman'

/*d)	Найдите все строки из Person.Person, где EmailPromotion не равен 2.*/
SELECT*
FROM Person.Person
WHERE EmailPromotion <>2

/*3.На официальном сайте Microsoft (https://docs.microsoft.com/ru-ru/sql/t-sql/functions/aggregate-functions-transact-sql?view=sql-server-ver15)
ещё раз просмотрите синтаксис SUM, AVG, COUNT, MIN, MAX и примеры для каждой функции. Какие ещё агрегатные функции существуют в языке T-SQL? 
Приведите несколько примеров.*/
--VAR
SELECT VAR(Bonus) AS Bonus
FROM Sales.SalesPerson  
--STDEV
SELECT STDEV(Bonus) AS Bonus
FROM Sales.SalesPerson 
--STDEVP
SELECT STDEVP(Bonus) AS Bonus
FROM Sales.SalesPerson  

/*a)Сколько уникальных PersonType существует для людей из Person.
Person с LastName начинающиеся с буквы М или не содержащий 1 в EmailPromotion.*/
SELECT COUNT (DISTINCT PersonType) AS PersonType
FROM Person.Person
WHERE LastName LIKE 'M%' OR EmailPromotion NOT LIKE '%1%'


SELECT COUNT (DISTINCT PersonType) AS PersonType
FROM Person.Person
WHERE LastName LIKE 'M%' OR EmailPromotion <>1

/*b)Вывести первых 3 специальных предложений из Sales.SpecialOffer с наибольшими DiscountPct, 
которые начинали действовать с 2013-01-01 по 2014-01-01.*/
SELECT TOP 3*
FROM Sales.SpecialOffer
WHERE  StartDate >='2013-01-01' AND EndDate <= '2014-01-01'
ORDER BY DiscountPct DESC

/*c)Найти самый минимальный вес и самый максимальный размер продукта из Production.Product.*/
SELECT MIN (Weight) AS MinWeight, MAX (Size) AS MaxSize
FROM Production.Product

/*d)	Найти самый минимальный вес и самый максимальный размер продукта для каждой подкатегории ProductSubcategoryID из Production.Product. */
SELECT ProductSubcategoryID, MIN (Weight) AS MinWeight, MAX (Size) AS MaxSize
FROM Production.Product
GROUP BY ProductSubcategoryID


/*e) Найти самый минимальный вес и самый максимальный размер продукта для каждой подкатегории ProductSubcategoryID из Production.Product, 
где цвет продукта определен(Color).*/

SELECT ProductSubcategoryID, MIN (Weight) AS MinWeight, MAX (Size) AS MaxSize
FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY ProductSubcategoryID


