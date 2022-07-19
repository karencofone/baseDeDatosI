-- Join

-- 1. Utilizando la base de datos de movies, queremos conocer, por un lado, los
-- títulos y el nombre del género de todas las series de la base de datos.

SELECT series.title, series.genre_id, genres.name
FROM series
INNER JOIN genres ON series.genre_id = genres.id;

-- 2. Por otro, necesitamos listar los títulos de los episodios junto con el nombre y
-- apellido de los actores que trabajan en cada uno de ellos.

SELECT episodes.title, actor_episode.id, actors.first_name, actors.last_name
FROM  actor_episode
INNER JOIN actors ON actor_episode.actor_id = actors.id
INNER JOIN episodes ON actor_episode.episode_id = episodes.id;

-- 3. Para nuestro próximo desafío, necesitamos obtener a todos los actores o
-- actrices (mostrar nombre y apellido) que han trabajado en cualquier película
-- de la saga de La Guerra de las galaxias.

SELECT movies.title , CONCAT(actors.first_name, " ", actors.last_name) AS "Nombre y Apellido"
FROM  actor_movie
INNER JOIN actors ON actor_movie.actor_id = actors.id
INNER JOIN movies ON actor_movie.movie_id = movies.id
WHERE movies.title LIKE "%guerra%galaxias%";

-- 4. Crear un listado a partir de la tabla de películas, mostrar un reporte de la
-- cantidad de películas por nombre de género.

SELECT genres.name, COUNT(movies.genre_id) AS "CANT POR GÉNERO", movies.genre_id
FROM movies
INNER JOIN genres ON movies.genre_id = genres.id
GROUP BY genres.name;
