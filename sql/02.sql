/*
 * Write a SQL query SELECT query that:
 * computes the country with the most customers in it. 
 */


SELECT country
FROM CUSTOMER
LEFT JOIN ADDRESS
USING (ADDRESS_ID)
LEFT JOIN CITY
USING (CITY_ID)
LEFT JOIN COUNTRY
USING (COUNTRY_ID)
GROUP BY country
ORDER BY COUNT(*) DESC
LIMIT 1;
