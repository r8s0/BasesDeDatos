### 1. Idiomas y películas 

# Muestra el identificador y nombre de todos los idiomas, junto con el identificador y título de sus películas. Incluye los idiomas que no tengan películas. Ordena por idioma y título.

/* TABLAS QUE NECESITO:
language -> film
*/

-- Opción con "ON"
SELECT l.language_id, name AS idioma, title AS titulo
FROM language l
        LEFT JOIN film f ON l.language_id = f.language_id
WHERE film_id IS NULL
ORDER BY language_id, title;

-- Opción con "USING"
SELECT language_id, name AS idioma, title AS titulo
FROM language
        LEFT JOIN film USING (language_id)
WHERE film_id IS NULL
ORDER BY language_id, title;

### 2. Películas y ejemplares 

# Muestra el identificador y título de todas las películas y el identificador de cada ejemplar del inventario. Incluye las películas sin ejemplares. Ordena por título y ejemplar.

### 3. Películas y reparto 

# Muestra el identificador y título de todas las películas, junto con los identificadores de los actores que participan en ellas. Incluye las películas sin actores. Ordena por título y actor.

SELECT f.film_id, title AS titulo, actor_id
FROM film_actor
        RIGHT JOIN film f USING (film_id)
WHERE film_actor.actor_id IS NULL
ORDER BY title, actor_id;

### 4. Ciudades y direcciones 

# Muestra el identificador y nombre de todas las ciudades, junto con el identificador y texto de las direcciones registradas. Incluye ciudades sin direcciones. Ordena por ciudad y dirección.

SELECT city_id, city, address_id, address
FROM city
        LEFT JOIN address USING (city_id)
WHERE address_id IS NULL;

### 5. Ejemplares y alquileres 

# Muestra el identificador de todos los ejemplares, su película y el identificador de cada alquiler registrado. Incluye los ejemplares nunca alquilados. Ordena por identificador de ejemplar y alquiler.
 
 
 
### 6. Inventario de la tienda 1 

# Muestra todas las películas y los identificadores de los ejemplares disponibles en la tienda 1. Incluye las películas sin ejemplares en esa tienda, aunque tengan en otra. Ordena por título y ejemplar.

### 7. Alquileres de mayo de 2005 

# Muestra el identificador, nombre y apellidos de todos los clientes y los alquileres que realizaron en mayo de 2005, con su fecha. Incluye clientes sin alquileres ese mes. Ordena por cliente y fecha.

SELECT c.customer_id, CONCAT(first_name, ' ', last_name) AS cliente, COUNT(rental_id)
FROM customer c
        LEFT JOIN rental r ON c.customer_id = r.customer_id
WHERE (rental_date IS NULL) OR (YEAR(rental_date) = 2005 AND MONTH(rental_date) = 05)
GROUP BY c.customer_id;

-- QUEREMOS MOVER EL FILTRO DE SITIO

SELECT c.customer_id, CONCAT(first_name, ' ', last_name) AS cliente, COUNT(rental_id)
FROM customer c
        LEFT JOIN rental r ON (c.customer_id = r.customer_id
        AND YEAR(rental_date) = 2005
        AND MONTH(rental_date) = 05)
        -- Aquí filtramos en el ON dado que buscamos nulls y usamos LEFT JOIN.
GROUP BY c.customer_id;

-- Se puede filtrar:
	-- en el ON, meter solo la parte de la tabla que me interesa; (Útil cuando busco nulls y vaya a usar LEFT/RIGHT JOINS; para optimizar consultas)
	-- en el WHERE, despues de haber hecho el join de todas las tablas;
	-- en el HAVING, para después de agrupar.

### 8. Películas por idioma 

# Muestra todos los idiomas y las películas asociadas a cada uno, incluyendo los idiomas sin películas. Esta vez la tabla de películas debe aparecer a la izquierda del JOIN. Ordena por idioma y título.

### 9. Películas y copias 

# Muestra todas las películas y sus identificadores de inventario, incluyendo las que no tienen copias. Sitúa la tabla de inventario a la izquierda del JOIN. Ordena por película y ejemplar.

### 10. Películas y asociaciones con actores 

# Muestra todas las películas y sus identificadores de actores asociados, incluidas las que no tienen ninguno. Sitúa la tabla intermedia de actores a la izquierda. Ordena por título.

### 11. Ciudades y direcciones 

# Muestra todas las ciudades y sus direcciones, incluidas las ciudades sin direcciones. Sitúa la tabla de direcciones a la izquierda del JOIN. Ordena por ciudad y dirección.

### 12. Alquileres por ejemplar 

# Muestra cada ejemplar del inventario y los identificadores de sus alquileres, incluyendo los nunca alquilados. Sitúa rental a la izquierda del JOIN. Ordena por ejemplar y alquiler.

### 13. Ejemplares de la tienda 2 

# Muestra todas las películas y sus ejemplares de la tienda 2, incluyendo las películas que no tengan ejemplares en esa tienda. Sitúa inventory a la izquierda del JOIN. Ordena por título y ejemplar.
 
### 14. Idiomas sin películas 

# Muestra exclusivamente el identificador y nombre de los idiomas que no tienen películas asociadas. Incluye el identificador de la película en la salida para apreciar el valor nulo. Ordena por idioma.

### 15. Películas sin inventario 

# Muestra exclusivamente el identificador y título de las películas que carecen de ejemplares. Incluye también inventory_id en la salida. Utiliza 

### 16. Películas sin actores 

# Muestra exclusivamente las películas sin actores asociados. Devuelve identificador, título y el identificador del actor, y ordena por título.

### 17. Ejemplares nunca alquilados 

# Muestra exclusivamente los ejemplares que nunca se han alquilado. Devuelve el identificador del ejemplar, su película y el identificador del alquiler (nulo). Utiliza 

### 18. Ciudades sin direcciones (agrupación) 

# Muestra las ciudades que no tienen ninguna dirección registrada, junto con el número de direcciones y el máximo identificador de dirección. Ordena por ciudad.

### 19. Películas con menos de 3 copias en tienda 1 

# Muestra el identificador y título de las películas que tienen menos de tres ejemplares en la tienda 1, incluidos los que tienen cero. Añade el recuento de ejemplares y el máximo identificador de ejemplar. Ordena por recuento y título.

### 20. Películas jamás alquiladas (varios JOIN) 

# Muestra las películas que nunca se han alquilado, considerando todos sus ejemplares en las dos tiendas. Devuelve identificador, título, número de alquileres y máximo identificador de alquiler. Ordena por título.

