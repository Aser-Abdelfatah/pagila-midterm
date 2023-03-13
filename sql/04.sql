/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query SELECT query that:
 * Lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 * (You may choose to either include or exclude the movie 'AMERICAN CIRCUS' in the results.)
 */


SELECT TITLE
FROM FILM
INNER JOIN FILM_ACTOR
USING (FILM_ID)
WHERE ACTOR_ID
IN
(
    SELECT ACTOR_ID
    FROM FILM
    INNER JOIN FILM_ACTOR
    USING (FILM_ID)
    WHERE TITLE ILIKE 'AMERICAN CIRCUS'
)
GROUP BY TITLE
HAVING COUNT(*) > 1
ORDER BY TITLE;
