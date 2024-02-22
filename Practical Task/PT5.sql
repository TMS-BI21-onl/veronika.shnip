--1 ????? ProductSubcategoryID ?? Production.Product, ??? ??? ??? ?????? ProductSubcategoryID ?????? 150
SELECT ProductSubcategoryID
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING MIN(Weight) > 150

--2 ????? ????? ??????? ??????? (???? StandardCost) ?? Production.Product.
--1)
SELECT TOP 1 *
FROM Production.Product
ORDER BY StandardCost DESC
--2)
SELECT TOP 1*
FROM Production.Product
WHERE StandardCost = (SELECT MAX(StandardCost) FROM Production.Product)
--3)
WITH ExpensiveProduct AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY StandardCost DESC) AS rn
    FROM Production.Product
)
SELECT *
FROM ExpensiveProduct
WHERE rn = 1

--4)
SELECT TOP 1*
FROM Production.Product p
JOIN (
    SELECT MAX(StandardCost) AS MaxCost
    FROM Production.Product
) AS maxcost ON p.StandardCost = maxcost.MaxCost


--3 ????? ????????, ??????? ?? ????????? ??? ?? ????????? ?? ?????? ?????? (????? GROUP2)
SELECT c.*
FROM Client c
LEFT JOIN (
    SELECT DISTINCT ClientID
    FROM Order
    GROUP BY ClientID
    HAVING MAX(OrderDate) < DATEADD(year, -1, GETDATE())
) AS o ON c.ClientID = o.ClientID
WHERE o.ClientID IS NULL

--4 ????? ??? ??????? ?????????? ???-?? ??????? ?? ????????? 5 ???.  (????? GROUP2)
SELECT 
    v.VendorID,
    v.Name AS VendorName,
    (SELECT COUNT(*)
     FROM Order o
     JOIN Product p ON o.ProductID = p.ProductID
     WHERE p.VendorID = v.VendorID
       AND o.OrderDate >= DATEADD(year, -5, GETDATE())
    ) AS TotalOrders
FROM 
    Vendor v;

--5 ????? ?????? ????????? ??? ???????????? alex@gmail.com, ? ??????? ????? 50 ????????????? ???????????
SELECT 
    n.category
FROM 
    Users u
JOIN 
    Notifications n ON u.id = n.user_id
WHERE u.email = 'alex@gmail.com'
      AND n.is_read = 0 --????????????? ???????????
GROUP BY 
    n.category
HAVING 
    COUNT(*) > 50
