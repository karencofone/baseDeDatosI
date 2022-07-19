-- 1. Listar todas las reservas de hoteles realizadas en la ciudad de Nápoles.

SELECT r.idreserva, h.ciudad
FROM hotelesxreserva AS hxr
INNER JOIN reservas AS r ON hxr.idReserva = r.idreserva
INNER JOIN hoteles AS h ON hxr.idHotel = h.idhotel
WHERE h.ciudad = "Napoles";

-- 2. Listar el número de pago (idpago), el precio, la cantidad de cuotas de todas las
-- reservas realizadas con tarjeta de crédito.

SELECT p.idPago, p.precioTotal, p.cantidadCuotas, r.idreserva, mp.nombre
FROM pagos AS p
INNER JOIN metodospago AS mp ON p.idmetodospago = mp.idmetodospago
INNER JOIN reservas AS r ON p.idpago = r.idPago
WHERE mp.nombre = "Tarjeta de Crédito";

-- 3. Listar la cantidad de reservas realizadas de acuerdo al método de pago.

SELECT mp.nombre, COUNT(r.idreserva)
FROM pagos AS p
INNER JOIN metodospago AS mp ON p.idmetodospago = mp.idmetodospago
INNER JOIN reservas AS r ON p.idpago = r.idPago
GROUP BY mp.nombre;

-- 4. Listar las reservas de los clientes cuyo pago lo hicieron a través de tarjeta de
-- crédito, se pide mostrar el nombre, apellido, país y el método de pago.

SELECT r.idreserva, c.nombres, c.apellidos, pa.nombre, mp.nombre
FROM pagos AS p
INNER JOIN metodospago AS mp ON p.idmetodospago = mp.idmetodospago
INNER JOIN reservas AS r ON p.idpago = r.idPago
INNER JOIN clientes AS c ON r.idCliente = c.idcliente
INNER JOIN paises AS pa ON c.idPais = pa.idpais;

-- 5. Listar la cantidad de reservas de hoteles por país, se necesita mostrar el nombre
-- del país y la cantidad.

SELECT COUNT(r.idreserva), pa.nombre
FROM hotelesxreserva AS hxr
INNER JOIN reservas AS r ON hxr.idReserva = r.idreserva
INNER JOIN hoteles AS h ON hxr.idHotel = h.idhotel
INNER JOIN paises AS pa ON h.idPais = pa.idpais
GROUP BY pa.nombre;

-- 6. Listar el nombre, apellido, número de pasaporte,ciudad y nombre del país de los
-- clientes de origen Peruano.

SELECT c.nombres, c.apellidos, c.numeroPasaporte, c.ciudad, pa.nombre
FROM clientes AS c
INNER JOIN paises AS pa ON c.idPais = pa.idpais
WHERE pa.nombre = "Perú";

-- 7. Listar la cantidad de reservas realizadas de acuerdo al método de pago y el
-- nombre completo del cliente.

SELECT COUNT(r.idreserva), c.nombres, c.apellidos, c.numeroPasaporte, c.ciudad, mp.nombre
FROM clientes AS c
INNER JOIN reservas AS r ON c.idcliente = r.idCliente
INNER JOIN pagos AS p ON r.idPago = p.idpago
INNER JOIN metodospago AS mp ON p.idMetodosPago = mp.idmetodospago
GROUP BY mp.nombre;

-- 8. Mostrar la cantidad de clientes por país, se necesita visualizar el nombre del
-- país y la cantidad de clientes.

SELECT COUNT(c.idcliente), pa.nombre
FROM clientes AS c
INNER JOIN paises AS pa ON c.idPais = pa.idpais
GROUP BY pa.nombre;

-- 9. Listar todas las reservas de hotel, se pide mostrar el nombre del hotel,dirección,
-- ciudad, el país, el tipo de pensión y que tengan como tipo de hospedaje 'Media
-- pensión'.

SELECT r.idreserva, h.nombre, h.direccion, h.ciudad, pa.nombre, tp.nombre
FROM hoteles AS h
INNER JOIN hotelesxreserva AS hxr ON h.idhotel = hxr.idHotel
INNER JOIN reservas AS r ON hxr.idReserva = r.idreserva
INNER JOIN tiposhospedaje AS tp ON hxr.idTiposHospedaje = tp.idtiposhospedaje
INNER JOIN paises AS pa ON h.idPais = pa.idpais
WHERE tp.nombre = "Media pensión";

-- 10. Mostrar por cada método de pago el monto total obtenido,se pide visualizar el
-- nombre del método de pago y el total.

SELECT mp.nombre, SUM(p.precioTotal)
FROM pagos AS p
INNER JOIN metodospago AS mp ON p.idMetodosPago = mp.idmetodospago
GROUP BY mp.nombre;

