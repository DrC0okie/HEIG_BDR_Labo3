-- Exercice 1
SELECT
    customer_id,
    last_name AS "nom",
    email
FROM customer c
         INNER JOIN store s
                    ON c.store_id = s.store_id
WHERE c.first_name = 'PHYLLIS'
ORDER BY
	customer_id DESC;

-- Exercice 2
SELECT
    title AS "titre",
    release_year AS "annee_sortie"
FROM film f
WHERE f.rating = 'R'
  AND f.length < 60
  AND f.replacement_cost = 12.99
ORDER BY
	f.title;

-- Exercice 3
SELECT
    country,
    city,
    postal_code
FROM address a
         INNER JOIN city c
                    ON a.city_id = c.city_id
         INNER JOIN country co
                    ON c.country_id = co.country_id
WHERE co.country = 'France'
  OR (co.country_id >= 63
  AND co.country_id <= 67)
ORDER BY
	co.country,
	c.city,
	a.postal_code;

-- Exercice 4
SELECT
    customer_id,
    first_name AS "prenom",
    last_name AS "nom"
FROM customer c
        INNER JOIN address a
            ON c.address_id = a.address_id
        INNER JOIN store s
            ON c.store_id = s.store_id
WHERE city_id = 171
  AND c.store_id = 1
  AND c.active
ORDER BY
	first_name;

-- Exercice 5
SELECT
    c1.first_name AS prenom_1,
    c1.last_name AS nom_1,
    c2.first_name AS prenom_2,
    c2.last_name AS nom_2
FROM film f
         INNER JOIN inventory i
         	ON f.film_id = i.film_id
         INNER JOIN rental r1
         	ON i.inventory_id = r1.inventory_id
         INNER JOIN rental r2
         	ON i.inventory_id = r2.inventory_id AND r1.customer_id <> r2.customer_id
         INNER JOIN customer c1
         	ON r1.customer_id = c1.customer_id
         INNER JOIN customer c2
         	ON r2.customer_id = c2.customer_id;

-- Exercice 6
SELECT
    last_name AS "nom",
    first_name AS "prenom"
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

-- Exercice 7 a)
SELECT DISTINCT
	f1.film_id AS "id",
    title AS "titre",
    rental_rate / rental_duration AS "prix_de_location_par_jour"
FROM film f1
WHERE rental_rate / rental_duration <= 1
  AND film_id NOT IN (SELECT f2.film_id
                      FROM film f2
                      	INNER JOIN inventory i
                      		ON f2.film_id = i.film_id
                        INNER JOIN rental r
                      		ON i.inventory_id = r.inventory_id);

-- Exercice 7 b)
SELECT DISTINCT
	f1.film_id AS "id",
    f1.title AS "titre",
    f1.rental_rate / f1.rental_duration AS "prix_de_location_par_jour"
FROM film f1
WHERE rental_rate / rental_duration <= 1
EXCEPT
SELECT
	f2.film_id AS "id",
	f2.title AS "titre",
    f2.rental_rate / f2.rental_duration AS "prix_de_location_par_jour"
FROM film f2
         INNER JOIN inventory i
         	ON f2.film_id = i.film_id
         INNER JOIN rental r
         	ON i.inventory_id = r.inventory_id;

-- Exercice 8 a)
SELECT DISTINCT
    c.customer_id AS "id",
    last_name AS "nom",
    first_name AS "prenom"
FROM customer c
    INNER JOIN address a
        ON a.address_id = c.address_id
    INNER JOIN city ci
        ON a.city_id = ci.city_id
    INNER JOIN country co
        ON ci.country_id = co.country_id
WHERE co.country = 'Spain'
AND EXISTS(SELECT
               r.customer_id
           FROM rental r
           WHERE return_date IS NULL
             AND c.customer_id = r.customer_id
    );

-- Exercice 8 b)
SELECT DISTINCT
    c.customer_id AS "id",
    last_name AS "nom",
    first_name AS "prenom"
FROM customer c
    INNER JOIN address a
        ON a.address_id = c.address_id
    INNER JOIN city ci
        ON a.city_id = ci.city_id
    INNER JOIN country co
        ON ci.country_id = co.country_id
WHERE co.country = 'Spain'
AND c.customer_id IN(SELECT customer_id
                     FROM rental
                     WHERE return_date IS NULL);

-- Exercice 8 c)
SELECT DISTINCT
    c.customer_id AS "id",
    last_name AS "nom",
    first_name AS "prenom"
FROM customer c
    INNER JOIN address a
        ON a.address_id = c.address_id
    INNER JOIN city ci
        ON a.city_id = ci.city_id
    INNER JOIN country co
        ON ci.country_id = co.country_id
    INNER JOIN rental r
        ON c.customer_id = r.customer_id
WHERE co.country = 'Spain'
AND r.return_date IS NULL;

-- Exercice 9
SELECT DISTINCT
    c.customer_id as "numéro",
    c.last_name as "nom",
    c.first_name as "prénom"
FROM customer c
    INNER JOIN rental r
        ON c.customer_id = r.customer_id
    INNER JOIN inventory i
        ON r.inventory_id = i.inventory_id
    INNER JOIN film f
        ON f.film_id = i.film_id
    INNER JOIN film_actor fa
        ON f.film_id = fa.film_id
    INNER JOIN actor a
        ON fa.actor_id = a.actor_id
