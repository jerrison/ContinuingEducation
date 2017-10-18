USE mysql;

-- Returning query results in a specified order

SELECT * FROM emp;

SELECT
  ename,
  job,
  sal
FROM emp
  WHERE deptno = 10		
ORDER BY
  sal;
  
-- Sorting by Multiple Fields

SELECT
  empno,
  deptno,
  sal,
  ename,
  job
FROM emp  
ORDER BY
  deptno,
  sal DESC;
  
-- Sorting by Substrings

SELECT
  ename,
  job
FROM emp
ORDER BY
  RIGHT(job, 2);
  
  
SELECT
  ename,
  job
FROM emp
ORDER BY
  SUBSTR(job, LENGTH(job) - 1);


-- Sorting Mixed Alphanumeric Data
  
  
DROP VIEW IF EXISTS V;  

CREATE view V
AS
SELECT CONCAT(ename, ' ', deptno) AS data
  FROM emp;
  
SELECT * FROM V;  


/******************************************************************************
2.5 Dealing with NULLs when sorting
******************************************************************************/


SELECT * FROM emp;

-- naive way from Jerrison, as you can see NULL values are lower than any
-- non-null value
SELECT
  ename,
  sal,
  comm
FROM emp
ORDER BY
  comm;

-- solution from book

/* non-null comm sorted ascending, all nulls last */

SELECT
  ename,
  sal,
  comm
FROM (SELECT
        ename,
        sal,
        comm,
        CASE  WHEN comm IS NULL 
                THEN 0
              ELSE 1
        END AS is_null
      FROM emp) x
ORDER BY
  is_null DESC,
  comm;
  
/* non-null comm sorted descending, all nulls last */

SELECT
  ename,
  sal,
  comm
FROM (SELECT
        ename,
        sal,
        comm,
        CASE  WHEN comm IS NULL
                THEN 0
              ELSE 1
        END AS is_null
      FROM emp) x
ORDER BY
  is_null DESC,
  comm DESC;
  
  
/******************************************************************************
2.6 Sorting on a data dependent key
******************************************************************************/  

SELECT
  ename,
  sal,
  job,
  comm
FROM emp
ORDER BY
  CASE  WHEN job = 'SALESMAN'
          THEN comm
        ELSE sal
  END;
  
  
SELECT
  ename AS ename_and_dname,
  deptno
FROM emp
  WHERE deptno = 10
UNION ALL
SELECT 
  '---------------', 
  NULL
UNION ALL
SELECT
  dname,
  deptno
FROM dept;
        
  
      























