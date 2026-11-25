use sakila;

-- CONSULTA 1
/* address */
SELECT district AS distrito, COUNT(address_id)
FROM address
GROUP BY district
ORDER BY COUNT(address_id) DESC , district ASC;

-- CONSULTA 2
/* actor -> film_actor -> film */
SELECT first_name AS nombre, last_name AS apellido, title AS pelicula, length AS duracion_minutos
FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film USING (film_id)
WHERE length >= 150
GROUP BY actor_id , film_id
ORDER BY title ASC , last_name DESC; 

-- CONSULTA 3
/* country -> city -> address*/
SELECT country AS pais, COUNT(DISTINCT city_id) AS ciudades_distintas, COUNT(address_id) AS direcciones_totales
FROM country
        JOIN city USING (country_id)
        JOIN address USING (city_id)
WHERE country LIKE "%India%" OR country LIKE "%China%"
GROUP BY country_id
ORDER BY COUNT(address_id) DESC;

-- CONSULTA 4
/* film -> film_actor */
SELECT title AS titulo, COUNT(actor_id) AS num_actores
FROM film
        JOIN film_actor USING (film_id)
WHERE rating = 'PG-13'
GROUP BY film_id
HAVING COUNT(actor_id) >= 6
ORDER BY COUNT(actor_id) DESC , title ASC;

-- CONSULTA 5
/* rental -> customer */
SELECT DAYOFWEEK(rental_date) AS dia_semana, COUNT(rental_id) AS num_alquileres, COUNT(return_date) AS num_alquileres_devolucion
FROM rental
        JOIN customer USING (customer_id)
WHERE first_name LIKE 'S%'
GROUP BY rental_id
ORDER BY DAYOFWEEK(rental_date) ASC;
