/* ??? ????? ???? ?????? ???????? ?????? ??? ?????????? ?????? ???????? 
??? 50 ???????? ?? ??? ??????? ?????? ?????????, ??? ??????? ???????????? ??????????? ?????? 
?? ?????????? ?????????????? ?????????? ???? (10 ? ????? ?????????? � 3 ?????, 5-10 � 2 ?????, 
?????? 5 � 1 ????)*/

CREATE VIEW v_Top50coaches AS
SELECT TOP 50 WITH TIES Position
					   ,EmployeeID
					   ,FirstName
					   ,LastName
					   ,SUM(POINTS) as POINTS
FROM
(
SELECT vc.VisitDate
      ,ve.EmployeeID
--	  ,COUNT(vc.VisitEmployeeID)
	  ,e.Position
	  ,e.FirstName
	  ,e.LastName
	  ,CASE WHEN COUNT(vc.VisitEmployeeID) >= 10 THEN 3
	        WHEN COUNT(vc.VisitEmployeeID) < 10 AND COUNT(vc.VisitEmployeeID) >= 5 THEN 2
			WHEN COUNT(vc.VisitEmployeeID) < 5 THEN 1
       END AS POINTS
FROM [GymsBase].[dbo].[VisitClients] vc
JOIN [dbo].[VisitEmployees] ve ON ve.VisitEmployeeID = vc.VisitEmployeeID
JOIN [dbo].[Employees] e ON e.EmployeeID = ve.EmployeeID
WHERE vc.VisitEmployeeID IS NOT NULL
GROUP BY vc.VisitDate, ve.EmployeeID, e.Position, e.FirstName, e.LastName
--ORDER BY COUNT(vc.VisitEmployeeID) DESC
) v
GROUP BY Position
        ,EmployeeID
	    ,FirstName
	    ,LastName
ORDER BY POINTS DESC

SELECT *
FROM [GymsBase].[dbo].[v_Top50coaches]
