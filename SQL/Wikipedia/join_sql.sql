/******************************************************************************
Wikipedia SQL Join webpage
https://www.wikiwand.com/en/Join_(SQL)
******************************************************************************/

DROP TABLE IF EXISTS department;

CREATE TABLE department
(
  DepartmentID    INT Primary key,
  DepartmentName  VARCHAR(20)
);

DROP TABLE IF EXISTS employee;

CREATE TABLE employee
(
  LastName      VARCHAR(20),
  DepartmentID  INT references department(DepartmentID)
);


-- Populate the department table
INSERT INTO department VALUES (31, 'Sales');
INSERT INTO department VALUES (33, 'Engineering');
INSERT INTO department VALUES (34, 'Clerical');
INSERT INTO department VALUES (35, 'Marketing');


-- Populate the employee table
INSERT INTO employee
VALUES
('Rafferty',    31),
('Jones',       33),
('Heisenberg',  33),
('Robinson',    34),
('Smith',       34),
('Williams',    NULL);

/******************************************************************************
CROSS JOIN
******************************************************************************/

-- explicit
SELECT 
  *
FROM employee
CROSS JOIN department
ORDER BY 
  department.DepartmentID,
  employee.DepartmentID;  


SELECT
  LastName,
  DepartmentID,
  DepartmentName,
  department_departmentID
FROM (SELECT 
        e.LastName,
        e.DepartmentID,
        d.DepartmentName,
        d.DepartmentID  AS department_departmentID,
        CASE  WHEN e.departmentid IS NULL 
                THEN 0
              ELSE 1
        END AS is_null
    FROM employee e
    CROSS JOIN department d) x
ORDER BY
  department_departmentID,
  is_null DESC,
  departmentID;


-- implicit
SELECT 
  *
FROM employee, department
ORDER BY 
  department.DepartmentID,
  employee.DepartmentID;  
  
  
/******************************************************************************
INNER JOIN
******************************************************************************/  
-- I will try to always use the explicit form of the joins to maintain clarity

SELECT
  e.LastName,
  e.DepartmentID,
  d.DepartmentName
FROM employee e
INNER JOIN department d
    ON e.DepartmentID = d.DepartmentID;

/******************************************************************************
LEFT OUTER JOIN
******************************************************************************/

SELECT *
FROM employee e
LEFT OUTER JOIN department d
    ON e.departmentid = d.departmentid;
    
    
/******************************************************************************
RIGHT OUTER JOIN
******************************************************************************/        
  
SELECT *
FROM employee e
RIGHT OUTER JOIN department d
    ON e.departmentid = d.departmentid;  
  
/******************************************************************************
FULL OUTER JOIN
******************************************************************************/          
-- Full outer join is not supported in MySQL
SELECT *
FROM employee e
LEFT OUTER JOIN department d
    ON e.departmentid = d.departmentid

UNION
  
SELECT *
FROM employee e
RIGHT OUTER JOIN department d
    ON e.departmentid = d.departmentid;
  
  
  
  
  
  
  
  
  
  