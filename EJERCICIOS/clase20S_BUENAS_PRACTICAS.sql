-- Where

-- 1. Mostrar los nombre de los productos que tengan cualquier combinación de
-- ‘mountain bike’
-- Tablas: Product
-- Campos: Name

SELECT name
FROM product
WHERE name LIKE "%mountain bike%";

-- 2. Mostrar las personas cuyo nombre empiece con la letra “y”
-- Tablas: Contact
-- Campos: FirstName

SELECT FirstName
FROM contact
WHERE FirstName LIKE "Y%";

-- Order by
-- 1. Mostrar cinco productos más caros y su nombre ordenado en forma alfabética
-- Tablas: Product
-- Campos: Name, ListPrice

SELECT Name, ListPrice
FROM product
ORDER BY ListPrice DESC, Name ASC
LIMIT 5;

-- Operadores & joins
-- 1. Mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea
-- johnson
-- Tablas: Contact
-- Campos: FirstName, LastName

SELECT CONCAT(FirstName, " ", LastName) AS NOMBRE_APELLIDO
FROM contact
WHERE LastName = "johnson";

-- 2. Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo
-- precio sea mayor a 500$ de color negro
-- Tablas: Product
-- Campos: ListPrice, Color

SELECT ListPrice, Color
FROM product
WHERE (ListPrice < 150 AND Color = "red") OR (ListPrice > 500 AND Color = "black");

-- Funciones de agregación
-- 1. Mostrar la fecha más reciente de venta
-- Tablas: SalesOrderHeader
-- Campos: OrderDate

SELECT MAX(OrderDate)
FROM SalesOrderHeader;

-- 2. Mostrar el precio más barato de todas las bicicletas
-- Tablas: Product
-- Campos: ListPrice, Name

SELECT MIN(ListPrice), Name
FROM product
WHERE name LIKE "%bike%";

-- Group by

-- 1. Mostrar los productos y la cantidad total vendida de cada uno de ellos
-- Tablas: SalesOrderDetail
-- Campos: ProductID, OrderQty

SELECT ProductID, SUM(OrderQty)
FROM SalesOrderDetail
GROUP BY ProductID;

-- Having

-- 1. Mostrar la cantidad de facturas que vendieron más de 20 unidades.
-- Tablas: Sales.SalesOrderDetail
-- Campos: SalesOrderID, OrderQty

SELECT SalesOrderID, COUNT(OrderQty), SUM(OrderQty)
FROM SalesOrderDetail
HAVING SUM(OrderQty) > 20;

-- Joins
-- 1. Mostrar el código de logueo, número de territorio y sueldo básico de los
-- vendedores
-- Tablas: Employee, SalesPerson
-- Campos: LoginID, TerritoryID, Bonus, BusinessEntityID

SELECT LoginID, TerritoryID, Bonus, EmployeeID
FROM Employee
INNER JOIN SalesPerson ON Employee.EmployeeID = SalesPerson.SalesPersonID;

-- 2. Mostrar los productos que sean ruedas
-- Tablas: Product, ProductSubcategory
-- Campos: Name, ProductSubcategoryID

SELECT Product.Name, ProductSubcategory.ProductSubcategoryID
FROM Product
INNER JOIN ProductSubcategory ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
WHERE Product.Name LIKE "%wheel%";

SELECT *
FROM ProductSubcategory;

-- 3. Mostrar los nombres de los productos que no son bicicletas
-- Tablas: Product, ProductSubcategory
-- Campos: Name, ProductSubcategoryID

SELECT Product.Name, ProductSubcategory.ProductSubcategoryID
FROM product
INNER JOIN ProductSubcategory ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
WHERE Product.Name NOT LIKE "%bike%";