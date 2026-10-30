use sakila;
-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.

/* TABLAS QUE NECESITO:
actor -> film_actor 
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, COUNT(film_id) AS num_peliculas
FROM actor
        JOIN film_actor USING (actor_id)
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC; -- En este caso el DISTINCT no tiene sentido dado que un mismo actor no puede aparecer dos veces diferentes en una misma película.

-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.

/* TABALS QUE NECESITO:
actor -> film_actor 
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, COUNT(DISTINCT film_id) AS num_peliculas
FROM actor
        JOIN film_actor USING (actor_id)
GROUP BY actor_id
HAVING COUNT(DISTINCT film_id) >= 20
ORDER BY COUNT(DISTINCT film_id) DESC;

-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.

/* TABLAS QUE NECESITO: 
language -> film 
*/

SELECT name, COUNT(DISTINCT film_id) AS num_peliculas
FROM language
        JOIN film USING (language_id)
GROUP BY language_id
ORDER BY COUNT(DISTINCT film_id) DESC;

-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.

/* TABLAS QUE NECESITO: 
film -> language
*/

SELECT name, ROUND(AVG(length), 2) AS duracion
FROM film
        JOIN language USING (language_id)
GROUP BY language_id
HAVING AVG(length) > 110;

-- 5:  Para cada película, muestra cuántas copias hay en el inventario.

/* TABLAS QUE NECESITO:
film -> inventory
*/

SELECT title, COUNT(DISTINCT inventory_id) AS copias_inventario
FROM film
        JOIN inventory USING (film_id)
GROUP BY film_id
ORDER BY COUNT(DISTINCT inventory_id) DESC;

-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.

/* TABLAS QUE NECESITO:
film -> inventory
*/

SELECT title, COUNT(DISTINCT inventory_id) AS copias_inventario
FROM film
        JOIN inventory USING (film_id)
GROUP BY film_id
HAVING COUNT(DISTINCT inventory_id) >= 5
ORDER BY COUNT(DISTINCT inventory_id) DESC;

-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.

/* TABLAS QUE NECESITO:
film -> inventory -> rental -> payment
*/

SELECT film_id, title, COUNT(DISTINCT rental_id) AS num_alquileres
FROM film
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
        JOIN payment USING (rental_id)
GROUP BY film_id
ORDER BY COUNT(DISTINCT rental_id) DESC;

-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.

/* TABLAS QUE NECESITO:
customer -> rental
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, COUNT(DISTINCT rental_id) AS num_alquileres
FROM customer
        JOIN rental USING (customer_id)
GROUP BY customer.customer_id
ORDER BY COUNT(DISTINCT rental_id) DESC;

-- 9:  Lista los clientes con 30 o más alquileres acumulados.

/* TABLAS QUE NECESITO: 
customer -> rental
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, COUNT(DISTINCT rental_id) AS num_alquileres
FROM customer
        JOIN rental USING (customer_id)
GROUP BY customer.customer_id
HAVING COUNT(DISTINCT rental_id) >= 30
ORDER BY COUNT(DISTINCT rental_id) DESC;

-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.

/* TABLAS QUE NECESITO: 
customer -> payment
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, SUM(amount) AS total_pagado
FROM customer
        JOIN payment USING (customer_id)
GROUP BY customer.customer_id
ORDER BY SUM(amount) DESC;

-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.

/* TABLAS QUE NECESITO: 
customer -> payment
*/

SELECT * FROM customer JOIN rental USING (customer_id) JOIN payment USING (rental_id);
SELECT CONCAT(first_name, ' ', last_name) AS nombre, SUM(amount) AS total_pagado
FROM customer
        JOIN payment USING (customer_id)
GROUP BY customer.customer_id
HAVING SUM(amount) >= 200
ORDER BY SUM(amount) DESC;

-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.

/* TABLAS QUE NECESITO:
staff -> payment
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, COUNT(DISTINCT payment_id) AS num_pagos_realizados
FROM staff
        JOIN payment USING (staff_id)
GROUP BY staff.staff_id
ORDER BY COUNT(DISTINCT payment_id) DESC;

-- 13:  Para cada empleado, muestra el importe total procesado.

/* TABLAS QUE NECESITO:
staff -> payment
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, SUM(amount) AS importe_procesado
FROM staff
        JOIN payment USING (staff_id)
GROUP BY staff.staff_id
ORDER BY SUM(amount) DESC;

-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.

/* TABLAS QUE NECESITO:
store -> inventory
*/

