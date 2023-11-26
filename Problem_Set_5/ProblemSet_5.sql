---#1 Display a list of all instructors, showing each instructor's ID and the number of sections taught.  
--- Make sure to show the number of sections as 0 for instructors who have not taught any section.

	
	SELECT name, ID, COUNT(sec_id,course_id)
	FROM instructor NATURAL LEFT OUTER JOIN teaches 
	GROUP BY instructor.name, instructor.ID;	


--- #2 Display the list of all departments, with the total number of instructors in each department.

	SELECT dept_name, COUNT(ID) 
	FROM department NATURAL LEFT OUTER JOIN instructor
	GROUP BY dept_name;
--Group by function is confusing me on how to use and what it does

---3.Explain why appending “NATURAL JOIN section” in the from clause (i.e. after “student”) would not change the query results in the following query:

	SELECT course_id, semester, year, sec_id, avg(tot_cred)
	FROM takes natural join student
	WHERE year = 2009
	GROUP BY course_id, semester, year, sec_id
	HAVING COUNT (id) >= 2;
	
---#4 Rewrite the following query without using a natural join, but instead using an inner join with a USING condition:

		SELECT *
		FROM section NATURAL JOIN classroom;
		
		SELECT *
		FROM section,classroom
		WHERE section.building = classroom.building;
		
---#5 Find the ID and name of each student who has never taken a course at the university using an outer join.

	SELECT ID, name
	FROM student NATURAL LEFT OUTER JOIN takes
	WHERE course_id is NULL;

--#6 Show how to define a view tot_credits (year, num_credits), giving the total number of credits taken in each year 
---(for all students).  Note that your solution may assume that there is no year where students didn’t 
---take any course, even though sections were offered.



	CREATE VIEW tot_credits(year, num_credits) AS
	SELECT takes.year, sum(tot_cred)
	FROM student NATURAL LEFT OUTER JOIN takes
	GROUP BY year;



