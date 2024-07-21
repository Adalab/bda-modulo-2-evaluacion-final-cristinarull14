USE sakila;

#1.Selecciona todos los nombres de las películas sin que aparezcan duplicados. 
##Utilizamos Distinct para obtener valores únicos.

SELECT DISTINCT title 
FROM film;

#2.Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT title 
FROM film 
WHERE rating = 'PG-13';

##Comprobamos que todas tienen ese rating obteniendo la columna rating en la tabla.
SELECT title,rating 
FROM film 
WHERE rating = 'PG-13';

#3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
##utilizamos LIKE y % para indicar que busque la palabra amazing en la descripción

SELECT title, description 
FROM film 
WHERE description LIKE '%amazing%';

#4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
##utilizamos length > para indicar que obtenga el mayor del número que indicamos.

SELECT title 
FROM film 
WHERE length > 120;

##comprobamos los resultados obteniendo la columna lenght:
SELECT title,length
FROM film 
WHERE length > 120;

#5. Recupera los nombres de todos los actores.

SELECT first_name, last_name 
FROM actor;

#6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT first_name,last_name
FROM actor
WHERE last_name LIKE "%Gibson%";

#7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
##Utilizamos between para buscar datos entre un intervalo.

SELECT first_name,last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

##Comprobamos obteniendo la columna actor_id para ver:
SELECT first_name,last_name,actor_id
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

#8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
#Utilizamos la función NOT IN para no obtener esos datos
SELECT title 
FROM film 
WHERE rating NOT IN ('R', 'PG-13');

##comprobamos con la columna visualizada:
SELECT title,rating
FROM film 
WHERE rating NOT IN ('R', 'PG-13');

#9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con
#el recuento.
##Utilizamos COUNT para hacer conteo y GROUP BY para agrupar por esa columna

SELECT rating, COUNT(*) AS total_films 
FROM film 
GROUP BY rating;

#10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y
#apellido junto con la cantidad de películas alquiladas.
#esta consulta se necesita las tablas de customer y rental. en común customer_id

SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS total_rentals
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_rentals DESC;

#11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el
#recuento de alquileres.
##se tiene que utilizar la tabla category,rental, film y film_category, inventory¿?

SELECT category, COUNT(rental....
GROUP BY
)

#12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
#clasificación junto con el promedio de duración.
##Utilizamos la funcion AVG para obtner la media

SELECT rating, AVG(length) AS average_length
FROM film
GROUP BY rating;

#13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
##Tenemos que hacer consultas en 3 tablas diferentes: actor, film_actor y film. dato común actor_id y film_id
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Indian Love';

#14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

##Comprobamos viendo la columna descripción:
SELECT title,description
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

#15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
##subconsulta

SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (
	SELECT DISTINCT actor_id 
	FROM film_actor);

#16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

##Comprobamos visualizando la columna de release_year:
SELECT title,release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

#17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
##se utiliza para la consulta la tabla de film y film_category dato común film_id

SELECT film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

##comprobamos añadiendo la categoria a la tabla:
SELECT film.title, category.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';


#18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
##se utilizan las tablas de actor y film_actor con dato común en actor_id. utilizamos having ya que se ha utilizado un group by y necesitamos un count

SELECT actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS film_count
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
HAVING COUNT(film_actor.film_id) > 10;

#19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
##Utilizamos AND para añadir otro "filtro"

SELECT title
FROM film
WHERE rating = 'R' AND length > 120;

##comprobamos añadiendo rating y categoria a la tabla:
SELECT title, rating, length
FROM film
WHERE rating = 'R' AND length > 120;


#20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
#nombre de la categoría junto con el promedio de duración.

SELECT category.name AS category, AVG(film.length) AS average_length
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
HAVING AVG(film.length) > 120;

#21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la
#cantidad de películas en las que han actuado.

SELECT actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS film_quantity
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
HAVING COUNT(film_actor.film_id) >= 5;

#22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para
#encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
##Subconsulta. se utiliza tabla de flm y consulta en inventory¿?



#23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
#Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego
#exclúyelos de la lista de actores.
##subconsulta. tabla actor con subconsuta en film_actor, film_category y category, donde el dato común es actor_id, film_id y category_id

SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (
    SELECT actor.actor_id
    FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id
    JOIN film ON film_actor.film_id = film.film_id
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    WHERE category.name = 'Horror'
);

#BONUS

#24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
#tabla film.
##se utilizan las tablas film, film_category y category con el dato en común de film_id y category_id. 

SELECT title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy' AND film.length > 180;

#comprobamos añadiendo la duración y la categoria
SELECT title, length, category.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy' AND film.length > 180;

#25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe
#mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.

SELECT first_name, last_name...