/******************************************************************************
3.2 Combining related rows
******************************************************************************/

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



























