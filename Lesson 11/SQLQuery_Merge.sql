SELECT*
FROM [dbo].[data_for_merge]

CREATE TABLE data_for_merge2
(Function_name nvarchar(30),
 Function_count INT
);
SELECT*
FROM data_for_merge

SELECT*
FROM data_for_merge2
ORDER BY Function_name


MERGE INTO data_for_merge2 AS Target --куда будем вставлять
USING data_for_merge AS Source --откуда
ON Target.Function_name = Source.Alex --сравнивать две колонки в двух таблица (таргет и сорс)
WHEN NOT MATCHED THEN
INSERT (Function_name, Function_count) VALUES (Source.Alex,1);


MERGE INTO data_for_merge2 AS Target 
USING data_for_merge AS Source 
ON Target.Function_name = Source.Carlos 
WHEN MATCHED THEN 
    UPDATE SET Target.Function_count = Target.Function_count+1
WHEN NOT MATCHED AND Source.Carlos IS NOT NULL THEN
INSERT (Function_name, Function_count) VALUES (Source.Carlos,1);


--TRUNCATE TABLE data_for_merge2

MERGE INTO data_for_merge2 AS Target 
USING data_for_merge AS Source 
ON Target.Function_name = Source.Charles 
WHEN MATCHED THEN 
    UPDATE SET Target.Function_count = Target.Function_count+1
WHEN NOT MATCHED AND Source.Charles IS NOT NULL THEN
INSERT (Function_name, Function_count) VALUES (Source.Charles,1);

MERGE INTO data_for_merge2 AS Target 
USING data_for_merge AS Source 
ON Target.Function_name = Source.Daniel 
WHEN MATCHED THEN 
    UPDATE SET Target.Function_count = Target.Function_count+1
WHEN NOT MATCHED AND Source.Daniel IS NOT NULL THEN
INSERT (Function_name, Function_count) VALUES (Source.Daniel,1);


MERGE INTO data_for_merge2 AS Target 
USING data_for_merge AS Source 
ON Target.Function_name = Source.Esteban 
WHEN MATCHED THEN 
    UPDATE SET Target.Function_count = Target.Function_count+1
WHEN NOT MATCHED AND Source.Esteban IS NOT NULL THEN
INSERT (Function_name, Function_count) VALUES (Source.Esteban,1);

MERGE INTO data_for_merge2 AS Target 
USING data_for_merge AS Source 
ON Target.Function_name = Source.Fred 
WHEN MATCHED THEN 
    UPDATE SET Target.Function_count = Target.Function_count+1
WHEN NOT MATCHED AND Source.Fred IS NOT NULL THEN
INSERT (Function_name, Function_count) VALUES (Source.Fred,1);

MERGE INTO data_for_merge2 AS Target 
USING data_for_merge AS Source 
ON Target.Function_name = Source.George 
WHEN MATCHED THEN 
    UPDATE SET Target.Function_count = Target.Function_count+1
WHEN NOT MATCHED AND Source.George IS NOT NULL THEN
INSERT (Function_name, Function_count) VALUES (Source.George,1);


MERGE INTO data_for_merge2 AS Target 
USING data_for_merge AS Source 
ON Target.Function_name = Source.Lando 
WHEN MATCHED THEN 
    UPDATE SET Target.Function_count = Target.Function_count+1
WHEN NOT MATCHED AND Source.Lando IS NOT NULL THEN
INSERT (Function_name, Function_count) VALUES (Source.Lando,1);

MERGE INTO data_for_merge2 AS Target 
USING data_for_merge AS Source 
ON Target.Function_name = Source.Lewis 
WHEN MATCHED THEN 
    UPDATE SET Target.Function_count = Target.Function_count+1
WHEN NOT MATCHED AND Source.Lewis IS NOT NULL THEN
INSERT (Function_name, Function_count) VALUES (Source.Lewis,1);

