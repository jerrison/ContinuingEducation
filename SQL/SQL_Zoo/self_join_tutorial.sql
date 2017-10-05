###############################################################################
# Title: selft_join_tutorial.sql
# Author: Jerrison Li
# Date: Oct 4, 2017
# Version: 1.0
###############################################################################

###############################################################################
# 1
# How many stops are in the database.
###############################################################################

SELECT
  COUNT(id) AS stop_count
FROM stops

###############################################################################
# 2
# Find the id value for the stop 'Craiglockhart'
###############################################################################

SELECT
  id
FROM stops
  WHERE name = 'Craiglockhart'


###############################################################################
# 3
# Give the id and the name for the stops on the '4' 'LRT' service.
###############################################################################

SELECT
  a.id,
  a.name
FROM stops a
INNER JOIN route b
    ON a.id = b.stop
  WHERE num         = '4' 
  AND   company     = 'LRT'

###############################################################################
# 4
# The query shown gives the number of routes that visit either London Road 
# (149) or Craiglockhart (53). Run the query and notice the two services that 
# link these stops have a count of 2. Add a HAVING clause to restrict the 
# output to these two routes.
###############################################################################

SELECT 
    company, 
    num, 
    COUNT(*)
FROM route 
    WHERE   stop    =   149 
    OR      stop    =   53
GROUP BY 
    company, 
    num
HAVING(COUNT(*)) > 1

###############################################################################
# 5
# Execute the self join shown and observe that b.stop gives all the places you 
# can get to from Craiglockhart, without changing routes. Change the query so 
# that it shows the services from Craiglockhart to London Road.
###############################################################################

SELECT 
  a.company, 
  a.num, 
  a.stop, 
  b.stop
FROM route a 
INNER JOIN route b ON (a.company  =   b.company 
                       AND a.num  =   b.num)
  WHERE a.stop  = 53
  AND   b.stop  = 149

###############################################################################
# 6
# The query shown is similar to the previous one, however by joining two copies
# of the stops table we can refer to stops by name rather than by number. 
# Change the query so that the services between 'Craiglockhart' and 'London 
# Road' are shown. If you are tired of these places try 'Fairmilehead' against 
# 'Tollcross'
###############################################################################

SELECT 
  a.company, 
  a.num, 
  stopa.name, 
  stopb.name
FROM route a 
INNER JOIN route b 
    ON  a.company   =   b.company 
    AND a.num       =   b.num
INNER JOIN stops stopa 
    ON a.stop       =   stopa.id
INNER JOIN stops stopb 
    ON b.stop       =   stopb.id
  WHERE stopa.name  = 'Craiglockhart'
  AND   stopb.name  = 'London Road'

###############################################################################
# 7
# Give a list of all the services which connect stops 115 and 137 ('Haymarket' 
# and 'Leith')
###############################################################################

SELECT DISTINCT
  r2.company,
  r1.num  
FROM  route r1,
      route r2
  WHERE r1.num      = r2.num
  AND   r1.company  = r2.company
  AND   r1.stop     = 115
  AND   r2.stop     = 137

###############################################################################
# 8
# Give a list of the services which connect the stops 'Craiglockhart' and 
# 'Tollcross'
###############################################################################

SELECT DISTINCT
  r2.company,
  r1.num  
FROM        route r1
INNER JOIN  route r2
    ON  r1.num      = r2.num
    AND r1.company  = r2.company
INNER JOIN  stops stop1
    ON  r1.stop     = stop1.id
INNER JOIN  stops stop2
    ON  r2.stop     = stop2.id
  WHERE stop1.name  = 'Craiglockhart'
  AND   stop2.name  = 'Tollcross'



SELECT DISTINCT
  r2.company,
  r1.num  
FROM        route r1
INNER JOIN  route r2
    ON  r1.num      = r2.num
    AND r1.company  = r2.company
INNER JOIN  stops stop1
    ON  r1.stop     = stop1.id
    AND stop1.name  = 'Craiglockhart'
INNER JOIN  stops stop2
    ON    r2.stop     = stop2.id
    AND   stop2.name  = 'Tollcross'

###############################################################################
# 9
# Give a distinct list of the stops which may be reached from 'Craiglockhart' 
# by taking one bus, including 'Craiglockhart' itself, offered by the LRT 
# company. Include the company and bus no. of the relevant services.
###############################################################################



SELECT DISTINCT
  stop2.name,
  r1.company,
  r1.num
FROM        route r1
INNER JOIN  route r2
    ON    r1.num      =   r2.num
    AND   r1.company  =   r2.company
    #AND   r1.pos      <=  r2.pos
INNER JOIN  stops stop1
    ON    r1.stop     =   stop1.id
INNER JOIN  stops stop2
    ON    r2.stop     =   stop2.id    
  WHERE stop1.name = 'Craiglockhart'
  AND   r1.company = 'LRT'


/*#############################################################################
10
Find the routes involving two buses that can go from Craiglockhart to 
Sighthill.
Show the bus no. and company for the first bus, the name of the stop for the 
transfer, and the bus no. and company for the second bus.

Hint
Self-join twice to find buses that visit Craiglockhart and Sighthill, then join 
those on matching stops.

So they share that transfer stop, bus one must begin in Craiglockhart and end
in transfer stop.  Bus 2 begins in transfer stop and ends in Sighthill.
#############################################################################*/


SELECT

FROM        route r1
INNER JOIN  (SELECT
              *
            FROM route r2
              WHERE 

INNER JOIN  stops stop1
    ON    r1.stop     =   stop1.id
INNER JOIN  stops stop2
    ON    r2.stop     =   stop2.id    
  WHERE stop1.name = 'Craiglockhart'


SELECT
  t1.num,
  t1.company,
  t1.name,
  t2.num,
  t2.company
FROM

(SELECT
  r.num,
  r.company,
  s.name
FROM route r
INNER JOIN stops s
    ON r.stop = s.id
  WHERE s.name = 'Craiglockhart') AS t1

INNER JOIN 

(SELECT
  r.num,
  r.company,
  s.name
FROM route r
INNER JOIN stops s
    ON r.stop = s.id
  WHERE s.name = 'Sighthill')   AS t2

    ON t1.name = t2.name
