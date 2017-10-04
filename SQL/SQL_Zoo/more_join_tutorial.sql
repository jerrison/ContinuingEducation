###############################################################################
# Title:
# Author: Jerrison Li
# Date: Oct 4, 2017
# Version: 1.0
###############################################################################

###############################################################################
# 1
# List the films where the yr is 1962 [Show id, title]
###############################################################################

SELECT
  id,
  title
FROM movie
  WHERE yr = 1962

###############################################################################
# 2
# Give year of 'Citizen Kane'.
###############################################################################

SELECT
  yr
FROM movie
  WHERE title = 'Citizen Kane'

###############################################################################
# 3
# List all of the Star Trek movies, include the id, title and yr (all of these 
# movies include the words Star Trek in the title). Order results by year.
###############################################################################

SELECT
  id,
  title,
  yr
FROM movie
  WHERE TITLE LIKE ('%Star Trek%')
ORDER BY
  yr

###############################################################################
# 4.
# What id number does the actor 'Glenn Close' have?
###############################################################################

SELECT
  id
FROM actor
  WHERE name = 'Glenn Close'

###############################################################################
# 5
# What is the id of the film 'Casablanca'
###############################################################################

SELECT
  id
FROM movie
  WHERE title = 'Casablanca'


###############################################################################
# 6
# Obtain the cast list for 'Casablanca'.
# Use movieid=11768, (or whatever value you got from the previous question)
###############################################################################

SELECT
  c.name
FROM casting a
INNER JOIN movie b
    ON a.movieid = b.id
INNER JOIN actor c
    ON a.actorid = c.id
  WHERE b.title = 'Casablanca'

###############################################################################
# 8
# Obtain the cast list for the film 'Alien'
###############################################################################

SELECT
  c.name
FROM casting a
INNER JOIN movie b
    ON a.movieid = b.id
INNER JOIN actor c
    ON a.actorid = c.id
  WHERE b.title = 'Alien'


###############################################################################
# 8
# List the films in which 'Harrison Ford' has appeared
###############################################################################

SELECT
  b.title
FROM casting a
INNER JOIN movie b
    ON a.movieid = b.id
INNER JOIN actor c
    ON a.actorid = c.id
  WHERE c.name = 'Harrison Ford'

###############################################################################
# 9
# List the films where 'Harrison Ford' has appeared - but not in the starring 
# role. [Note: the ord field of casting gives the position of the actor. If 
# ord=1 then this actor is in the starring role]
###############################################################################

SELECT
  b.title
FROM casting a
INNER JOIN movie b
    ON a.movieid = b.id
INNER JOIN actor c
    ON a.actorid = c.id
  WHERE c.name = 'Harrison Ford'
  AND a.ord > 1

###############################################################################
# 10
# List the films together with the leading star for all 1962 films.
###############################################################################

SELECT
  b.title,
  c.name
FROM casting a
INNER JOIN movie b
    ON a.movieid = b.id
INNER JOIN actor c
    ON a.actorid = c.id
  WHERE b.yr = 1962
  AND a.ord = 1

###############################################################################
# 11
# Which were the busiest years for 'John Travolta', show the year and the 
# number of movies he made each year for any year in which he made more than 2 
# movies.
###############################################################################

SELECT
  b.yr,
  COUNT(b.title) AS movie_count
FROM casting a
INNER JOIN movie b
    ON a.movieid = b.id
INNER JOIN actor c
    ON a.actorid = c.id
  WHERE c.name = 'John Travolta'
GROUP BY
  b.yr
HAVING COUNT(b.title) > 2


###############################################################################
# 12
# List the film title and the leading actor for all of the films 'Julie 
# Andrews' played in.
###############################################################################


SELECT
  b.title,
  c.name
FROM casting a
INNER JOIN movie b
    ON a.movieid = b.id
INNER JOIN actor c
    ON a.actorid = c.id
  WHERE a.ord = 1
  AND b.id IN (SELECT
                  DISTINCT(a.movieid) AS movie_id
                FROM casting a
                INNER JOIN actor c
                    ON a.actorid = c.id
                  WHERE c.name = 'Julie Andrews')

###############################################################################
# 13
# Obtain a list, in alphabetical order, of actors who've had at least 30 
# starring roles.
###############################################################################

SELECT
  a.name
FROM actor a
INNER JOIN casting c
    ON a.id = c.actorid
  WHERE c.ord = 1
GROUP BY 
  a.name
HAVING SUM(c.ord) >= 30
ORDER BY
  a.name

###############################################################################
# 14
# List the films released in the year 1978 ordered by the number of actors in 
# the cast, then by title.
###############################################################################


SELECT
  a.title,
  COUNT(b.actorid)
FROM movie a
INNER JOIN casting b
    ON a.id = b.movieid
  WHERE a.yr = 1978
GROUP BY
  a.title
ORDER BY
  COUNT(b.actorid) DESC,
  a.title


###############################################################################
# 15
# List all the people who have worked with 'Art Garfunkel'
###############################################################################


SELECT
  DISTINCT(a.name) AS actor
FROM actor a
INNER JOIN casting b
    ON a.id = b.actorid
  WHERE b.movieid IN (SELECT
                        DISTINCT(a.movieid) AS movie_id
                      FROM casting a
                      INNER JOIN actor c
                          ON a.actorid = c.id
                        WHERE c.name = 'Art Garfunkel')
  AND a.name <> 'Art Garfunkel'
ORDER BY
  a.name


