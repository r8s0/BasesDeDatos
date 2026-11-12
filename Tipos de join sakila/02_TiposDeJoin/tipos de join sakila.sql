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

-- preguntas
-- a) ¿la peli 14 tiene algún rental?

SELECT *
FROM rental r
        RIGHT JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE film_id = 14;

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