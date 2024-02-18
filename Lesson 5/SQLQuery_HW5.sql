--Задача 6
CREATE TABLE Patients 
(ID INT IDENTITY(1,1) PRIMARY KEY,
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
SSN NVARCHAR(15) UNIQUE,
Email AS (UPPER(SUBSTRING(FirstName, 1, 1)) + LOWER(SUBSTRING(LastName, 1, 3)) + '@mail.com'),
Temp DECIMAL(5,2), 
CreatedDate DATE)
--7.Добавить в таблицу несколько произвольных записей. 
INSERT INTO Patients (FirstName, LastName, SSN, Temp, CreatedDate)
VALUES ('Veronika', 'Shnip', '123456789', 36.9, '2024-01-13'),
       ('Nataly', 'Kobenyak', '123456777', 36.8, '2024-01-13'),
	   ('Anna', 'Klops', '123456666', 36.7, '2024-01-13')
/*8.Добавить поле TempType со следующими значениями ‘< 37°C’,  ‘> 37°C’ на основе значений из поля Temp (используйте ALTER TABLE 
ADD column AS ). Посмотрите на данные, которые получились.*/
ALTER TABLE Patients
ADD TempType AS 
CASE WHEN Temp < 37 THEN '< 37°C'
WHEN Temp > 37 THEN '> 37°C'
ELSE '= 37°C' -- Если температура равна 37°C
END;

SELECT * 
FROM Patients
/* 9.Создать представление (view) Patients_v, показывающее температуру в градусах Фаренгейта (°F = °Cx9/5 + 32)*/

CREATE VIEW Patients_v
AS
SELECT ID,FirstName,LastName,SSN,Email,Temp,CreatedDate,TempType,
(Temp * 9/5 + 32) AS TempFahrenheit
FROM Patients

SELECT * 
FROM Patients_v

/*10.	Создать функцию, которая возвращает температуру в градусах Фаренгейта, при подаче на вход градусы в Цельсиях.*/
CREATE FUNCTION ConvertToFarhenheit (@CelsiusTemp DECIMAL(5,2))
RETURNS DECIMAL(5,2)
AS
BEGIN
DECLARE @FahrenheitTemp DECIMAL(5,2)
SET @FahrenheitTemp = @CelsiusTemp * 9/5 + 32
RETURN @FahrenheitTemp;
END

/*11.	Перепишите решение задачи g из прошлого дз с использованием переменной, максимально упрощая select*/
DECLARE @CurrentDate DATE = GETDATE()
DECLARE @FirstWeekday DATE
-- Вычисляем первый день месяца
SET @FirstWeekday = DATEADD(DAY, 1 - DATEPART(DAY, @CurrentDate), @CurrentDate)
-- Если понедельник-выходной день 
IF DATEPART(WEEKDAY, @FirstWeekday) = 1
SET @FirstWeekday = DATEADD(DAY, 1, @FirstWeekday)
SELECT @FirstWeekday AS FirstWeekdayOfMonth

/* 12. В таблице Employees хранятся все сотрудники. В таблице Job_history хранятся сотрудники, 
которые покинули компанию. Получить репорт о всех сотрудниках и о их статусе в компании (Работает или покинул компанию с датой ухода)*/

SELECT Employees.First_Name,
CASE WHEN Job_History.Employee_ID IS NOT NULL THEN 'Left the company at ' + FORMAT(Job_History.End_Date, 'dd of MMMM, yyyy')
ELSE 'Currently Working'
END AS Status
FROM Employees
LEFT JOIN Job_History  
ON Employees.Employee_ID = Job_History.Employee_ID

