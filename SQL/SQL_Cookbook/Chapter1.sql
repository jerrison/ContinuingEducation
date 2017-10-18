USE mysql;

SELECT  *
FROM    EMP
	WHERE deptno = 10;
  
SELECT *
FROM emp
  WHERE   deptno = 10
  OR      comm IS NOT NULL
  OR      (sal <= 2000 AND deptno = 20)
;


SELECT  sal   AS salary,
        comm  AS commission
FROM emp
;


-- 1.6
SELECT *
FROM (
      SELECT  sal   AS salary,
              comm  AS commission
      FROM    emp
      ) x
  WHERE salary < 5000
;

-- 1.7 Concatenating Column Values