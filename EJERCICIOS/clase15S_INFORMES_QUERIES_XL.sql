-- Consultas SELECT y GROUP BY

-- Realizar los siguientes informes:

-- 1. Listar las canciones cuya duración sea mayor a 2 minutos.

SELECT *
FROM canciones
WHERE milisegundos > 120000;

-- 2. Listar las canciones cuyo nombre comience con una vocal.

SELECT *
FROM canciones
WHERE nombre LIKE "a%" OR nombre LIKE "e%" OR nombre LIKE "i%" OR nombre LIKE "o%" OR nombre LIKE "u%";

-- 3. Listar las canciones ordenadas por compositor en forma descendente.
-- Luego, por nombre en forma ascendente. Incluir únicamente aquellas
-- canciones que tengan compositor.

SELECT *
FROM canciones
WHERE compositor is not null OR compositor != ""
ORDER BY compositor DESC, nombre ASC;

-- 4. a) Listar la cantidad de canciones de cada compositor.

SELECT compositor, COUNT(*) AS CANTIDAD
FROM canciones
GROUP BY compositor;

-- 4. b) Modificar la consulta para incluir únicamente los compositores que
-- tengan más de 10 canciones.

SELECT compositor, COUNT(*) AS CANTIDAD
FROM canciones
GROUP BY compositor
HAVING CANTIDAD > 10;

-- 5. a) Listar el total facturado agrupado por ciudad.

SELECT ciudad_de_facturacion, SUM(total) AS "SUMA TOTAL"
FROM facturas
GROUP BY ciudad_de_facturacion;

-- 5. b) Modificar el listado del punto (a) mostrando únicamente las ciudades
-- de Canadá.

SELECT ciudad_de_facturacion, pais_de_facturacion, SUM(total) AS "SUMA TOTAL"
FROM facturas
WHERE pais_de_facturacion = "Canadá"
GROUP BY ciudad_de_facturacion
ORDER BY ciudad_de_facturacion;

-- 5. c) Modificar el listado del punto (a) mostrando únicamente las ciudades
-- con una facturación mayor a 38.

SELECT ciudad_de_facturacion, SUM(total) AS "SUMA TOTAL"
FROM facturas
GROUP BY ciudad_de_facturacion
HAVING SUM(total) > 38
ORDER BY ciudad_de_facturacion;

-- 5. d) Modificar el listado del punto (a) agrupando la facturación por país, y
-- luego por ciudad.

SELECT pais_de_facturacion, ciudad_de_facturacion, SUM(total) AS "SUMA TOTAL"
FROM facturas
GROUP BY pais_de_facturacion, ciudad_de_facturacion
ORDER BY pais_de_facturacion, ciudad_de_facturacion;

-- 6. a) Listar la duración mínima, máxima y promedio de las canciones.

SELECT ROUND(MAX(milisegundos), 2) AS "MAX EN MINUTOS", ROUND(MIN(milisegundos), 2) AS "MIN EN MINUTOS",
ROUND(AVG(milisegundos), 2) AS "PROM EN MINUTOS"
FROM canciones;

-- 6. b) Modificar el punto (a) mostrando la información agrupada por género.

SELECT canciones.id_genero, generos.nombre, ROUND(MAX(milisegundos), 2) AS "MAX EN MINUTOS", ROUND(MIN(milisegundos), 2) AS "MIN EN MINUTOS",
ROUND(AVG(milisegundos), 2) AS "PROM EN MINUTOS" 
FROM canciones
INNER JOIN generos ON canciones.id_genero = generos.id
GROUP BY id_genero;