SELECT store_id, COUNT(DISTINCT inventory_id)
FROM store
        JOIN inventory USING (store_id)
GROUP BY store_id
ORDER BY COUNT(DISTINCT inventory_id) DESC;

-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.

/* TABLAS QUE NECEITO:
store -> customer
*/

SELECT store_id, COUNT(DISTINCT customer_id) AS num_clientes
FROM store
        JOIN customer USING (store_id)
GROUP BY store_id
ORDER BY COUNT(DISTINCT customer_id) DESC;

-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.

/* TABLAS QUE NECESITO:
store -> staff
*/

SELECT store_id, COUNT(DISTINCT staff_id) AS num_empleados
FROM store
        JOIN staff USING (store_id)
GROUP BY store_id
ORDER BY COUNT(DISTINCT staff_id) DESC;

-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).

/* TABLAS QUE NECESITO:
address -> store
*/

SELECT address AS direccion, district AS distrito, COUNT(store_id) AS num_tiendas
FROM address
        JOIN store USING (address_id)
GROUP BY address_id
ORDER BY COUNT(store_id) DESC;

-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.

/* TABLAS QUE NECESITO:
address -> staff
*/

SELECT address AS direccion, district AS distrito, COUNT(staff_id) AS empleados_residiendo
FROM address
        JOIN staff USING (address_id)
GROUP BY address_id
ORDER BY COUNT(staff_id); -- Podría poner el distinct por si habitasen en la misma dirección, pero en este caso es igual porque no se cumple.

-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.

/* TABLAS QUE NECESITO:
address -> customer
*/

SELECT address AS direccion, district AS distrito, COUNT(customer_id) AS clientes_residiendo
FROM address
        JOIN customer USING (address_id)
GROUP BY address_id
ORDER BY COUNT(customer_id) DESC; -- Podría poner el distinct por si habitasen en la misma dirección, pero en este caso es igual porque no se cumple.

-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.

/* TABLAS QUE NECESITO:
city -> address
*/

SELECT city AS ciudad, COUNT(address) AS num_direcciones
FROM city
        JOIN address USING (city_id)
GROUP BY city_id
ORDER BY COUNT(address) DESC;

-- 21:  Para cada país, cuenta cuántas ciudades existen.

/* TABLAS QUE NECESITO:
country -> city
*/

SELECT country, COUNT(city_id) AS num_ciudades
FROM country
        JOIN city USING (country_id)
GROUP BY country_id
ORDER BY COUNT(city_id) DESC;

-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.

/* TABLAS QUE NECESITO:
language -> film
*/

SELECT name AS idioma, ROUND(AVG(length), 2) AS duracion_media
FROM language
        JOIN film USING (language_id)
GROUP BY language_id
HAVING ROUND(AVG(length), 2) >= 90
    AND ROUND(AVG(length), 2) <= 120
ORDER BY ROUND(AVG(length), 2) DESC;

-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).

/* TABLAS QUE NECESITO:
film (Solo para incluír nombre de la película) -> inventory -> rental
*/

SELECT title, COUNT(rental_id) AS num_alquileres
FROM film
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
GROUP BY film_id
ORDER BY COUNT(rental_id) DESC;

-- Metí la tabla film para incluir el nombre de la película

-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).

/* TABLAS QUE NECESITO:
customer -> payment
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, COUNT(payment_id) AS pagos_realizados
FROM customer
        JOIN payment USING (customer_id)
WHERE YEAR(payment_date) = 2005
GROUP BY customer_id
ORDER BY COUNT(payment_id) DESC;

-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).

/* TABLAS QUE NECESITO:
film -> inventory
*/

SELECT title, ROUND(AVG(rental_rate), 2) AS promedio_tarifa, COUNT(inventory_id) AS copias_existentes
FROM film JOIN inventory USING (film_id)
GROUP BY film_id
ORDER BY ROUND(AVG(rental_rate), 2) DESC;

-- 26:  Para cada actor, muestra la duración media (length) de sus películas.

