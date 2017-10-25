/******************************************************************************

******************************************************************************/


/*
E1.   Who takes (the course with the course number) CS112? (By "Who" we mean 
that we want the student numbers retrieved.  If we want the names retrieved, we
will explicitly say so.)
*/

SELECT * FROM take;

SELECT  sno
FROM  take
  WHERE (Cno = 'CS112');

/*
E2.   What are student numbers and names of students who take CS112?
*/

SELECT  a.sno,
        b.sname
FROM        take a
INNER JOIN  student b
    ON a.sno = b.sno
  WHERE (a.Cno = 'CS112');



/*
E3.   Who takes CS112 or CS114? 
*/

/*
E4.   Who takes both CS112 and CS114?
*/

/*
E5.   Who does not take CS112?
*/

/*
E6.   Who takes a course which is not CS112?
*/

/*
E7.   Who takes at least 2 courses (i.e., at least 2 courses with different
course numbers)? (A more general question: Who takes at least 3, 4, 5, etc.,
courses?)
*/

/*
E8.   Who takes at most 2 courses? (More generally: 3, 4, 5, etc., courses?)
*/

/*
E9.   Who takes exactly 2 courses? (More generally: 3, 4, 5, etc., courses?)
*/

/*
E10.  Who takes only CS112?
*/

/*
E11.  Who takes either CS112 or CS114?
*/

/*
E12.  Who are the youngest students? (Similarly, Who are the oldest students?)
*/

/*
E13.  Who takes every course?
*/