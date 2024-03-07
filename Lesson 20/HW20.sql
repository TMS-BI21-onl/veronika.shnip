/*1.	Покажите всех менеджеров, которые имеют в подчинении больше 6-ти сотрудников.
SELECT MANAGER_ID, COUNT(EMPLOYEE_ID) AS cnt_Employees*/
FROM EMPLOYEES
GROUP BY MANAGER_ID
HAVING COUNT(EMPLOYEE_ID)>6

/*2.	Вывести min и max зарплату с вычетом commission_pct для каждого департамента. (commission_pct на базе указывается в процентах). */ 
SELECT d.DEPARTMENT_NAME, 
MIN(e.SALARY - e.SALARY * e.COMISSION_PCT / 100) AS MIN_SALARY, 
MAX(e.SALARY - e.SALARY * e.COMISSION_PCT / 100) AS MAX_SALARY
FROM DEPARTMENS d 
JOIN EMPLOYEES e ON d.DEPARTMENT_ID=e.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_NAME, e.COMISSION_PCT

/*3.	Вывести только регион, где работают больше всего людей.*/
SELECT TOP 1 r.REGION_NAME, COUNT(1) AS EMPLOYEE_COUNT
FROM REGIONS R
JOIN LOCATIONS L ON r.REGION_ID = l.REGION_ID
JOIN DEPARTMENTS D ON l.LOCATION_ID = d.LOCATION_ID
JOIN EMPLOYEES E ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY r.REGION_NAME
ORDER BY COUNT(1) DESC;

/*4.	Найдите разницу в процентах между средней зп по каждому департаменту от общей средней (по всем департаментам)*/

SELECT d.DEPARTMENT_NAME,
(AVG(e.SALARY) OVER (PARTITION BY  d.DEPARTMENT_NAME) / AVG(e.SALARY) OVER()) * 100 AS dif
FROM DEPARTMENS d 
JOIN EMPLOYEES e ON d.DEPARTMENT_ID=e.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_NAME, e.SALARY

/*Найдите людей, кто проработал больше, чем 10 лет в одном департаменте.*/
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    d.DEPARTMENT_NAME,
    DATEDIFF(YEAR, e.HIRE_DATE, GETDATE()) AS YEARS_WORKED
FROM 
    EMPLOYEES E
INNER JOIN 
    DEPARTMENTS D ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY 
    e.FIRST_NAME,
    e.LAST_NAME,
    d.DEPARTMENT_NAME
HAVING 
    DATEDIFF(YEAR, e.HIRE_DATE, GETDATE()) > 10

/*Найдите людей, кто занимает 5-10 место по размеру зарплаты. */
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME
FROM 
(SELECT FIRST_NAME, LAST_NAME, SALARY,
DENSE_RANK () OVER (ORDER BY SALARY DESC) AS d_rnk
FROM EMPLOYEES) t
WHERE d_rnk BETWEEN 5 AND 10
