-- Part a. "Find the titles of courses in the Comp. Sci. department that have 3 credits."
	SELECT title
	FROM course
	WHERE dept_name = 'Comp. Sci.' and credits = 3;
-- Part b. "Find the IDs of all students who were taught by an instructor named Einstein.
-- Make sure there are no duplicates in the result"
	SELECT DISTINCT id
	FROM takes AS TA
	WHERE (TA.course_id, TA.sec_id, TA.semester, TA.year) IN (SELECT TE.course_id, TE.sec_id, TE.semester, TE.year
															  FROM teaches AS TE
												 			  WHERE id = (SELECT id
															 			  FROM instructor
															              WHERE name = 'Einstein'));
-- Part c. "Find the highest salary of any instructor."
	SELECT MAX (salary)
	FROM instructor;
-- Part d. "Find all instructors earning the highest salary (there may be more than one with the same salary)."
		SELECT * 
		FROM instructor
		WHERE salary = (SELECT MAX (salary)
						FROM instructor);
-- Part e. "Find the enrollment of each section that was offered in Spring 2010."
	SELECT COUNT(DISTINCT id), course_id, sec_id, semester, year
	FROM takes
	WHERE semester = 'Spring' and year = '2010'
	GROUP BY (course_id, sec_id, semester, year)

