﻿
SELECT*
FROM 
    (SELECT 
         Ж.СтранаОбитания AS Страна,
         БЖ.Название AS Болезнь,
         COUNT(CASE WHEN ФБ.Статус = 'обнаружено' THEN ИД_Животного ELSE 0 END) AS cnt
     FROM 
         Животные Ж
     LEFT JOIN 
         Факты_болезни ФБ ON Ж.ИД_животного = ФБ.ИД_животного
     LEFT JOIN 
         Болезни_животных БЖ ON ФБ.ИД_болезни = БЖ.ИД_болезни
     GROUP BY 
         СтранаОбитания, БЖ.Название) AS SourceTable
PIVOT 
    (SUM(cnt) FOR Болезнь IN ([Название_болезни_1], [Название_болезни_2], ..., [Название_болезни_n])) AS PivotTable




WITH cte AS 
(SELECT 
    COUNT(CASE WHEN ДатаВремя_Кормления < ДатаВремя_Уборки THEN ИД_Ухода ELSE 0 END) AS Кормление_до_уборки,
    COUNT(CASE WHEN ДатаВремя_Кормления >= ДатаВремя_Уборки THEN ИД_Ухода ELSE 0 END) AS Кормление_после_уборки,
    COUNT(ИД_Ухода) AS Всего_случаев
FROM Уход)
SELECT Кормление_до_уборки,Кормление_после_уборки, 
       Кормление_до_уборки/Всего_случаев*100 AS Процент_до_уборки
FROM cte

