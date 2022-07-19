-- Reportes parte 1: 

-- 1. Obtener el nombre y apellido de los primeros 5 actores disponibles. Utilizar 
-- alias para mostrar los nombres de las columnas en español.

SELECT first_name AS Nombre, last_name AS Apellido
FROM actor
LIMIT 5;

-- 2. Obtener un listado que incluya nombre, apellido y correo electrónico de los 
-- clientes (customers) inactivos. Utilizar alias para mostrar los nombres de las 
-- columnas en español. 

SELECT first_name AS Nombre, last_name AS Apellido, email, active AS Activo
FROM customer
WHERE active is false;

-- 3. Obtener un listado de films incluyendo título, año y descripción de los films 
-- que tienen un rental_duration mayor a cinco. Ordenar por rental_duration de 
-- mayor a menor. Utilizar alias para mostrar los nombres de las columnas en 
-- español.

SELECT title AS TITULO, release_year AS "AÑO", description "DESCRIPCIÓN", rental_duration
FROM film
WHERE rental_duration > 5
ORDER BY rental_duration;

-- 4. Obtener un listado de alquileres (rentals) que se hicieron durante el mes de 
-- mayo de 2005, incluir en el resultado todas las columnas disponibles. 

SELECT *
FROM rental
WHERE rental_date BETWEEN "2005-05-01" AND "2005-05-31"
ORDER BY rental_date;

-- Reportes parte 2: Sumemos complejidad

-- 1. Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para
-- mostrarlo en una columna llamada “cantidad”.

SELECT COUNT(*) AS CANTIDAD
FROM rental;

-- 2. Obtener la suma TOTAL de todos los pagos (payments). Utilizar un alias para mostrarlo 
-- en una columna llamada “total”, junto a una columna con la cantidad de alquileres 
-- con el alias “Cantidad” y una columna que indique el “Importe promedio” por alquiler.

SELECT SUM(amount) AS TOTAL, COUNT(rental_id) AS CANTIDAD, AVG(amount) AS "IMPORTE PROMEDIO"
FROM payment;

-- 3. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes que
-- más dinero gastan y en cuántos alquileres lo hacen?

SELECT customer.customer_id, customer.first_name AS NOMBRE, customer.last_name AS APELLIDO,
COUNT(rental.rental_id) AS "CANTIDAD ALQUILERES",
SUM(payment.amount) AS "TOTAL GASTADO"
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY SUM(payment.amount) DESC
LIMIT 10;

-- 4. Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto total
-- para todos los clientes que hayan gastado más de 150 dólares en alquileres.

SELECT customer.customer_id, customer.first_name AS NOMBRE, customer.last_name AS APELLIDO,
COUNT(rental.rental_id) AS "CANTIDAD ALQUILERES", SUM(payment.amount) AS "TOTAL GASTADO"
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
HAVING SUM(payment.amount) > 150
ORDER BY SUM(payment.amount);

-- 5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental),
-- la cantidad de alquileres y la suma total pagada (amount de tabla payment) para el año de
-- alquiler 2005 (rental_date de tabla rental).

SELECT COUNT(rental.rental_id) AS "CANT ALQUILERES", SUM(payment.amount) AS "SUMA PAGADA",
EXTRACT(MONTH FROM rental.rental_date) AS "MES ALQUILER"
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
INNER JOIN rental ON customer.customer_id = rental.customer_id
WHERE rental.rental_date LIKE "2005%"
GROUP BY EXTRACT(MONTH FROM rental.rental_date);

-- 6. Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más alquilados?
-- (columna inventory_id en la tabla rental). Para cada una de ellas indicar la cantidad de alquileres.

SELECT inventory_id, count(*)
from rental
group by inventory_id
order by count(*) desc
Limit 5;
