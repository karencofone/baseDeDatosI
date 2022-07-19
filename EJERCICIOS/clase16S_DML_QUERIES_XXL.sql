-- Reportes parte I - Repasamos INNER JOIN

-- Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
-- ● Id de la factura
-- ● fecha de la factura
-- ● nombre de la empresa de correo
-- ● nombre del cliente
-- ● categoría del producto vendido
-- ● nombre del producto
-- ● precio unitario
-- ● cantidad

SELECT facturas.FacturaID, facturas.FechaFactura, correos.Compania, clientes.Contacto,
productos.CategoriaID, categorias.CategoriaNombre, productos.ProductoNombre, facturadetalle.PrecioUnitario,
facturadetalle.Cantidad
FROM facturas
INNER JOIN correos ON facturas.EnvioVia = correos.CorreoID
INNER JOIN clientes ON facturas.ClienteID = clientes.ClienteID
INNER JOIN facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
INNER JOIN productos ON facturadetalle.ProductoID = productos.ProductoID
INNER JOIN categorias ON categorias.CategoriaID = productos.CategoriaID;

-- Reportes parte II - INNER, LEFT Y RIGHT JOIN

-- 1. Listar todas las categorías junto con información de sus productos. Incluir todas
-- las categorías aunque no tengan productos.

SELECT *
FROM categorias
LEFT JOIN productos ON categorias.CategoriaID = productos.CategoriaID;

-- 2. Listar la información de contacto de los clientes que no hayan comprado nunca
-- en emarket.

SELECT *
FROM clientes
LEFT JOIN facturas ON facturas.ClienteID = clientes.ClienteID
WHERE facturas.ClienteID is null;

-- 3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
-- la información de contacto de su proveedor. Tener en cuenta que puede haber
-- productos para los cuales no se indicó quién es el proveedor.

SELECT productos.ProductoNombre, productos.CategoriaID, categorias.CategoriaNombre,
productos.ProveedorID, proveedores.Contacto
FROM productos
INNER JOIN categorias ON categorias.CategoriaID = productos.CategoriaID
LEFT JOIN proveedores ON productos.ProveedorID = proveedores.ProveedorID;

-- 4. Para cada categoría listar el promedio del precio unitario de sus productos.

SELECT ROUND(AVG(productos.PrecioUnitario), 2) AS "$ PROMEDIO",
categorias.CategoriaID, categorias.CategoriaNombre
FROM productos
RIGHT JOIN categorias ON categorias.CategoriaID = productos.CategoriaID
GROUP BY CategoriaID
ORDER BY CategoriaID;

-- ESTE RODRI LO HIZO ASÍ, DA LO MISMO, TMB SE PODRIA UN INNER

SELECT CategoriaNombre, avg(PrecioUnitario)
FROM categorias c
LEFT JOIN productos p
ON c.CategoriaID = p.CategoriaID
GROUP BY CategoriaNombre;

-- 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
-- nunca hayan comprado en e-market.

SELECT facturas.FacturaID, clientes.ClienteID, MAX(FechaFactura) AS "ÚLTIMA FACTURA"
FROM facturas
RIGHT JOIN clientes ON facturas.ClienteID = clientes.ClienteID
GROUP BY clientes.ClienteID;

-- 6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
-- listado con todas las empresas de correo, y la cantidad de facturas
-- correspondientes. Realizar la consulta utilizando RIGHT JOIN.

SELECT  facturas.EnvioVia, correos.Compania, COUNT(facturas.FacturaID) AS "CANT FACTURAS"
FROM facturas
RIGHT JOIN correos ON facturas.EnvioVia = correos.CorreoID
GROUP BY correos.Compania;
