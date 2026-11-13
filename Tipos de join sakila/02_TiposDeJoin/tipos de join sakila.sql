USE sakila;

-- Saca el listado de películas que nunca han sido alquiladas

SELECT title AS pelicula
FROM film
        JOIN inventory i USING (film_id)
        LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE rental_date IS NULL
GROUP BY film_id;

-- Saca el listado de peliculas que no tienen copias físicas

SELECT f.film_id, title AS pelicula, inventory_id
FROM film f
        LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE inventory_id IS NULL
GROUP BY f.film_id, inventory_id;

-- PREGUNTAS
-- 12/11/26
-- a) ¿la peli 14 tiene algún rental?

SELECT *
FROM rental r
        LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
WHERE film_id = 14;

-- Saca el listado de los nombres de peliculas que nunca han sido alquiladas.

SELECT film_id, title AS pelicula
FROM film
        LEFT JOIN inventory USING (film_id)
        LEFT JOIN rental USING (inventory_id)
GROUP BY film_id
HAVING COUNT(rental_id) = 0;

-- 13/11/26
-- b) Obtén el listado de idiomas que no tienen ninguna película

/* TABLAS QUE NECESITO:
language -> film
*/

-- Opción con "ON"
SELECT name AS idioma
FROM language l
        LEFT JOIN film f ON l.language_id = f.language_id
WHERE film_id IS NULL;

-- Opción con "USING"
SELECT name AS idioma
FROM language 
        LEFT JOIN film USING (language_id)
WHERE film_id IS NULL;

-- c) ¿Hay algún actor que no salga en ninguna película?

/* TABLAS QUE NECESITO:
actor -> film_actor -> film
*/

-- Opción con "USING"
SELECT CONCAT(first_name, ' ', last_name) AS actor
FROM actor
        LEFT JOIN film_actor fa USING (actor_id)
WHERE fa.film_id IS NULL;

-- Opción con "ON"
SELECT CONCAT(first_name, ' ', last_name) AS actor
FROM actor a
        LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;

-- Comprobación comprobando las películas asociadas con actores (numero de actores = 200):
SELECT COUNT(DISTINCT actor_id) FROM actor INNER JOIN film_actor USING(actor_id);
-- como coinciden los actores asociados a peliculas con el numero de actores, no hay ningún actor que no tenga asociada ninguna película.

-- Respuesta: no hay algún actor que no aparezca en ninguna película.