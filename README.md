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
```

