-- 1 -- Determine the total number of movies released each year and analyse the month-wise trend.
SELECT YEAR, COUNT(TITLE) AS 'NO_OF_MOVIES'
FROM MOVIE
GROUP BY YEAR;
-- The highest number of movies is produced in the year of 2017.

SELECT MONTH(date_published) AS 'NO_OF_MONTH', COUNT(TITLE) AS 'NO_OF_MOVIES'
FROM MOVIE
GROUP BY MONTH(date_published)
ORDER BY NO_OF_MONTH;
-- The highest number of movies is produced in the month of March.

-- 2 -- Calculate the number of movies produced in the USA or India in the year 2019
SELECT year, COUNT(TITLE) AS 'NO_OF_MOVIES'
FROM MOVIE
WHERE YEAR=2019 AND (COUNTRY LIKE '%USA%' OR COUNTRY LIKE '%India%')
GROUP BY YEAR;
-- USA and India produced more than a thousand movies in the year 2019.