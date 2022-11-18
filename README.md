# HEIG_BDR_Labo3
```sql
SET search_path TO pagila;
-- Thomas Paire, Tim Impair
-- Exercice 1
SELECT customer_id, last_name, email
FROM customer c
         INNER JOIN store s
                    on c.store_id = s.store_id
WHERE c.first_name = 'PHYLLIS'
ORDER BY customer_id DESC;

-- Exercice 2
SELECT title, release_year
FROM film f
WHERE f.rating = 'R'
  AND f.length < 60
  AND f.replacement_cost = 12.99
ORDER BY f.title;

-- Exercice 3
SELECT country, city, postal_code
FROM address a
         INNER JOIN city c
                    on a.city_id = c.city_id
         INNER JOIN country co
                    on c.country_id = co.country_id

WHERE co.country = 'France'
  OR (co.country_id >= 63
  AND co.country_id <= 67)
ORDER BY co.country, c.city, a.postal_code;

-- Exercice 4
SELECT customer_id, first_name, last_name
FROM customer c
        INNER JOIN address a
            on c.address_id = a.address_id
        INNER JOIN store s
            on c.store_id = s.store_id
WHERE city_id = 171
  AND c.store_id = 1
  AND c.active
ORDER BY first_name;

-- Exercice 5
SELECT c1.first_name, c1.last_name, c2.first_name, c2.last_name, i.film_id
FROM film f
         INNER JOIN inventory i on f.film_id = i.film_id
         INNER JOIN rental r1 on i.inventory_id = r1.inventory_id
         INNER JOIN rental r2 on i.inventory_id = r2.inventory_id AND r1.customer_id <> r2.customer_id
         INNER JOIN customer c1 on r1.customer_id = c1.customer_id
         INNER JOIN customer c2 on r2.customer_id = c2.customer_id;

-- Exercice 6
SELECT last_name, first_name
FROM actor
WHERE actor_id IN(
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film
        WHERE film_id IN (
            SELECT film_id
            FROM film_category
            WHERE category_id IN (
                SELECT category_id
                FROM category
                WHERE name = 'Horror'
            )
        )
    )
)
AND (substr(first_name, 1, 1) = 'K'
OR (substr(last_name, 1, 1)) = 'D');


-- Exercice 8 a)
SELECT DISTINCT c.customer_id, last_name, first_name
FROM customer c
    INNER JOIN address a on a.address_id = c.address_id
    INNER JOIN city ci on a.city_id = ci.city_id
    INNER JOIN country co on ci.country_id = co.country_id
WHERE co.country = 'Spain'
AND EXISTS(SELECT customer_id FROM rental where return_date IS NULL);

-- Exercice 8 b)
SELECT DISTINCT c.customer_id, last_name, first_name
FROM customer c
    INNER JOIN address a on a.address_id = c.address_id
    INNER JOIN city ci on a.city_id = ci.city_id
    INNER JOIN country co on ci.country_id = co.country_id
WHERE co.country = 'Spain'
AND c.customer_id IN(SELECT customer_id FROM rental where return_date IS NULL);

-- Exercice 8 c)
SELECT DISTINCT c.customer_id, last_name, first_name
FROM customer c
    INNER JOIN address a on a.address_id = c.address_id
    INNER JOIN city ci on a.city_id = ci.city_id
    INNER JOIN country co on ci.country_id = co.country_id
    INNER JOIN rental r on c.customer_id = r.customer_id
WHERE co.country = 'Spain'
AND r.return_date IS NULL;

-- Exercice 10
SELECT f.title, count(*) As "nb_actors"
from film f
    INNER JOIN film_actor fa on f.film_id = fa.film_id
    INNER JOIN film_category fc on f.film_id = fc.film_id
    INNER JOIN category c on fc.category_id = c.category_id
WHERE c.name = 'Drama'
group by f.title
having count(*) < 5
ORDER BY count(*) desc;
```

​	

