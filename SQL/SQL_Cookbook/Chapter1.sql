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

SELECT  CONCAT(ename, ' works as a ', job) AS msg
FROM    emp
  WHERE deptno = 10
;

-- 1.8 Using Conditional Logic in a SELECT Statement

SELECT  ename,
        sal,
        CASE
          WHEN sal <= 2000 THEN 'UNDERPAID'
          WHEN sal >= 4000 THEN 'OVERPAID'
          ELSE                  'OK'
        END   AS status
FROM emp
;


-- 1.9 Limiting the Number of Rows Returned

SELECT  *
FROM    emp
LIMIT 5
;


