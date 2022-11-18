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
```

​	

