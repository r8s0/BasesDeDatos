use sakila;
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
GROUP BY c.customer_id
ORDER BY c.customer_id ASC;

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

SELECT city_id, city, COUNT(address_id) AS num_direcciones, MAX(address_id) AS max_identificador
FROM city
        LEFT JOIN address USING (city_id)
WHERE address_id IS NULL
GROUP BY city_id
ORDER BY city;

### 19. Películas con menos de 3 copias en tienda 1 
# Muestra el identificador y título de las películas que tienen menos de tres ejemplares en la tienda 1, 
# incluidos los que tienen cero. Añade el recuento de ejemplares y el máximo identificador de ejemplar. Ordena por recuento y título.

SELECT f.film_id,f.title,count(i.inventory_id)
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
HAVING count(i.inventory_id) < 3;

-- Le añadimos lo de la tienda 1 con (WHERE)

SELECT f.film_id,f.title,count(i.inventory_id)
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id
WHERE i.store_id = 1
GROUP BY f.film_id
HAVING count(i.inventory_id) < 3;

-- Esto es incorrecto porque falta la 14, por ejemplo.
-- La peli 14 NO TIENE COPIAS EN NINGUNA TIENDA, 
-- por tanto, no tiene copias en la tienda 1.
-- Ergo, debería salir en esta consulta.

-- SOLUCIÓN:
SELECT f.film_id,f.title,count(i.inventory_id)
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id AND i.store_id = 1
GROUP BY f.film_id
HAVING count(i.inventory_id) < 3;

-- ¿Por qué tiene que ir en el ON y no en el WHERE?  [A CONTESTAR POR EL ALUMNO]
-- Dado que en un RIGHT JOIN, el ON decide qué inventarios se emparejan con cada película (y las películas sin pareja se conservan con NULL), mientras que el WHERE decide qué filas del resultado final se quedan por lo que el NULL no lo pasa.

-- otra posible solución:
SELECT f.film_id,f.title,i.inventory_id,i.store_id
FROM inventory i RIGHT JOIN film f ON i.film_id = f.film_id
WHERE store_id = 1 OR store_id is null;
-- Aquí entra al cóctel toda la tabla film y toda la tabla inventory.
-- Esto da lugar a filas con store_id 1,2 o null. Como filtro en el where,
-- esas filas con store_id = 2 van a desaparecer. Si la peli no tenía copias
-- en la tienda 1, al desaparecer han desaparecido y el count no va a poder
-- contarlas porque no están.

SELECT f.film_id,f.title,i.inventory_id,i.store_id
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id AND store_id = 1;

-- Aquí sin embargo, entra al cóctel toda la tabla film CON UNA PARTE de la tabla inventory.
-- Esto da lugar a filas con store_id 1 o null. No puede haber filas con store_id = 2.
-- ¿Qué store_id van a tener las filas que en la query anterior tenían un store_id = 2?
-- Esas filas tendrán un NULL en store_id. Se puede comprobar con las películas 2 y 3.
-- En la consulta anterior, la peli 2 y la peli 3 no salen (porque tenían store_id=2). En esta,
-- SÍ salen la 2 y la 3 porque se les ha puesto un null en store_id.

-- CONCLUSIÓN: 
-- El ON decide qué copias de inventario se emparejan con cada película y las películas sin pareja se conservan con NULL en las columnas de inventory, manteniendose.
-- El WHERE filtra después del JOIN las filas unidas en el JOIN, y decide qué filas del resultado se quedan, por lo que resultados como NULL = 1 no es verdadero, el WHERE elimina las filas con NULL (películas sin copias en la tienda 1) y el RIGHT JOIN se comporta como un INNER JOIN.
-- Es por eso que la condición de la tienda va en el ON.

SELECT f.film_id,f.title AS película,count(i.inventory_id) AS num_ejemplares, MAX(i.inventory_id) AS max_identificador
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id AND store_id = 1
GROUP BY f.film_id
HAVING count(i.inventory_id) < 3
ORDER BY COUNT(i.inventory_id);

### 20. Películas jamás alquiladas (varios JOIN) 

# Muestra las películas que nunca se han alquilado, considerando todos sus ejemplares en las dos tiendas. Devuelve identificador, título, número de alquileres y máximo identificador de alquiler. Ordena por título.

SELECT film_id, title, COUNT(rental_id), MAX(rental_id)
FROM film
        LEFT JOIN inventory USING (film_id)
        LEFT JOIN rental USING (inventory_id)
GROUP BY film_id
HAVING COUNT(rental_id) = 0
ORDER BY title;

-- En general, si uso LEFT JOIN, siempre voy a tener que ir haciendo LEFT JOINS, es decir, el resto de los JOINS serán también LEFT JOINS.