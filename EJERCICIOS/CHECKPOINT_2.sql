-- 1. Listar todos los clientes que su apellido empiece por A, ordenados por apellido
-- de manera ascendente.

SELECT apellidos, COUNT(apellidos)
FROM clientes
WHERE apellidos LIKE "a%";
-- 10

-- 2. Listar nombre, apellido,dirección de aquellos clientes que en su dirección
-- contengan la palabra “martin”.

SELECT nombres, apellidos, direccion, COUNT(apellidos)
FROM clientes
WHERE direccion LIKE "%martin%";
-- 5

-- 3. Listar todos los hoteles que tengan de 30 a 60 habitaciones.

SELECT *, COUNT(*)
FROM hoteles
WHERE cantidadHabitaciones BETWEEN 30 AND 60;
-- 13

-- 4. Mostrar cuál ha sido el mayor importe facturado y llamarlo “Precio Mayor”,
-- también mostrar cuál es el total facturado y llamarlo “TOTAL”.

SELECT precioTotal AS "Precio Mayor", SUM(precioTotal) AS TOTAL, COUNT(*)
FROM pagos
LIMIT 1;
-- 62

-- 5. Listar las reservas que fueron realizadas el día 16/01/2022 entre las 15hs y las
-- 21hs pertenecientes a la sucursal número 5.

SELECT fechaRegistro, idSucursal, codigoReserva, COUNT(*)
FROM reservas
WHERE idSucursal = 5 AND fechaRegistro BETWEEN "2022-01-16 15:00:00" AND "2022-01-16 21:00:00";
-- 3

-- 6. Mostrar el top 3 de reservas con mayor cantidad de vuelos.
-- PREGUNTAR
SELECT idVuelo, idReserva
FROM vuelosxreserva
GROUP BY idReserva
LIMIT 3;
-- 3

-- 7. Listar los 10 pagos de menor precio.
SELECT idpago, precioTotal
FROM pagos
GROUP BY precioTotal
HAVING COUNT(precioTotal)
ORDER BY precioTotal 
LIMIT 10;
-- 10

-- 8. Listar todos los países ordenados alfabéticamente y con su nombre en
-- mayúsculas.
SELECT UPPER(nombre) AS "Nombre", COUNT(*)
FROM paises
ORDER BY nombre;
-- 30

-- 9. Mostrar todos las reservas de vuelos que sean de clase turista y el id de vuelo
-- sea 11 o 13.
SELECT *, COUNT(*)
FROM vuelosxreserva
WHERE idCategoriasVuelos = 2 AND idVuelo = 11 OR idVuelo = 13;
-- 8

-- 10. Listar los usuarios que hayan realizado 2 reservas.
SELECT idCliente, codigoReserva, COUNT(*)
FROM reservas
GROUP BY idCliente
HAVING COUNT(*) = 2;
-- NO SABEMOS CÓMO USAR COUNT PARA CONTAR LA CANTIDAD DE CLIENTES

-- 11. Mostrar todos los vuelos que tengan como origen Italia o destino Jamaica.
SELECT idVuelo, nroVuelo, origen, destino, COUNT(*)
FROM vuelos
WHERE origen LIKE "Italia" OR destino LIKE "JAMAICA";
-- 8

-- 12. Mostrar todos los vuelos que tengan como destino Cuba y la cantidad de
-- pasajeros de primera clase sea menor o igual a 15 personas.
SELECT idVuelo, nroVuelo, destino, cantidadPrimeraClase, COUNT(*)
FROM vuelos
WHERE destino LIKE "Cuba" AND cantidadPrimeraClase <= 15;
-- 2

-- 13. Se desea conocer cuál es la cantidad de vuelos que tienen como origen México.
SELECT idVuelo, nroVuelo, origen, COUNT(*)
FROM vuelos
WHERE origen LIKE "Mexico";
-- 5