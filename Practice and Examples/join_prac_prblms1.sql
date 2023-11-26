-- Write a select-from-where statement that computes the following:

-- "For all students in the university who have taken some course, find their names

-- and the course ID of all courses they took."

 SELECT name, course_id
 FROM student, takes
 WHERE student.id = takes.id;

-- The NATURAL JOIN operation considers only those pairs of tuples with the same value

-- on those attributes that appear in the schemas of both relations.

	SELECT *
	FROM student NATURAL JOIN takes;
               

-- Note: Duplicate attributes are not repeated.  Also note the order of attributes in

-- the results returned: First - Attributes common to both realtions.  Second - Attributes

-- unique to the first realtions.  Third - Attributes unique to the second relation.

 

-- The top query can be written more concisely using the natural join operation:

	SELECT name, course_id
	FROM student NATURAL JOIN takes;
	

-- Generally,

-- SELECT A1, A2, ..., An

-- FROM r1 NATURAL JOIN r2 NATURAL JOIN ... NATURAL JOIN rm

-- WHERE P;

 

-- Write a SQL query for the following:

-- "List the names of students along with the titles of courses that they have taken."

	SELECT name, title
	FROM student NATURAL JOIN takes, course
	WHERE takes.course_id = course.course_id;
               

-- The following query does NOT provide the same results, because it erroneously requires that

-- the dept_name attribute values from both relations se the same in addition to requiring that

-- course_id attribute values be the same.  Basically, it will omit tuples where a student takes

-- a course in a department other than his/her own department.

 

                SELECT name, title

                FROM student NATURAL JOIN takes NATURAL JOIN course;

 

-- To eradicate the issue of erroneously equating attributes:

 --SELECT *
--FROM section NATURAL JOIN instructor;

-- The ON condition allows a general predicate over the relations being joined.

-- The ON condition in the following query specifies that a tuple from student matches

-- a tuple from takes if their id values are equal.

 

-- Note that the above query duplicates the matching attribute.  A query to eliminate the duplicate

-- id attribute is given by:

 

--------------------- OUTER JOINS ----------------------

 

-- Suppose we wish to find a list of all students, displaying their id, name, dept_name

-- tot_cred, and the courses they have taken.  The following SQL query DOES NOT produce this result:

 

                SELECT *

                FROM student NATURAL JOIN takes;

 

-- The above query will leave out all students who have not taken any courses, such as the student named Snow.

-- OUTER JOIN operations work in a manner similar to the JOIN operation, but preserve those tuples that would be lost

-- in a join by creating tuples in the result containing null values.

 

-- There are three forms of OUTER JOIN:

-- 1) LEFT OUTER JOIN - preserves tuples only in the leftmost relation

-- 2) RIGHT OUTER JOIN - preserves tuples only in the rightmost relation

-- 3) FULL OUTER JOIN - preserves tuples in both relations

 

-- In contrast, the join operations that we studied earlier that do not preserve nonmatched tuples

-- are called inner-join operations.

 

-- So, to find a list of all students, displaying their id, name, dept_name

-- tot_cred, and the courses they have taken - we can use the following query:

               

-- Did the student "Snow" appear in the above query results?

 

-- Example: "Find all students who have not taken a course."

 

-- The query before last can be rewritten using a right outer join, where the order of attributes listed will be swapped: