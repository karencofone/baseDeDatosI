-- WHERE
-- 1. Mostrar las personas que la segunda letra de su apellido es una s.
-- Tablas: person
-- Campos: LastName

SELECT LastName
FROM person
WHERE LastName LIKE "_s%";

-- 2. Mostrar el nombre concatenado con el apellido de las personas cuyo apellido tenga
-- terminación (ez).
-- Tablas: person

SELECT CONCAT(FirstName, " ", MiddleName, " ", LastName) AS NOMBRE
FROM person
WHERE LastName LIKE "%ez";

-- 3. Mostrar los nombres de los productos que terminan en un número.
-- Tablas: product
-- Campos: Name

SELECT Name
FROM product
WHERE Name LIKE "%0" OR Name LIKE "%1" OR Name LIKE "%2" OR Name LIKE "%3"
OR Name LIKE "%4" OR Name LIKE "%5" OR Name LIKE "%6" OR Name LIKE "%7"
OR Name LIKE "%8" OR Name LIKE "%9";

-- 4. Mostrar las personas cuyo nombre tenga una "c" como primer carácter, cualquier otro como
-- segundo carácter, ni d, e, f, g como tercer carácter, cualquiera entre j y r o entre s y w como
-- cuarto carácter y el resto sin restricciones.
-- Tablas: person
-- Campos: FirstName

SELECT FirstName
FROM person
WHERE FirtsName LIKE "c%"
AND FirstName NOT LIKE "__d%" AND FirstName NOT LIKE "__e%" 
AND FirstName NOT LIKE "__f%" AND FirstName NOT LIKE "__g%"
AND FirstName LIKE "___j%" OR FirstName LIKE "___k%" OR FirstName LIKE "___l%"
OR FirstName LIKE "___m%" OR FirstName LIKE "___n%" OR FirstName LIKE "___o%"
OR FirstName LIKE "___p%" OR FirstName LIKE "___q%" OR FirstName LIKE "___r%"
OR FirstName LIKE "___s%"