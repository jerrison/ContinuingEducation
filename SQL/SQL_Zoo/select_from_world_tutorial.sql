# SELECT FROM WORLD TUTORIAL

# QUESTION 8 
SELECT
  name,
  population,
  area
FROM world
  WHERE  (area >   3000000 AND population <= 250000000)
  OR         (area <= 3000000 AND population >    250000000)

SELECT
  name,
  population,
  area
FROM world
  WHERE area > 3000000 XOR population > 250000000

###############################################################################
# QUESTION 9
###############################################################################

SELECT
  name
  ,ROUND(population/1000000, 2)   AS population_in_million
  ,ROUND(gdp/1000000000, 2)       AS GDP_in_billion
FROM world
  WHERE continent IN ('South America')

###############################################################################
# QUESTION 10
###############################################################################

SELECT
  name
  ,ROUND((gdp/(population*1000)),0)*1000 AS GDP_per_capita_rounded_to_1000
FROM world
  WHERE gdp >= 1000000000000

# better way

SELECT
  name
  ,ROUND(gdp/population, -3) AS GDP_per_capita_rounded_to_1000
# when length, the second argument, is negative, round to the left of the
# decimal
FROM world
  WHERE gdp >= 1000000000000

###############################################################################
# QUESTION 11
###############################################################################

SELECT
  name
  ,capital
FROM world
  WHERE LENGTH(name) = LENGTH(capital)

###############################################################################
# QUESTION 12
###############################################################################

SELECT
  name
  ,capital
FROM world
  WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital

###############################################################################
# QUESTION 13
###############################################################################

SELECT
  name
FROM world
  WHERE name LIKE ('%a%')
  AND   name LIKE ('%e%')
  AND   name LIKE ('%i%')
  AND   name LIKE ('%o%')
  AND   name LIKE ('%u%')
  AND   name NOT LIKE ('% %')