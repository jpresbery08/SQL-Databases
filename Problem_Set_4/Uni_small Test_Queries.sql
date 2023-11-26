SELECT AVG(salary) AS avg_salary , dept_name
FROM instructor
WHERE salary BETWEEN 80000 AND 90000
GROUP BY (dept_name);