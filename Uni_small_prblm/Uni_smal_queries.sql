SELECT * 
FROM instructor
WHERE salary > 65000;

SELECT dept_name 
FROM instructor;

SELECT DISTINCT dept_name 
FROM instructor;

---Find the names of all instructors whose salary is greater than at least one instructor in the Biology department---


SELECT DISTINCT T.name
FROM instructor AS T, instructor AS S 
WHERE T.salary > S.salary AND S.dept_name = 'Biology';

---Increase salary 10% which is .1
SELECT salary * 1.1 AS new_salary
FROM instructor;

---We can use these operators +, -, /, *---


