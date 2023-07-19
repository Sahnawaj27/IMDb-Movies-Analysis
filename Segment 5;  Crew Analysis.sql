-- 1 -- Identify the columns in the names table that have null values.
SELECT COUNT(*) - COUNT(ID)               AS id_nulls,
       COUNT(*) - COUNT(NAME)             AS name_nulls,
       COUNT(*) - COUNT(HEIGHT)           AS height_nulls,
       COUNT(*) - COUNT(DATE_OF_BIRTH)    AS date_of_birth_nulls,
       COUNT(*) - COUNT(KNOWN_FOR_MOVIES) AS known_for_movies_nulls
FROM   NAMES; 
-- There are no Null value in the column 'name' and 'id'.


-- 2 -- Determine the top three directors in the top three genres with movies having an average rating > 8.
WITH TOP_3_GENRE
AS
  ( SELECT     GENRE
	FROM       RATINGS R
   INNER JOIN MOVIE M ON R.MOVIE_ID=M.ID
   INNER JOIN GENRE USING (MOVIE_ID)
   WHERE AVG_RATING > 8
   GROUP BY   GENRE
   ORDER BY   COUNT(GENRE) DESC
   LIMIT      3 )
  SELECT     NAME AS director_name,
             COUNT(NAME) AS movie_count
  FROM       RATINGS R
  INNER JOIN MOVIE M ON R.MOVIE_ID=M.ID
  INNER JOIN GENRE USING (MOVIE_ID)
  INNER JOIN DIRECTOR_MAPPING D
  USING      (MOVIE_ID)
  INNER JOIN NAMES N ON D.NAME_ID=N.ID
  WHERE GENRE IN(
  SELECT *
  FROM   TOP_3_GENRE)
  AND AVG_RATING>8
  GROUP BY   NAME
  ORDER BY   COUNT(NAME) DESC
  LIMIT      3 ;
-- James Mangold is the top director.


-- 3 -- Find the top two actors whose movies have a median rating >= 8.
SELECT NAME AS 'ACTOR_NAME'
FROM NAMES
INNER JOIN ROLE_MAPPING ON ID=NAME_ID
INNER JOIN RATINGS USING (MOVIE_ID)
WHERE MEDIAN_RATING >=8 AND CATEGORY= 'ACTOR'
GROUP BY NAME
ORDER BY COUNT(NAME) DESC
LIMIT 2;
-- we find our favourite actors 'Mammootty' and 'Mohanlal' in the list.


-- 4 -- Identify the top three production houses based on the number of votes received by their movies.
SELECT PRODUCTION_COMPANY, SUM(TOTAL_VOTES) AS 'VOTE_COUNT'
FROM MOVIE
INNER JOIN RATINGS ON ID=MOVIE_ID
GROUP BY PRODUCTION_COMPANY
ORDER BY VOTE_COUNT DESC
LIMIT 3;
-- Marvel Studios became the top production house and rules the movie world.

-- 5 -- Rank actors based on their average ratings in Indian movies released in India.
WITH ACTORS AS(SELECT   NAME      AS actor_name ,
                        SUM(TOTAL_VOTES)    AS total_votes,
                        COUNT(NAME)  AS movie_count,
                        ROUND(SUM(AVG_RATING * TOTAL_VOTES) / SUM(TOTAL_VOTES)) AS actor_avg_rating
             FROM       NAMES N
             INNER JOIN ROLE_MAPPING RO
             ON         N.ID = RO.NAME_ID
             INNER JOIN MOVIE M
             ON         RO.MOVIE_ID = M.ID
             INNER JOIN RATINGS RA
             ON         M.ID = RA.MOVIE_ID
             WHERE      COUNTRY like 'india'
             AND        CATEGORY = 'actor'
             GROUP BY   NAME
             HAVING     MOVIE_COUNT >= 5)
  SELECT   *,
           DENSE_RANK() OVER ( ORDER BY ACTOR_AVG_RATING DESC, TOTAL_VOTES DESC) AS actor_rank
  FROM     ACTORS;
-- Vijay Sethupathi is the top actor

              
-- 6 -- Identify the top five actresses in Hindi movies released in India based on their average ratings.
WITH ACTRESS AS(SELECT   NAME      AS actress_name ,
                        SUM(TOTAL_VOTES)    AS total_votes,
                        COUNT(NAME)  AS movie_count,
                        ROUND(SUM(AVG_RATING * TOTAL_VOTES) / SUM(TOTAL_VOTES)) AS actress_avg_rating
             FROM       NAMES N
             INNER JOIN ROLE_MAPPING RO
             ON         N.ID = RO.NAME_ID
             INNER JOIN MOVIE M
             ON         RO.MOVIE_ID = M.ID
             INNER JOIN RATINGS RA
             ON         M.ID = RA.MOVIE_ID
             WHERE      LANGUAGES LIKE 'hindi'
             AND        COUNTRY like 'india'
             AND        CATEGORY = 'actress'
             GROUP BY   NAME
             HAVING     MOVIE_COUNT >= 3)
  SELECT   *,
           DENSE_RANK() OVER ( ORDER BY ACTRESS_AVG_RATING DESC, TOTAL_VOTES DESC) AS actress_rank
  FROM     ACTRESS;
-- Taapsee Pannu tops the actress list with average rating 8.