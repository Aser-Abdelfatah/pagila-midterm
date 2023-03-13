/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */



WITH TITLE_WITHOUT_F AS

(	
	SELECT title
	FROM film
	WHERE title NOT ILIKE '%f%'
),


ACTORS_WITHOUT_F AS
(
	SELECT TITLE
	FROM FILM
	WHERE TITLE NOT IN
	(	
		SELECT TITLE
		FROM FILM
		LEFT JOIN FILM_ACTOR
		USING (FILM_ID)
		LEFT JOIN ACTOR
		USING (ACTOR_ID)
		WHERE ACTOR.FIRST_NAME ILIKE '%f%'
		OR ACTOR.LAST_NAME  ILIKE '%f%'
		GROUP BY TITLE
	)
),


CUSTOMERS_WITHOUT_F AS
(
	SELECT TITLE
	FROM FILM
	WHERE TITLE NOT IN
	(	
		SELECT TITLE
		FROM FILM
		LEFT JOIN INVENTORY
		USING (FILM_ID)
		LEFT JOIN RENTAL
		USING (INVENTORY_ID)
		LEFT JOIN CUSTOMER
		USING (CUSTOMER_ID)
		WHERE CUSTOMER.FIRST_NAME ILIKE '%f%'
		OR CUSTOMER.LAST_NAME  ILIKE '%f%'
		GROUP BY TITLE
	)
),

ADDRESS_WITHOUT_F AS
(
	SELECT TITLE
	FROM FILM
	WHERE TITLE NOT IN
	(	
		SELECT TITLE
		FROM FILM
		LEFT JOIN INVENTORY
		USING (FILM_ID)
		LEFT JOIN RENTAL
		USING (INVENTORY_ID)
		LEFT JOIN CUSTOMER
		USING (CUSTOMER_ID)
		LEFT JOIN ADDRESS
		USING (ADDRESS_ID)
		LEFT JOIN CITY
		USING (CITY_ID)
		LEFT JOIN COUNTRY
		USING (COUNTRY_ID)
		WHERE ADDRESS ILIKE '%F%'
		OR ADDRESS2 ILIKE '%F%'
		OR DISTRICT ILIKE '%F%'
		OR CITY ILIKE '%F%'
		OR COUNTRY ILIKE '%F%'
		GROUP BY TITLE
	)
)


SELECT TITLE
FROM FILM
WHERE TITLE IN
	(
		SELECT *
		FROM ADDRESS_WITHOUT_F
	)
AND TITLE IN
	(
		SELECT *
		FROM CUSTOMERS_WITHOUT_F
	)
AND TITLE IN
	(
		SELECT *
		FROM ACTORS_WITHOUT_F
	)	
AND TITLE IN
	(
		SELECT *
		FROM TITLE_WITHOUT_F
	)
ORDER BY TITLE
    ;

