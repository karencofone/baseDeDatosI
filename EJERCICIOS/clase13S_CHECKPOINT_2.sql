-- CHECKPOINT 2

-- 1. Listar todos los clientes que su apellido empiece por A, ordenados por apellido
-- de manera ascendente.

SELECT *
FROM clientes
WHERE apellidos LIKE "a%"
ORDER BY apellidos;

-- 10

-- 2. Listar nombre, apellido,dirección de aquellos clientes que en su dirección
-- contengan la palabra “martin”.

SELECT nombres, apellidos, direccion
FROM clientes
WHERE direccion LIKE "%martin%";

-- 5

-- 3. Listar todos los hoteles que tengan de 30 a 60 habitaciones.

SELECT *
FROM hoteles
WHERE cantidadHabitaciones BETWEEN 30 AND 60;

-- 13

-- 4. Mostrar cuál ha sido el mayor importe facturado y llamarlo “Precio Mayor”,
-- también mostrar cuál es el total facturado y llamarlo “TOTAL”.

SELECT MAX(precioTotal) AS "Precio Mayor", SUM(precioTotal) AS "TOTAL"
FROM pagos;

-- 1

-- 5. Listar las reservas que fueron realizadas el día 16/01/2022 entre las 15hs y las
-- 21hs pertenecientes a la sucursal número 5.

SELECT *
FROM reservas
WHERE (fechaRegistro BETWEEN "2022-01-16 15:00;00" AND "2022-01-16 21:00:00") AND idSucursal = 5;

-- 3

-- 6. Mostrar el top 3 de reservas con mayor cantidad de vuelos.

SELECT idReserva, COUNT(*)
FROM vuelosxreserva
GROUP BY idReserva
ORDER BY COUNT(*) DESC
LIMIT 3;

SELECT * 
FROM vuelosxreserva;

-- 3

-- 7. Listar los 10 pagos de menor precio.

SELECT *
FROM pagos
ORDER BY precioTotal
LIMIT 10;

-- 10

-- 8. Listar todos los países ordenados alfabéticamente y con su nombre en
-- mayúsculas.

SELECT UPPER(nombre)
FROM paises
ORDER BY nombre;

-- 30

-- 9. Mostrar todos las reservas de vuelos que sean de clase turista y el id de vuelo
-- sea 11 o 13.

SELECT *
FROM vuelosxreserva
WHERE idCategoriasVuelos = 2 AND idVuelo BETWEEN 11 AND 13;

-- 8

SELECT *
FROM vuelosxreserva
INNER JOIN categoriasvuelos ON vuelosxreserva.idCategoriasVuelos = categoriasvuelos.idcategoriasvuelos AND nombre = "turista";

-- 10. Listar los usuarios que hayan realizado 2 reservas.

SELECT idCliente, COUNT(*)
FROM reservas
GROUP BY idCliente
HAVING COUNT(*) = 2;

-- 9

-- 11. Mostrar todos los vuelos que tengan como origen Italia o destino Jamaica.

SELECT *
FROM vuelos
WHERE origen = "Italia" OR destino = "Jamaica";

-- 8

-- 12. Mostrar todos los vuelos que tengan como destino Cuba y la cantidad de
-- pasajeros de primera clase sea menor o igual a 15 personas.

SELECT *
FROM vuelos
WHERE destino = "Cuba" AND cantidadPrimeraClase <= 15;

-- 2

-- 13. Se desea conocer cuál es la cantidad de vuelos que tienen como origen México.

SELECT COUNT(*)
FROM vuelos
WHERE origen = "Mexico";

-- 1

-- 14. Se desea conocer cuál es la cantidad de reservas realizadas en la sucursal de
-- Mendoza por el cliente cuyo pasaporte es EC158846.

SELECT COUNT(*)
FROM reservas
INNER JOIN clientes ON reservas.idcliente = clientes.idcliente
WHERE clientes.numeroPasaporte = "EC158846";

-- 1

-- 15. Cual es el promedio de pasajeros de clase turista que tengan como destino
-- Jamaica.

SELECT FORMAT(AVG(cantidadTurista), 0), destino 
FROM vuelos
WHERE destino = "Jamaica";

-- 1

-- 16. Cual es el monto total de los pagos realizados en efectivo.(campo:preciototal ).

SELECT SUM(precioTotal)
FROM pagos
INNER JOIN metodospago ON pagos.idMetodosPago = metodospago.idmetodospago
WHERE metodospago.nombre = "Efectivo";

-- 1

-- 17. Mostrar el tercer importe de pagos realizado con menor valor.

SELECT *
FROM pagos
ORDER BY precioTotal
LIMIT 1
OFFSET 2;

-- 1

-- 18. Se desea conocer la cantidad de reservas realizadas en Chile más
-- específicamente en el 'Santiago Hotel' .

SELECT COUNT(*)
FROM hotelesxreserva
INNER JOIN reservas ON hotelesxreserva.idReserva = reservas.idreserva
INNER JOIN hoteles ON hotelesxreserva.idHotel = hoteles.idhotel
WHERE hoteles.nombre = 'Santiago Hotel';

-- 1

-- 19. Agregar al cliente Solari Carlos cuyo pasaporte es AR221422 , domiciliado en
-- calle Av.Libertad 451 de la ciudad de Córdoba-Argentina, teléfono móvil
-- +542645667714.

INSERT INTO clientes(nombres, apellidos, numeroPasaporte, direccion, ciudad, telefono, idPais)
VALUES ("Carlos","Solari","AR221422","Av.Libertad 451","Córdoba","+542645667714",
(SELECT idPais FROM paises WHERE nombre = "Argentina"));

-- 20. Modificar el tipo de hospedaje de 'Pensión Completa' a 'Pensión Premium'

SELECT *
FROM tiposhospedaje;

UPDATE tiposhospedaje
SET nombre = "Pensión Premium"
WHERE nombre = "Pensión Completa";

