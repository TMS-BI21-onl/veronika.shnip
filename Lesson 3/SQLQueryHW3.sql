/*a)	Вывести список цен в виде текстового комментария, основанного на диапазоне цен для продукта:
a.	StandardCost равен 0 или не определен – ‘Not for sale’  
b.	StandardCost больше 0, но меньше 100 – ‘<$100’ 
c.	StandardCost больше или равно 100, но меньше 500 - ‘ <$500' 
d.	Иначе - ‘ >= $500'
Вывести имя продукта и новое поле PriceRange.*/

SELECT Name,
CASE 
    WHEN StandardCost=0 OR StandardCost IS NULL THEN 'Not for sale'
    WHEN StandardCost >0 AND StandardCost <100 THEN '<$100'
	WHEN StandardCost>=100 AND StandardCost <500 THEN '<$500'
	ELSE '>=$500'
END AS PriceRange
FROM Production.Product

/* b)Найти ProductID, BusinessEntityID и имя поставщика продукции из Purchasing.ProductVendor и Purchasing.Vendor, 
     где StandardPrice больше $10. Также в имени вендора должна присутствовать (вне зависимости от положения) буква X 
	 или имя должно начинаться на букву N.*/

SELECT ProductVendor.ProductID, ProductVendor.BusinessEntityID, Vendor.Name AS VendorName
FROM Purchasing.ProductVendor
INNER JOIN Purchasing.Vendor
ON ProductVendor.BusinessEntityID=Vendor.BusinessEntityID
WHERE StandardPrice>10 AND (Name LIKE '%X%' OR Name LIKE 'N%')

/*c)Найти имена всех вендоров, продукция которых не продавалась за всё время. 
    Необходимо использовать следующую схему соединения таблиц (LEFT JOIN - на картинке) Purchasing.ProductVendor и Purchasing.Vendor:..*/

	SELECT Vendor.Name AS Vendor_Name
	FROM Purchasing.Vendor 
	LEFT JOIN Purchasing.ProductVendor
	ON Vendor.BusinessEntityID=ProductVendor.BusinessEntityID
	WHERE ProductVendor.BusinessEntityID IS NULL

/*3.	Решите на базе данных AdventureWorks2017 следующие задачи. 
a)	Выведите названия продуктов и их цену, модель которых начинается на ‘LL’. Таблицы [Production].[ProductModel] и [Production].[Product].*/
    
	SELECT Product.Name, Product.ListPrice
	FROM Production.Product
	INNER JOIN Production.ProductModel
	ON Product.ProductModelID=ProductModel.ProductModelID
	WHERE ProductModel.Name LIKE 'LL%'

/*b)Выведите имена всех вендоров [Purchasing].[Vendor] и имена магазинов [Sales].[Store] 
    одним списком в отсортированном порядке по алфавиту и без дубликатов.*/
	SELECT Name
	FROM (SELECT Name
	      FROM Purchasing.Vendor
	      UNION
	      SELECT Name
	      FROM Sales.Store) AS Names
	ORDER BY Name
/*c)	Найдите имена продуктов, на которых действовало больше, чем 1 специальное предложение. Таблицы [Sales].[SpecialOffer], 
        [Sales].[SpecialOfferProduct], [Production].[Product].*/
        
		SELECT Product.Name AS ProductNames
		FROM Production.Product
		INNER JOIN Sales.SpecialOfferProduct
		ON Product.ProductID=SpecialOfferProduct.ProductID
		INNER JOIN Sales.SpecialOffer
		ON SpecialOffer.SpecialOfferID=SpecialOfferProduct.SpecialOfferID
        GROUP BY Product.Name 
        HAVING COUNT(SpecialOffer.SpecialOfferID) > 1 



