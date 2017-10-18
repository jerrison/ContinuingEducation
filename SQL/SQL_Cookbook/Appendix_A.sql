USE mysql;

SELECT
  COUNT(*)  AS cnt
FROM emp;


SELECT
  ename,
  deptno,
  COUNT(*) OVER() AS cnt
FROM emp
ORDER BY
  deptno;

-- ORDER OF EVALUATION

SELECT
  ename,
  deptno,
  COUNT(*) OVER () AS cnt
FROM emp
  WHERE deptno = 10
ORDER BY
  deptno;
  
-- Partitions
SELECT
  ename,
  deptno,
  COUNT(*) OVER(PARTITION BY deptno)  AS cnt
FROM emp
ORDER BY
  deptno;
  
SELECT
  e.ename,
  e.deptno,
  (SELECT COUNT(*) FROM emp d
    WHERE e.deptno = d.deptno)  AS cnt
FROM emp e
ORDER BY
  e.deptno;
  
SELECT
  ename,
  deptno,
  COUNT(*) OVER(PARTITION BY deptno)  AS dept_cnt,
  job,
  COUNT(*) OVER(PARTITION BY job)     AS job_cnt
FROM emp
ORDER BY
  deptno,
  job;
  

-- Effect of NULLs

SELECT
  COALESCE(comm, -1)                AS commission,
  COUNT(*) OVER(PARTITION BY comm)  AS cnt
FROM emp
ORDER BY
  COALESCE(comm, -1) DESC;  

-- When order matters

SELECT
  deptno,
  ename,
  hiredate,
  sal,
  SUM(sal) OVER(PARTITION BY deptno)  AS total1,
  SUM(sal) OVER()                     AS total2,
  SUM(sal) OVER(ORDER BY hiredate)    AS running_total
FROM emp
  WHERE deptno = 10;
  
SELECT
  deptno,
  ename,
  hiredate,
  sal,
  SUM(sal) OVER(PARTITION BY deptno)        AS total1,
  SUM(sal) OVER()                           AS total2,
  SUM(sal) OVER(ORDER BY hiredate
                RANGE BETWEEN 1 PRECEDING
                      AND     CURRENT ROW)  AS running_total
FROM emp
  WHERE deptno = 10;
  
  
-- The framing clause

  
SELECT
  deptno,
  ename,
  sal,
  SUM(sal) OVER(ORDER BY hiredate
                ROWS BETWEEN UNBOUNDED PRECEDING
                      AND     CURRENT ROW)          AS run_total1,
  SUM(sal) OVER(ORDER BY hiredate
                ROWS BETWEEN 1 PRECEDING
                      AND   CURRENT ROW)            AS run_total2,
  SUM(sal) OVER(ORDER BY hiredate
                ROWS BETWEEN CURRENT ROW
                      AND   UNBOUNDED FOLLOWING)    AS run_total3,
  SUM(sal) OVER(ORDER BY hiredate
                ROWS BETWEEN CURRENT ROW
                      AND   1 FOLLOWING)            AS run_total4
FROM emp
  WHERE deptno = 10;
  
  
-- A framing finale

SELECT
  ename,
  sal,
  MIN(sal) OVER(ORDER BY sal)                       AS min1,
  MAX(sal) OVER(ORDER BY sal)                       AS max1,
  MIN(sal) OVER(ORDER BY sal
                ROWS  BETWEEN UNBOUNDED PRECEDING
                      AND     UNBOUNDED FOLLOWING)  AS min2,
  MAX(sal) OVER(ORDER BY sal
                ROWS  BETWEEN UNBOUNDED PRECEDING
                      AND     UNBOUNDED FOLLOWING)  AS max2,                    
  MIN(sal) OVER(ORDER BY sal
                ROWS  BETWEEN CURRENT ROW
                      AND     CURRENT ROW)          AS min3,
  MAX(sal) OVER(ORDER BY sal
                ROWS  BETWEEN CURRENT ROW
                      AND     CURRENT ROW)          AS max3,
  MAX(sal) OVER(ORDER BY sal
                ROWS  BETWEEN 3 PRECEDING
                      AND     3 FOLLOWING)          AS max4,
  MIN(sal) OVER(ORDER by sal
                ROWS  BETWEEN 3 PRECEDING
                      AND     3 FOLLOWING)          AS min4
FROM emp;  
  



/******************************************************************************
Readability + Performance = Power
******************************************************************************/



SELECT
  deptno,
  job,
  COUNT(*) OVER(PARTITION BY deptno)          AS emp_cnt,
  COUNT(job) OVER(PARTITION BY deptno, job)   AS job_cnt,
  COUNT(*) OVER()                             AS total
FROM emp;


-- version with self join

SELECT
  a.deptno,
  a.job,
  (SELECT
    COUNT(*)
  FROM emp b
    WHERE b.deptno = a.deptno)  AS emp_cnt,
  (SELECT
    COUNT(*)
  FROM emp b
    WHERE a.deptno  = b.deptno
    AND   a.job     = b.job)    AS job_cnt,
  (SELECT
    COUNT(*)
  FROM emp)                     AS total
FROM emp a  
ORDER BY
  a.deptno,
  a.job;



/******************************************************************************
Providing a Base
******************************************************************************/

SELECT
  deptno,
  empt_cnt                            AS dept_total
  
            


FROM (SELECT
  deptno,
  job,
  COUNT(*) OVER(PARTITION BY deptno)          AS emp_cnt,
  COUNT(job) OVER(PARTITION BY deptno, job)   AS job_cnt,
  COUNT(*) OVER()                             AS total
FROM emp) x
GROUP BY
  deptno,
  empt_cnt,
  total;













