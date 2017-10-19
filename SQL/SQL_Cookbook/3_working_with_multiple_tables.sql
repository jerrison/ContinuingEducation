/******************************************************************************
3.2 Combining related rows
******************************************************************************/

USE mysql;

SELECT * FROM dept;

SELECT * FROM emp;

SELECT
  e.ename,
  d.loc
FROM emp e
LEFT JOIN dept d
    ON e.deptno = d.deptno
  WHERE e.deptno = 10;

-- solution from book  
SELECT
  e.ename,
  d.loc
FROM emp e, dept d
  WHERE e.deptno = d.deptno
  AND e.deptno = 10;
  
-- cartesian product of the two tables
SELECT
  e.ename,
  d.loc,
  e.deptno  AS emp_deptno,
  d.deptno  AS dept_deptno
FROM emp e, dept d
  WHERE e.deptno = 10;
  
  
/******************************************************************************
3.3 Finding rows in commno between two tables
******************************************************************************/

DROP VIEW IF EXISTS V;

CREATE VIEW V
AS
SELECT
  ename,
  job,
  sal
FROM emp
  WHERE job = 'CLERK';
  
SELECT * FROM V;  


SELECT
  e.empno,
  e.ename,
  e.job,
  e.sal,
  e.deptno
FROM emp e, V
  WHERE e.ename   = V.ename
  AND   e.job     = V. job
  AND   e.sal     = V.sal;
  
  
SELECT
  e.empno,
  e.ename,
  e.job,
  e.sal,
  e.deptno
FROM emp e
INNER JOIN V
    ON (    e.ename   = V.ename
        AND e.job     = V.job
        AND e.sal     = V.sal);
        

SELECT
  e.empno,
  e.ename,
  e.job,
  e.sal,
  e.deptno
FROM emp e
INNER JOIN V
    ON e.ename   = V.ename
    AND e.job     = V.job
    AND e.sal     = V.sal;        

/******************************************************************************
3.4 Retrieving values from one table that do not exist in another
******************************************************************************/

SELECT
  deptno
FROM dept
  WHERE deptno NOT IN (SELECT deptno FROM emp);
  
  
CREATE TABLE new_dept(deptno INTEGER);
INSERT INTO new_dept VALUES (10);
INSERT INTO new_dept VALUES (50);
INSERT INTO new_dept VALUES (NULL);


SELECT 
  * 
FROM dept
  WHERE deptno NOT IN (SELECT deptno FROM new_dept);

-- IN and NOT IN are essentially OR operations
-- For IN, which means TRUE, comparing it with NULL returns TRUE
-- For NOT IN, which means FALSE, comparing it with NULL returns NULL

SELECT
  deptno
FROM dept
  WHERE deptno IN (10, 50, NULL);
  
  
SELECT
  deptno
FROM dept
  WHERE (   deptno = 10
        OR  deptno = 50
        OR  deptno = NULL);
        


SELECT
  deptno
FROM dept
  WHERE deptno NOT IN (10, 50, NULL);
  

SELECT
  deptno
FROM dept
  WHERE NOT (deptno = 10 OR deptno = 50 OR deptno = NULL);
        
-- In SQL, "TRUE OR NULL" is TRUE, but "FALSE or NULL" is NULL!  

SELECT
  d.deptno
FROM dept d
  WHERE NOT EXISTS(
    SELECT
      1
    FROM emp e
      WHERE d.deptno = e.deptno);





SELECT
  d.deptno
FROM dept d
  WHERE NOT EXISTS(
    SELECT
      1
    FROM new_dept nd
      WHERE d.deptno = nd.deptno);
      
      
/******************************************************************************
3.5 retrieving rows from one table that do not correspond to rows in another
******************************************************************************/

/*
first we left join to get all rows from the original table and then keep the
NULL entries from the second table
*/

SELECT
  d.*
FROM            dept d
LEFT OUTER JOIN emp e
    ON d.deptno = e.deptno
  WHERE e.deptno IS NULL;


SELECT
  e.ename,
  e.deptno AS emp_deptno,
  d.*
FROM            dept d
LEFT OUTER JOIN emp e
    ON d.deptno = e.deptno;

/******************************************************************************
3.6 Adding joins to a query without interfering with other joins
******************************************************************************/

SELECT * FROM emp_bonus;

SELECT 
  e.ename,
  d.loc
FROM        emp e
INNER JOIN  dept d
    ON e.deptno = d.deptno;


SELECT 
  e.ename,
  d.loc,
  eb.received
FROM        emp       e
INNER JOIN  dept      d
    ON e.deptno = d.deptno
INNER JOIN  emp_bonus eb  
    ON e.empno  = eb.empno;
    


SELECT 
  e.ename,
  d.loc,
  eb.received