WHERE a.first_name = 'EMILY'
AND a.last_name = 'DEE'
GROUP BY
	c.customer_id,
	c.last_name,
	c.first_name
HAVING COUNT(DISTINCT i.film_id) = (
    SELECT COUNT(*)
    FROM actor a
        INNER JOIN film_actor fa
            ON a.actor_id = fa.actor_id
        INNER JOIN film f
            ON fa.film_id = f.film_id
    WHERE a.first_name = 'EMILY'
    AND a.last_name = 'DEE'
);

-- Exercice 10
SELECT
    f.title AS "titre",
    count(*) AS "nb_acteurs"
FROM film f
    INNER JOIN film_actor fa
        ON f.film_id = fa.film_id
    INNER JOIN film_category fc
        ON f.film_id = fc.film_id
    INNER JOIN category c
        ON fc.category_id = c.category_id
WHERE c.name = 'Drama'
GROUP BY
	f.title
HAVING COUNT(*) < 5
ORDER BY
	COUNT(*) DESC;

-- Exercice 11
SELECT
	c.category_id AS "id",
	c.name AS "nom",
	COUNT(*) AS "nb_films"
FROM film f
         INNER JOIN film_category fc on f.film_id = fc.film_id
         INNER JOIN category c on fc.category_id = c.category_id
GROUP BY
	c.name,
	c.category_id
HAVING COUNT(*) > 65
ORDER BY
	nb_films;

-- Exercice 12
SELECT
    film_id AS "id",
    title AS "titre",
    length AS "duree"
FROM film
WHERE length IN(
    SELECT
        MIN(length)
    FROM film);

-- Exercice 13 a)
SELECT DISTINCT
	f.film_id AS id,
	f.title AS titre
FROM film f
         INNER JOIN film_actor fa
         	ON f.film_id = fa.film_id
WHERE fa.actor_id IN (SELECT actor_id
                      FROM film_actor fa
                      GROUP BY fa.actor_id
                      HAVING COUNT(*) > 40);

-- Exercice 13 b)
SELECT DISTINCT
	f.film_id AS id,
	f.title AS titre
FROM film f
         INNER JOIN film_actor fa
         	ON f.film_id = fa.film_id
         INNER JOIN (SELECT fa.actor_id
                     FROM film_actor fa
                     GROUP BY fa.actor_id
                     HAVING COUNT(*) > 40) AS actors
         	ON fa.actor_id = actors.actor_id;

-- Exercice 14
SELECT
    CEIL(SUM(length) / (8. * 60.)) AS "nb_jours"
FROM film;

-- Exercice 15
SELECT
    c.customer_id AS "id",
    last_name AS "nom",
    email,
    country AS "pays",
    COUNT(r.rental_id) AS "nb_locations",
    SUM(p.amount) AS "depense_totale",
    AVG(p.amount) AS "depense_moyenne"
FROM customer c
    INNER JOIN address a
        ON a.address_id = c.address_id
    INNER JOIN city ci
        ON ci.city_id = a.city_id
    INNER JOIN country co
        ON co.country_id = ci.country_id
    INNER JOIN rental r
        ON c.customer_id = r.customer_id
    INNER JOIN payment p
        ON r.rental_id = p.rental_id
WHERE country = 'Switzerland'
OR country = 'Spain'
OR country = 'Germany'
GROUP BY
	c.customer_id,
	last_name,
	email,
	country
HAVING AVG(p.amount) > 3.0
ORDER BY
	country,
	c.last_name;

-- Exercice 16 a)
SELECT COUNT(*)
FROM payment
WHERE amount <= 9;

-- Exercice 16 b)
DELETE
FROM payment
WHERE amount <= 9;

-- Exercice 16 c)
SELECT COUNT(*)
FROM payment
WHERE amount <= 9;

-- Exercice 17
UPDATE payment
    SET amount = amount * 1.5,
        payment_date = NOW()
WHERE
    amount > 4;

-- Exercice 18
INSERT INTO city (city, country_id)
VALUES (
        'Nyon',
        (SELECT
         	country_id
         FROM country
         WHERE country = 'Switzerland')
);

INSERT INTO address (address, district, city_id, postal_code, phone)

VALUES (
        'Rue du centre',
        'Vaud',
        (SELECT
         	city_id
         FROM city
         WHERE city = 'Nyon'),
        '1260',
        '0213600000'
);

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active)

VALUES (
        1,
        'GUILLAUME',
        'RANSOME',
        'gr@bluewin.ch',
        (SELECT
         	address_id
         FROM address
         WHERE address = 'Rue du centre'),
        TRUE
);

SELECT
    first_name,
    last_name,
    address,
    postal_code,
    city,
    country,
    phone,
    email,
    customer.store_id
FROM customer
    INNER JOIN address a
    	ON a.address_id = customer.address_id
    INNER JOIN city ci
    	ON ci.city_id = a.city_id
    INNER JOIN country c
    	ON ci.country_id = c.country_id
WHERE first_name = 'GUILLAUME'
AND last_name = 'RANSOME';
