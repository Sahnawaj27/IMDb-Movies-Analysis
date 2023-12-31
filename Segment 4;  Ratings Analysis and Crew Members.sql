-- 1 -- Retrieve the minimum and maximum values in each column of the ratings table (except movie_id).
SELECT MIN(AVG_RATING) AS 'MIN_AVG_RATING',
	   MAX(AVG_RATING) AS 'MAX_AVG_RATING',
       MIN(TOTAL_VOTES) AS 'MIN_TOTAL_VOTES',
	   MAX(TOTAL_VOTES) AS 'MAX_TOTAL_VOTES',
       MIN(MEDIAN_RATING) AS 'MIN_MEDIAN_RATING',
	   MAX(MEDIAN_RATING) AS 'MAX_MEDIAN_RATING'
FROM RATINGS;
-- So,the minimum and maximum values in each column of the ratings table are in the expected range.

-- 2 -- Identify the top 10 movies based on average rating.
SELECT TITLE
FROM RATINGS
INNER JOIN MOVIE ON ID=MOVIE_ID
ORDER BY AVG_RATING DESC
LIMIT 10;
-- we found the 10 movies from this.

-- 3 -- Summarise the ratings table based on movie counts by median ratings.
SELECT MEDIAN_RATING, COUNT(MOVIE_ID) AS 'MOVIE_COUNT'
FROM RATINGS
GROUP BY MEDIAN_RATING
ORDER BY MEDIAN_RATING ASC;
-- Movies with a median rating of 7 is highest in number. 

-- 4 -- Identify the production house that has produced the most number of hit movies (average rating > 8).
SELECT PRODUCTION_COMPANY
FROM MOVIE
INNER JOIN RATINGS ON MOVIE_ID=ID
WHERE AVG_RATING>8
ORDER BY AVG_RATING DESC
LIMIT 1;
-- A square productions produces the highest number of hit movies

-- 5 -- Determine the number of movies released in each genre during March 2017 in the USA with more than 1,000 votes.
WITH mov AS (SELECT g.genre,
                r.MOVIE_ID,
                m.DATE_PUBLISHED,
                m.COUNTRY
         FROM   RATINGS r
		 INNER JOIN GENRE g ON r.MOVIE_ID = g.MOVIE_ID
		 INNER JOIN MOVIE m ON g.MOVIE_ID = m.ID
         WHERE  r.TOTAL_VOTES > 1000
                AND Month(DATE_PUBLISHED) = 3
                AND Year(DATE_PUBLISHED) = 2017
                AND m.COUNTRY IN ( 'USA' ))
SELECT GENRE,
       Count(MOVIE_ID) AS movie_count
FROM   mov
GROUP  BY GENRE
ORDER  BY Count(MOVIE_ID) DESC;
-- there are total 54 movies released in each genre during March 2017 in the USA with more than 1,000 votes.

-- 6 -- Retrieve movies of each genre starting with the word 'The' and having an average rating > 8.
SELECT TITLE
FROM GENRE
INNER JOIN MOVIE ON MOVIE_ID =ID
INNER JOIN RATINGS USING (MOVIE_ID)
WHERE AVG_RATING>8 AND (TITLE) LIKE 'The%'
ORDER BY AVG_RATING DESC;
-- i took this query to find the movies whose name starts with the word 'THE'
