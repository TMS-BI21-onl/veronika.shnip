
-- Создаем временную таблицу для хранения данных
CREATE TABLE TestTable
(Year INT,
 MonthNumber INT,
 OrderQty INT
);
-- Заполняем временную таблицу данными из Production.WorkOrder
INSERT INTO TestTable (Year, MonthNumber, OrderQty)
SELECT YEAR(ModifiedDate) AS Year,
       MONTH(ModifiedDate) AS MonthNumber,
       OrderQty
FROM Production.WorkOrder
WHERE MONTH(ModifiedDate) IN (12, 1, 2); -- Фильтр для зимних месяцев

-- PIVOT
SELECT *
FROM
(SELECT Year, 
  CASE  
         WHEN MonthNumber = 1 THEN 'January'
         WHEN MonthNumber = 2 THEN 'February'
		 WHEN MonthNumber = 12 THEN 'December'
         END AS MonthName, OrderQty
   FROM TestTable) AS SourceTable
PIVOT
(SUM(OrderQty)
 FOR MonthName IN ([January], [February], [December])
) AS PivotTable
ORDER BY Year

-- Удаляем временную таблицу
DROP TABLE TestTable;
