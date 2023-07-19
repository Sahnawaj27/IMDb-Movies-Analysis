use imdb;

-- 1 -- What are the different tables in the database and how are they connected to each other in the database?
-- There are 6 tables in the database. Those are: 'director_mapping','genre','movie','names','ratings','role_mapping'.

-- CONNECT TO EACH OTHER :-
-- ROLL_MAPPING  is connected to MOVIE table on 1:1 mapping on MOVIE_ID in ROLE_MAPPING table to ID column in NAME table.
-- ROLL_MAPPING  is connected to NAMES table on 1:1 mapping on  NAMES_ID in ROLE_MAPPING table to ID column in NAME table.
-- NAME  is connected to DIRECTIOR_MAPPING table on 1:1 mapping on ID in NAMES table to NAME_ID column in DIRECTOR_MAPPING table.
-- DIRECTOR_MAPPING is connected to MOVIE table on 1:1 mapping on MOVIE_ID in DIRECTIOR_MAPPING table to ID column in MOVIE table.
-- MOVIE is connected to GENRE  table on 1:1 mapping on ID in MOVIE table to MOVIE_ID column in GENRE table.
-- MOVIE is connected to RATINGS  table on 1:1 mapping on ID in MOVIE table to MOVIE_ID column in RATING table.

-- 2 -- Find the total number of rows in each table of the schema.
SELECT table_name,
       table_rows
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_SCHEMA = 'imdb';
-- There are 6 tables in the database. Those are:'director_mapping','genre','movie','names','ratings','role_mapping'.

-- 3 -- Identify which columns in the movie table have null values.
SELECT 'ID'
FROM   MOVIE
WHERE  ID IS NULL
UNION
SELECT 'Title'
FROM   MOVIE
WHERE  TITLE IS NULL
UNION
SELECT 'Year'
FROM   MOVIE
WHERE  YEAR IS NULL
UNION
SELECT 'Date Published'
FROM   MOVIE
WHERE  DATE_PUBLISHED IS NULL
UNION
SELECT 'Movie'
FROM   MOVIE
WHERE  DURATION IS NULL
UNION
SELECT 'Country'
FROM   MOVIE
WHERE  COUNTRY IS NULL
UNION
SELECT 'WorldWide_Gross'
FROM   MOVIE
WHERE  WORLWIDE_GROSS_INCOME IS NULL
UNION
SELECT 'Languages'
FROM   MOVIE
WHERE  LANGUAGES IS NULL
UNION
SELECT 'Prod Company'
FROM   MOVIE
WHERE  PRODUCTION_COMPANY IS NULL; 
-- country, worlwide_gross_income, languages and production_company columns have NULL values.