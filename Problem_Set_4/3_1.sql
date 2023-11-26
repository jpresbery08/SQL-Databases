-- Part a. "Find the titles of courses in the Comp. Sci. department that have 3 credits."
	SELECT title
	FROM course
	WHERE dept_name = 'Comp. Sci.'  AND credits = 3;

-- Part b. "Find the IDs of all students who were taught by an instructor named Einstein.
-- Make sure there are no duplicates in the result"
	
SELECT DISTINCT id 
FROM takes
WHERE (course_id, sec_id, semester, year) IN
	(SELECT course_id, sec_id, semester, year
	FROM teaches
	WHERE id =	(SELECT id
				FROM instructor
				WHERE name = 'Einstein'));

-- Part c. "Find the highest salary of any instructor."
	SELECT MAX(salary)
	FROM instructor;
-- Part d. "Find all instructors earning the highest salary (there may be more than one with the same salary)."
	SELECT *
	FROM instructor
	WHERE salary = (SELECT MAX(salary)
					FROM instructor);
-- Part e. "Find the enrollment of each section that was offered in Spring 2010."
	SELECT course_id, sec_id, semester, year, COUNT(DISTINCT id) AS enrollment
	FROM takes
	WHERE semester = 'Spring' AND year = 2010
	GROUP BY course_id, sec_id, semester, year
	ORDER BY enrollment DESC;
-- Part f. "Find the maximum enrollment, across all sections, in Spring 2010.
	SELECT MAX(enrollment)
	FROM 	(SELECT course_id, sec_id, semester, year, COUNT(DISTINCT id) AS enrollment
			FROM takes
			WHERE semester = 'Spring' AND year = 2010
			GROUP BY course_id, sec_id, semester, year
			ORDER BY enrollment DESC) AS foo;
	
	
-- Part g. "Find the sections that had the maximum enrollment in Spring 2010"

	SELECT MAX(enrollment)
	FROM 	(SELECT sec_id, semester, year, COUNT(DISTINCT id) AS enrollment
			FROM takes
			WHERE semester = 'Spring' AND year = 2010
			GROUP BY  sec_id, semester, year
			ORDER BY enrollment DESC) AS foo;
	