/* TABLAS UQE NECESITO:
actor -> film_actor -> film
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, ROUND(AVG(length), 2) AS duracion_media
FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film USING (film_id)
GROUP BY actor_id
ORDER BY ROUND(AVG(length), 2) DESC;

-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).

/* TABALS QUE NECESITO:
customer -> address -> city
*/

SELECT city, COUNT(customer_id) AS num_clientes
FROM customer
        JOIN address USING (address_id)
        JOIN city USING (city_id)
GROUP BY city_id
ORDER BY COUNT(customer_id) DESC;

-- 28:  Para cada película, cuenta cuántos actores tiene asociados.

/* TABLAS QUE NECESITO:
film_actor -> film
*/

SELECT title, COUNT(actor_id) AS num_actores
FROM film_actor
        JOIN film USING (film_id)
GROUP BY film_id
ORDER BY COUNT(actor_id) DESC;

-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).

/* TABLAS QUE NECESITO:
film_category -> film
*/

SELECT category_id, COUNT(film_id) AS peliculas
FROM film_category
        JOIN film USING (film_id)
GROUP BY category_id
ORDER BY COUNT(film_id) DESC;

-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.

/* TABLAS QUE NECESITO:
inventory -> rental
*/

SELECT store_id, COUNT(rental_id)
FROM inventory
        JOIN rental USING (inventory_id)
GROUP BY store_id
ORDER BY COUNT(rental_id) DESC;

-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.

/* TABLAS QUE NECESITO:
actor -> film_actor -> film
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, COUNT(film_id) AS peliculas
FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film USING (film_id)
GROUP BY actor_id
HAVING COUNT(film_id) > 15
ORDER BY COUNT(film_id) DESC;

-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.

/* TABLAS QUE NECESITO:
category -> film_category -> film
*/

SELECT name, COUNT(film_id) AS num_peliculas
FROM category
        JOIN film_category USING (category_id)
        JOIN film USING (film_id)
GROUP BY category_id
ORDER BY COUNT(film_id) DESC;

-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.

/* TABLAS QUE NECESITO:
film -> inventory -> rental
*/

SELECT title, COUNT(rental_id)
FROM film
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
GROUP BY film_id
ORDER BY COUNT(film_id) DESC;

-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.

/* TABLAS QUE NECESITO:
customer -> payment
*/

SELECT CONCAT(first_name, ' ', last_name) AS nombre, SUM(amount) AS importe_pagado
FROM customer
        JOIN payment USING (customer_id)
WHERE YEAR(payment_date) = 2005
GROUP BY customer_id
HAVING SUM(amount) >= 150
ORDER BY SUM(amount) DESC;

-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.

/* TABLAS QUE NECESITO:
store -> staff -> payment
*/

SELECT store_id, SUM(amount) AS importe_cobrado
FROM store
        JOIN staff USING (store_id)
        JOIN payment USING (staff_id)
GROUP BY store_id
ORDER BY SUM(amount) DESC;

-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).

/* TABLAS QUE NECESITO:
city -> address -> staff
*/

SELECT city, COUNT(staff_id) AS empleados_residiendo
FROM city
        JOIN address USING (city_id)
        JOIN staff USING (address_id)
GROUP BY city_id;

-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).

/* TABLAS QUE NECESITO:

*/
-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.

/* TABLAS QUE NECESITO:

*/
-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.

/* TABLAS QUE NECESITO:

*/
-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.

/* TABLAS QUE NECESITO:

*/
-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).

/* TABLAS QUE NECESITO:

*/
-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).

/* TABLAS QUE NECESITO:

*/
-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).

/* TABLAS QUE NECESITO:

*/
-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.
-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.
-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.
-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.
-- 48:  Para cada categoría, suma la duración total (length) de sus películas.
-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.
-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).
-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.
-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.
-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.
-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.
-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.
-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.
-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.
-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).
-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).
-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).
-- 70:  Para cada país, suma los importes pagados por sus clientes.
-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.
-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).
-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.
-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.
-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.
-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).
-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.
-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.
-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.
-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.
-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.
-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.
-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.
-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).
-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).
-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.
-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.
-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.
-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).
-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.
-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.
-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.
-- 94:  Para cada tienda, suma los importes pagados en fines de semana.
-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).
-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.
-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.
-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.
-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.