FROM        emp       e
INNER JOIN  dept      d
    ON e.deptno = d.deptno
LEFT OUTER JOIN  emp_bonus eb  
    ON e.empno  = eb.empno;


SELECT
  e.ename,
  d.loc,
  (SELECT eb.received FROM emp_bonus eb
    WHERE eb.empno = e.empno) AS received
FROM        emp e
INNER JOIN  dept d
  WHERE e.deptno = d.deptno
ORDER BY
  d.loc;
  
/******************************************************************************
3.7 Determining whether two tables have the same data
******************************************************************************/

DROP VIEW IF EXISTS V;

CREATE VIEW V
AS
SELECT * FROM emp WHERE deptno != 10
  UNION ALL
SELECT * FROM emp WHERE ename = 'WARD';

SELECT * FROM V;

/*
This is a very complicated task using MySQL and SQL Server
*/


/******************************************************************************
3.8 Identifying and Avoiding Cartesian Products
******************************************************************************/

SELECT
  e.ename,
  d.loc
FROM emp e
CROSS JOIN dept d
  WHERE e.deptno = 10
ORDER BY
  e.ename,
  d.loc DESC;

/*
Essentially, you have to join on corresponding columns from tables to avoid
cartesian products
*/

/******************************************************************************
3.9 Performing joins when using aggregates
******************************************************************************/


SELECT  e.empno,
        e.ename,
        e.sal,
        e.deptno,
        e.sal*CASE  WHEN eb.type = 1 THEN .1
                    WHEN eb.type = 2 THEN .2
                    ELSE .3
              END AS bonus
FROM        emp       e
INNER JOIN  emp_bonus eb
    ON e.empno = eb.empno
  WHERE e.deptno = 10;



SELECT  deptno,
        SUM(sal)    AS total_sal,
        SUM(bonus)  AS total_bonus
FROM(SELECT  e.empno,
        e.ename,
        e.sal,
        e.deptno,
        e.sal*CASE  WHEN eb.type = 1 THEN .1
                    WHEN eb.type = 2 THEN .2
                    ELSE .3
              END AS bonus
    FROM        emp       e
    INNER JOIN  emp_bonus eb
        ON e.empno = eb.empno
      WHERE e.deptno = 10) x
GROUP BY
  deptno;




SELECT  deptno,
        SUM(DISTINCT sal)    AS total_sal,
        SUM(bonus)  AS total_bonus
FROM(SELECT e.empno,
            e.ename,
            e.sal,
            e.deptno,
            e.sal*CASE  WHEN eb.type = 1 THEN .1
                        WHEN eb.type = 2 THEN .2
                        ELSE .3
                  END AS bonus
    FROM        emp       e
    INNER JOIN  emp_bonus eb
        ON e.empno = eb.empno
      WHERE e.deptno = 10) x
GROUP BY
  deptno;


SELECT  d.deptno,
        d.total_sal,
        SUM(e.sal*CASE  WHEN eb.type = 1 THEN .1
                        WHEN eb.type = 2 THEN .2
                        ELSE .3
                  END) AS total_bonus
FROM emp e
INNER JOIN emp_bonus eb
    ON e.empno = eb.empno
INNER JOIN (SELECT  deptno,
                    SUM(sal) AS total_sal
            FROM emp
              WHERE deptno = 10
            GROUP BY
              deptno) d
    ON e.deptno = d.deptno
GROUP BY  d.deptno,
          d.total_sal;
          
/******************************************************************************
3.10 Performing outer joins when using aggregates
******************************************************************************/          
-- Example showing wrong output  
SELECT  deptno,
        SUM(sal)  AS total_sal,
        SUM(bonus) AS total_bonus
FROM (SELECT  e.empno,
              e.ename,
              e.sal,
              e.deptno,
              e.sal*CASE  WHEN eb.type = 1 THEN .1
                          WHEN eb.type = 2 THEN .2
                          ELSE .3
                    END AS bonus
      FROM        emp e
      INNER JOIN  emp_bonus eb
          ON e.empno = eb.empno
        WHERE e.deptno = 10) x
GROUP BY deptno;

-- solution
SELECT  deptno,
        SUM(sal)  AS total_sal,
        SUM(bonus) AS total_bonus
FROM (SELECT  e.empno,
              e.ename,
              e.sal,
              e.deptno,
              e.sal*CASE  WHEN eb.type IS NULL  THEN 0
                          WHEN eb.type = 1      THEN .1
                          WHEN eb.type = 2      THEN .2
                                                ELSE .3
                    END AS bonus
      FROM            emp e
      LEFT OUTER JOIN emp_bonus eb
          ON e.empno = eb.empno
        WHERE e.deptno = 10) x
GROUP BY deptno;





