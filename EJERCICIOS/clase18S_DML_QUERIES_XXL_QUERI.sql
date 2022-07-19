-- Ejercicio 1

-- 1. Crear una vista para poder organizar los envíos de las facturas. Indicar número
-- de factura, fecha de la factura y fecha de envío, ambas en formato dd/mm/yyyy,
-- valor del transporte formateado con dos decimales, y la información del
-- domicilio del destino incluyendo dirección, ciudad, código postal y país, en una
-- columna llamada Destino.

CREATE VIEW facturas_detalle2 AS
SELECT FacturaID, DATE_FORMAT(FechaFactura, "%d/%m/%Y") AS FECHA_FACTURA, DATE_FORMAT(FechaEnvio, "%d/%m/%Y") AS FECHA_ENVIO,
ROUND(Transporte, 2) AS TRANSPORTE, CONCAT(DireccionEnvio, " ", CiudadEnvio, " ", CodigoPostalEnvio, " ", PaisEnvio) AS DESTINO
FROM facturas;

-- 2. Realizar una consulta con todos los correos y el detalle de las facturas que
-- usaron ese correo. Utilizar la vista creada.

SELECT facturas.EnvioVia, correos.Compania, clientes.Compania AS COMPANIA_CLIENTE, facturas_detalle2.*
FROM facturas_detalle2
INNER JOIN facturas ON facturas_detalle2.FacturaID = facturas.FacturaID
INNER JOIN correos ON facturas.EnvioVia = correos.CorreoID
INNER JOIN clientes ON facturas.ClienteID = clientes.ClienteID
ORDER BY facturas.EnvioVia;

-- (LE AGREGUÉ EL NOMBRE DEL CLIENTE PARA CADA FACTURA)

-- 3. ¿Qué dificultad o problema encontrás en esta consigna? Proponer alguna
-- alternativa o solución.

-- PROPUESTA: AGREGAR EL ENVIO VIA EN LA VISTA

CREATE VIEW facturas_detalle2_PUNTO3 AS
SELECT f.FacturaID, f.EnvioVia, correos.Compania, DATE_FORMAT(f.FechaFactura, "%d/%m/%Y") AS FECHA_FACTURA,
DATE_FORMAT(f.FechaEnvio, "%d/%m/%Y") AS FECHA_ENVIO, ROUND(f.Transporte, 2) AS TRANSPORTE,
CONCAT(f.DireccionEnvio, " ", f.CiudadEnvio, " ", f.CodigoPostalEnvio, " ", f.PaisEnvio) AS DESTINO
FROM facturas AS f
INNER JOIN correos ON f.EnvioVia = correos.CorreoID;

-- Ejercicio 2

-- 1. Crear una vista con un detalle de los productos en stock. Indicar id, nombre del
-- producto, nombre de la categoría y precio unitario.

CREATE VIEW productos_detalle2 AS
SELECT p.ProductoID, p.ProductoNombre, p.CategoriaID, c.CategoriaNombre,  p.PrecioUnitario
FROM productos AS p
INNER JOIN categorias AS c ON p.CategoriaID = c.CategoriaID;

-- 2. Escribir una consulta que liste el nombre y la categoría de todos los productos
-- vendidos. Utilizar la vista creada.

SELECT fd.FacturaID, pd2.*
FROM productos_detalle2 AS pd2
INNER JOIN facturadetalle AS fd ON pd2.ProductoID = fd.ProductoID;

-- 3. ¿Qué dificultad o problema encontrás en esta consigna? Proponer alguna
-- alternativa o solución.

CREATE VIEW productos_detalle2_PUNTO3 AS
SELECT fd.FacturaID, p.ProductoID, p.ProductoNombre, p.CategoriaID, c.CategoriaNombre,  p.PrecioUnitario
FROM productos AS p
INNER JOIN facturadetalle AS fd ON p.ProductoID = fd.ProductoID
INNER JOIN categorias AS c ON p.CategoriaID = c.CategoriaID;