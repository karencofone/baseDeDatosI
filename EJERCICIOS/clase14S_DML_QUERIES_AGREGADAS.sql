-- Consignas
-- Clientes

-- 1) ¿Cuántos clientes existen?

SELECT COUNT(*)
FROM clientes;

-- 2) ¿Cuántos clientes hay por ciudad?

SELECT ciudad, COUNT(*)
FROM clientes
GROUP BY ciudad;

-- Facturas

-- 1) ¿Cuál es el total de transporte?

SELECT ROUND(SUM(transporte))
FROM facturas;

-- 2) ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?

SELECT ROUND(SUM(transporte))
FROM facturas
GROUP BY EnvioVia;

-- 3) Calcular la cantidad de facturas por cliente. Ordenar descendentemente por
-- cantidad de facturas.

SELECT ClienteID, COUNT(*) AS "Cantidad de facturas"
FROM facturas
GROUP BY ClienteID
ORDER BY COUNT(*) DESC;

-- 4) Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.

SELECT ClienteID, COUNT(*) AS "Cantidad de facturas"
FROM facturas
GROUP BY ClienteID
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 5) ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?

SELECT ClienteID, COUNT(*) AS "Cantidad de facturas", PaisEnvio
FROM facturas
GROUP BY PaisEnvio
ORDER BY COUNT(*)
LIMIT 1;

-- 6) Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado
-- realizó más operaciones de ventas?

SELECT ClienteID, COUNT(*) AS "Cantidad de facturas", EmpleadoID
FROM facturas
GROUP BY EmpleadoID
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Factura detalle

-- 1) ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?

SELECT facturadetalle.ProductoID, productos.ProductoNombre, COUNT(facturadetalle.ProductoID) AS "Cantidad"
FROM facturadetalle
INNER JOIN productos ON facturadetalle.ProductoID = productos.ProductoID
GROUP BY facturadetalle.ProductoID
ORDER BY COUNT(facturadetalle.ProductoID) DESC
LIMIT 1;

-- 2) ¿Cuál es el total facturado? Considerar que el total facturado es la suma de
-- cantidad por precio unitario.

SELECT SUM(Cantidad*PrecioUnitario) AS TOTAL
FROM facturadetalle;

-- 3) ¿Cuál es el total facturado para los productos ID entre 30 y 50?

SELECT ROUND(SUM(Cantidad*PrecioUnitario), 2) AS TOTAL
FROM facturadetalle
WHERE ProductoID BETWEEN 30 AND 50;

-- 4) ¿Cuál es el precio unitario promedio de cada producto?

SELECT ProductoID, ROUND(AVG(PrecioUnitario), 2) AS PROMEDIO
FROM facturadetalle
GROUP BY ProductoID;

-- 5) ¿Cuál es el precio unitario máximo?

SELECT ProductoID, ROUND(MAX(PrecioUnitario), 2) AS "PRECIO UNITARIO MAX"
FROM facturadetalle;

-- Consultas queries XL parte II - JOIN

-- 1) Generar un listado de todas las facturas del empleado 'Buchanan'.

SELECT *
FROM facturas
INNER JOIN empleados ON facturas.EmpleadoID = empleados.EmpleadoID
WHERE empleados.Apellido = 'Buchanan';

-- 2) Generar un listado con todos los campos de las facturas del correo 'Speedy
-- Express'.

SELECT *
FROM facturas
INNER JOIN correos ON facturas.EnvioVia = correos.CorreoID
WHERE correos.compania = "Speedy Express";

-- 3) Generar un listado de todas las facturas con el nombre y apellido de los
-- empleados.

SELECT *, empleados.nombre, empleados.apellido
FROM facturas
INNER JOIN empleados ON facturas.EmpleadoID = empleados.EmpleadoID;

-- 4) Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío
-- “USA”.

SELECT clientes.titulo, facturas.PaisEnvio, facturas.*
FROM facturas
INNER JOIN clientes ON facturas.ClienteID = clientes.ClienteID
WHERE clientes.titulo = "Owner" AND facturas.PaisEnvio = "USA";

-- 5) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
-- “Leverling” o que incluyan el producto id = “42”.

SELECT empleados.Apellido, facturadetalle.ProductoID, facturas.*
FROM facturas
INNER JOIN empleados ON facturas.EmpleadoID = empleados.EmpleadoID
INNER JOIN facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
WHERE empleados.Apellido = "Leverling" OR facturadetalle.ProductoID = 42;

-- 6) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
-- “Leverling” y que incluya los producto id = “80” o ”42”.

SELECT empleados.Apellido, facturadetalle.ProductoID, facturas.*
FROM facturas
INNER JOIN empleados ON facturas.EmpleadoID = empleados.EmpleadoID
INNER JOIN facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
WHERE empleados.Apellido = "Leverling" OR facturadetalle.ProductoID = 42 OR facturadetalle.ProductoID = 80;

-- 7) Generar un listado con los cinco mejores clientes, según sus importes de
-- compras total (PrecioUnitario * Cantidad).

SELECT ROUND(SUM((facturadetalle.PrecioUnitario * facturadetalle.Cantidad)),2) AS TOTAL, clientes.ClienteID
FROM facturas
INNER JOIN clientes ON facturas.ClienteID = clientes.ClienteID
INNER JOIN facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
GROUP BY clientes.ClienteID
ORDER BY TOTAL DESC
LIMIT 5;

-- 8) Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
-- fecha de factura, país de envío, Total, ordenado de manera descendente por
-- fecha de factura y limitado a 10 filas.

SELECT clientes.ClienteID, clientes.Contacto, facturas.FechaFactura, facturas.PaisEnvio,
ROUND(SUM((facturadetalle.PrecioUnitario * facturadetalle.Cantidad)),2) AS TOTAL
FROM facturas
INNER JOIN clientes ON facturas.ClienteID = clientes.ClienteID
INNER JOIN facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
GROUP BY ClienteID
ORDER BY facturas.FechaFactura DESC
LIMIT 10;
