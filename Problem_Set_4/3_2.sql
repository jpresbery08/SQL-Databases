--drop table grade_points
---Problem 3.2---
CREATE TABLE grade_points
(
	grade varchar(4),
	points numeric(3,2),
	CONSTRAINT grade_points_pkey PRIMARY KEY(grade)
);

	INSERT INTO grade_points (grade, points)
	VALUES ('A', 4.0),
	 	   ('A-', 3.7),
		   ('B+', 3.3),
		   ('B-', 2.7),
	 	   ('C+', 2.3),
		   ('C', 2.0),
	 	   ('C-', 1.7),
	 	   ('D+', 1.3),
	 	   ('D', 1.0),
		   ('D-', 0.7),
		   ('F', 0.0);

--Part A--
SELECT SUM (gp.points * co.credits) AS tot_gp
FROM takes AS ta, grade_points AS gp, course AS co
WHERE ta.id = '12345' AND ta.grade = gp.grade AND ta.course_id = co.course_id;						  
---Part B---

SELECT SUM (gp.points * co.credits) / SUM(co.credits) AS gpa
FROM takes AS ta, grade_points AS gp, course AS co
WHERE ta.id = '12345' AND ta.grade = gp.grade AND ta.course_id = co.course_id;	

---Part C---

SELECT ta.id, SUM (gp.points * co.credits) / SUM(co.credits) AS gpa
FROM takes AS ta, grade_points AS gp, course AS co
WHERE ta.grade = gp.grade AND ta.course_id = co.course_id
GROUP BY ta.id;	







	