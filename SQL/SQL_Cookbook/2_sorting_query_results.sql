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



-- 2.5 Dealing with NULLs when sorting

SELECT * FROM emp;












