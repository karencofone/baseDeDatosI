-- Reportes - JOINS
-- Consignas:

-- 1. Obtener los artistas que han actuado en una o más películas.

SELECT pelicula.id AS "PELI ID", pelicula.titulo, artista.id AS "ARTISTA ID",
CONCAT(artista.nombre, " ", artista.apellido) AS "NOMBRE Y APELLIDO"
FROM artista_x_pelicula
INNER JOIN artista ON artista_x_pelicula.artista_id = artista.id
INNER JOIN pelicula ON artista_x_pelicula.pelicula_id = pelicula.id;

-- 2. Obtener las películas donde han participado más de un artista según nuestra
-- base de datos.

SELECT pelicula.titulo, COUNT(pelicula.id) AS "CONTADOR PELIS"
FROM artista_x_pelicula
INNER JOIN artista ON artista_x_pelicula.artista_id = artista.id
INNER JOIN pelicula ON artista_x_pelicula.pelicula_id = pelicula.id
GROUP BY pelicula.id
HAVING COUNT(pelicula.id) > 1;

-- 3. Obtener aquellos artistas que han actuado en alguna película, incluso
-- aquellos que aún no lo han hecho, según nuestra base de datos.

SELECT pelicula.id AS "PELI ID", pelicula.titulo, artista.id AS "ARTISTA ID",
CONCAT(artista.nombre, " ", artista.apellido) AS "NOMBRE Y APELLIDO"
FROM artista_x_pelicula
INNER JOIN pelicula ON artista_x_pelicula.pelicula_id = pelicula.id
RIGHT JOIN artista ON artista_x_pelicula.artista_id = artista.id;

-- 4. Obtener las películas que no se le han asignado artistas en nuestra base de
-- datos.

SELECT pelicula.id AS "PELI ID", pelicula.titulo, artista.id AS "ARTISTA ID",
CONCAT(artista.nombre, " ", artista.apellido) AS "NOMBRE Y APELLIDO"
FROM artista_x_pelicula
INNER JOIN artista ON artista_x_pelicula.artista_id = artista.id
RIGHT JOIN pelicula ON artista_x_pelicula.pelicula_id = pelicula.id
WHERE artista.id is null;

-- 5. Obtener aquellos artistas que no han actuado en alguna película, según
-- nuestra base de datos.

SELECT pelicula.id AS "PELI ID", pelicula.titulo, artista.id AS "ARTISTA ID",
CONCAT(artista.nombre, " ", artista.apellido) AS "NOMBRE Y APELLIDO"
FROM artista_x_pelicula
INNER JOIN pelicula ON artista_x_pelicula.pelicula_id = pelicula.id
RIGHT JOIN artista ON artista_x_pelicula.artista_id = artista.id
WHERE pelicula.id is null;

-- 6. Obtener aquellos artistas que han actuado en dos o más películas según
-- nuestra base de datos.

SELECT pelicula.titulo, COUNT(artista.id) AS "CONTADOR ARTISTAS",
CONCAT(artista.nombre, " ", artista.apellido) AS "NOMBRE Y APELLIDO"
FROM artista_x_pelicula
INNER JOIN artista ON artista_x_pelicula.artista_id = artista.id
INNER JOIN pelicula ON artista_x_pelicula.pelicula_id = pelicula.id
GROUP BY artista.id
HAVING COUNT(artista.id) >= 2;

-- 7. Obtener aquellas películas que tengan asignado uno o más artistas, incluso
-- aquellas que aún no le han asignado un artista en nuestra base de datos.

SELECT pelicula.id AS "PELI ID", pelicula.titulo, artista.id AS "ARTISTA ID",
CONCAT(artista.nombre, " ", artista.apellido) AS "NOMBRE Y APELLIDO"
FROM artista_x_pelicula
INNER JOIN artista ON artista_x_pelicula.artista_id = artista.id 
RIGHT JOIN pelicula ON artista_x_pelicula.pelicula_id = pelicula.id;