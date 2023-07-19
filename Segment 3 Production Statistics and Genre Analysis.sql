-- 1 -- Retrieve the unique list of genres present in the dataset.
SELECT DISTINCT GENRE
FROM GENRE;
-- bollywood Movies plans to make a movie of one of these genres.

-- 2 -- Identify the genre with the highest number of movies produced overall.
SELECT GENRE, COUNT(TITLE) AS 'NO_OF_MOVIES'
FROM MOVIE
INNER JOIN GENRE ON MOVIE_ID=ID
GROUP BY GENRE
ORDER BY NO_OF_MOVIES DESC
LIMIT 1;
-- So, based on the insight that we just drew, bollywood Movies should focus on the ‘Drama’ genre. 

-- 3 -- Determine the count of movies that belong to only one genre.
SELECT GENRE, COUNT(TITLE) AS 'NO_OF_MOVIES'
FROM MOVIE
INNER JOIN GENRE ON MOVIE_ID=ID
GROUP BY GENRE;
-- There are more than three thousand movies which has only one genre associated with them.

-- 4 -- Calculate the average duration of movies in each genre.
SELECT GENRE,
ROUND(AVG(DURATION)) AS 'AVERAGE_DURATION'
FROM MOVIE
INNER JOIN GENRE ON MOVIE_ID=ID
GROUP BY GENRE;
-- Now we know, movies of genre 'Drama'(produced highest number of movies) has the average duration of 107 mins.

-- 5 -- Find the rank of the 'thriller' genre among all genres in terms of the number of movies produced.
with CTE as (SELECT genre, COUNT(*) AS movie_count,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS genre_rank
FROM genre
GROUP BY genre
ORDER BY genre_rank)
select genre, genre_rank from CTE where genre = 'Thriller';
-- Thriller movies is in top 3 among all genres in terms of number of movies.