-- 11. Mostrar la suma de los pagos realizados en la sucursal de Mendoza, llamar al
-- resultado “TOTAL MENDOZA”.

SELECT SUM(p.precioTotal) AS "TOTAL MENDOZA", s.ciudad
FROM reservas AS r
INNER JOIN pagos AS p ON r.idPago = p.idpago
INNER JOIN sucursales AS s ON r.idSucursal = s.idSucursal
WHERE s.ciudad = "Mendoza";

-- 12. Listar todos los clientes que no han realizado reservas.

SELECT c.idcliente, r.idreserva
FROM clientes AS c
LEFT JOIN reservas AS r ON c.idcliente = r.idCliente
WHERE r.idCliente is null;

-- 13. Listar todas las reservas de vuelos realizadas donde el origen sea Chile y el
-- destino Ecuador, mostrar el id Reserva, id Vuelo, fecha de partida, fecha de
-- llegada, fecha de la reserva.

SELECT r.idreserva, v.idvuelo, v.fechaPartida, v.fechaLlegada, r.fechaRegistro
FROM vuelosxreserva AS vxr
INNER JOIN vuelos AS v ON vxr.idVuelo = v.idvuelo
INNER JOIN reservas AS r ON vxr.idReserva = r.idreserva
WHERE v.origen = "Chile" AND v.destino = "Ecuador";

-- 14. Listar el nombre y cantidad de habitaciones de aquellos hoteles que tengan de
-- 30 a 70 habitaciones pertenecientes al país Argentina.

SELECT h.nombre, h.cantidadHabitaciones, pa.nombre
FROM hoteles AS h
INNER JOIN paises AS pa ON h.idPais = pa.idpais
WHERE pa.nombre = "Argentina" AND h.cantidadHabitaciones BETWEEN 30 AND 70;

-- 15. Listar el top 10 de hoteles más utilizados y la cantidad de reservas en las que ha
-- sido reservado.

SELECT h.nombre, COUNT(r.idreserva)
FROM hotelesxreserva AS hxr
INNER JOIN hoteles AS h ON hxr.idHotel = h.idhotel
INNER JOIN reservas AS r ON hxr.idReserva = r.idreserva
GROUP BY h.nombre
ORDER BY COUNT(r.idreserva) DESC
LIMIT 10;

-- 16. Listar los clientes (nombre y apellido) y cuáles han sido los medios de pago que
-- han utilizado, esta lista deberá estar ordenada por apellidos de manera
-- ascendente.

SELECT DISTINCT c.nombres, c.apellidos, mp.nombre
FROM clientes AS c
INNER JOIN reservas AS r ON c.idcliente = r.idCliente
INNER JOIN pagos AS p ON r.idPago = p.idpago
INNER JOIN metodospago AS mp ON p.idMetodosPago = mp.idmetodospago
ORDER BY c.apellidos;

-- 17. Listar la cantidad de reservas que se realizaron para los vuelos que el origen ha
-- sido de Argentina o Colombia, en el horario de las 18hs. Mostrar la cantidad de
-- vuelos y país de origen.

SELECT COUNT(r.idreserva), v.origen, EXTRACT(HOUR FROM r.fechaRegistro)
FROM reservas AS r
INNER JOIN vuelosxreserva AS vxr ON r.idreserva = vxr.idReserva
INNER JOIN vuelos AS v ON vxr.idVuelo = v.idvuelo
WHERE v.origen = "Argentina" OR v.origen = "Colombia" AND EXTRACT(HOUR FROM r.fechaRegistro) = 18;

-- 18. Mostrar los totales de ventas de sucursales por países y ordenarlas de mayor a
-- menor.

SELECT SUM(p.precioTotal), s.idSucursal, pa.nombre
FROM pagos AS p
INNER JOIN reservas AS r ON p.idpago = r.idPago
INNER JOIN sucursales AS s ON r.idSucursal = s.idSucursal
INNER JOIN paises AS pa ON s.idPais = pa.idpais
GROUP BY s.idSucursal, s.idpais
ORDER BY SUM(p.precioTotal) DESC;

-- 19. Mostrar los países que no tienen clientes asignados ordenados por los que
-- empiezan por Z primero.

SELECT pa.nombre, c.idcliente
FROM paises AS pa
LEFT JOIN clientes AS c ON pa.idpais = c.idPais
WHERE c.idPais IS NULL;

-- 20. Generar un listado con los hoteles que tuvieron más de 2 reservas realizadas.
-- Mostrar el nombre del hotel y la cantidad.

SELECT h.nombre, COUNT(r.idreserva)
FROM hotelesxreserva AS hxr
INNER JOIN hoteles AS h ON hxr.idHotel = h.idhotel
INNER JOIN reservas AS r ON hxr.idReserva = r.idreserva
GROUP BY h.idhotel
HAVING COUNT(r.idreserva) > 2;