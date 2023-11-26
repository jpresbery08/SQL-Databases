--3.3--
--A--

SELECT id, name, dept_name, salary * 1.1
FROM instructor
WHERE dept_name = 'Comp. Sci.';


---B---
DELETE FROM course 
WHERE course_id not in (SELECT course_id
					    FROM section);

--C--
ALTER TABLE instructor
DROP CONSTRAINT instructor_salary_check, 
ADD CONSTRAINT instructor_salary_check CHECK (
	salary >= 10000)

INSERT INTO instructor (id, name, dept_name, salary)
SELECT st.id, st.name, st.dept_name, '10000'
FROM student AS st
WHERE st.tot_cred > 100;


