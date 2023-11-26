--- Bank Database Schema ---

CREATE TABLE branch
(
	branch_name varchar(35) NOT NULL,
	branch_city varchar(35) NOT NULL,
	assets numeric(12,2) NOT NULL,
	CONSTRAINT branch_pkey PRIMARY KEY(branch_name)
);

CREATE TABLE customer
(
	ID varchar(8) NOT NULL,
	customer_name varchar(50) NOT NULL,
	customer_street varchar(50) NOT NULL,
	customer_city varchar(50) NOT NULL,
	CONSTRAINT customer_pkey PRIMARY KEY(ID)
);

CREATE TABLE loan 
(
	loan_number varchar(50) NOT NULL,
	branch_name varchar(35) NOT NULL,
	amount numeric(12,2) CHECK (amount > 0),
	CONSTRAINT loan_pkey PRIMARY KEY(loan_number),
	CONSTRAINT loan_fkey FOREIGN KEY(branch_name)
		REFERENCES branch (branch_name)
);

CREATE TABLE borrower
(
	ID varchar(50),
	loan_number varchar(50) NOT NULL,
	CONSTRAINT borrower_pkey PRIMARY KEY (ID, loan_number),
	CONSTRAINT borrower_fkey1 FOREIGN KEY(ID)
		REFERENCES customer(ID),
	CONSTRAINT borrower_fkey2 FOREIGN KEY(loan_number)
		REFERENCES loan(loan_number)
);

CREATE TABLE account
(
	account_number varchar(25) NOT NULL,
	branch_name varchar(35),
	balance numeric (12,2) DEFAULT '0.00',
	CONSTRAINT account_pkey PRIMARY KEY (account_number),
	CONSTRAINT account_fkey FOREIGN KEY (branch_name)
		REFERENCES branch (branch_name)
		--ON DELETE CASCADE
		--ON UPDATE CASCADE
);

CREATE TABLE depositor
(
	ID varchar(50),
	account_number varchar(25),
	CONSTRAINT deposit_pkey PRIMARY KEY(ID,  account_number),
	CONSTRAINT deposit_fkey1 FOREIGN KEY (ID)
		REFERENCES customer(ID),
	CONSTRAINT deposit_fkey2 FOREIGN KEY(account_number)
		REFERENCES account (account_number)
);
--- Depositor ID is the customer ID so that is the foreign key
--- Borrower IDis the cutomer id so the customer id will be the foreign key
--- Put casade in borrower because it will correspond too Loan table
--- Do a check for the balance in the ACCOUNT table
--- Foreign key only needed for borrower which is the loan_number
--- Foregin key needed for depositor which is account nummber
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---Queries Questions---

---a. Find the ID and customer name of each customer at the bank who has an account but not a loan---

---set operations for a,b,c INTERSECT, UNION, EXECEPT
	SELECT DISTINCT depositor.ID, customer_name
	FROM depositor, customer
	EXCEPT
	SELECT borrower.ID, customer_name
	FROM borrower, customer;
	

---b. Find the ID and customer name of each customer at the bank who only has a loan at the bank, and no account. 

	SELECT DISTINCT borrower.ID, customer_name
	FROM borrower, customer
	EXCEPT
	SELECT depositor.ID, customer_name
	FROM depositor, customer;

---c. Find the ID and customer name of each customer at the bank who has a loan and an account at the bank.

	SELECT borrower.ID, customer_name
	FROM borrower, customer
	UNION
	SELECT depositor.ID, customer_name
	FROM depositor, customer;


---d. Find the ID and customer name of each customer who lives on the same street and in the same city as customer ‘12345’.
	
	SELECT ID, customer_name
	FROM customer
	WHERE customer_street AND customer_city = (SELECT ID, customer_name, customer_street, customer_city
									 						  FROM customer
									 						  WHERE ID = '12345');

--e. Find the name of each branch that has at least one customer who has an account in the bank and who lives in “Harrison”.
	SELECT DISTINCT branch_name
	FROM account NATURAL JOIN customer NATURAL JOIN depositor
	WHERE customer_city = 'Harrison';			

---f. Find each customer who has an account at every branch located in “Brooklyn”.


SELECT customer_name
FROM depositor,customer
WHERE depositor.ID = customer.ID (SELECT branch_name
			  FROM branches
			  WHERE branches_city = 'Brooklyn')EXCEPT(SELECT customer_name, ID
											   FROM depositor NATURAL JOIN accounts);				

	
						
---g. Find the total sum of all loans in the bank.

	SELECT SUM(amount)
	FROM loan;
	
---h. Find the names of all branches that have assets greater than those of at least one branch located in “Brooklyn”.

	 SELECT branch_name
	 FROM branch
	 WHERE assets > SOME(SELECT assets
					 	 FROM branch
  					   	 WHERE branch_city = 'Brooklyn');
	
--------------------------------------------------Part ll--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				
	---2. Using the university schema, write a SQL query to find the names and ID of each History student whose name begins with the letter ‘D’ and who has not taken at least five Music courses.

						
						
						
---3. Using the university schema, write a SQL query to find the number of students in each section.  The result columns should appear in the order “courseid, secid, year, semester, num”.  You do not need to output sections with 0 students.
	
	SELECT COUNT(id) AS num, course_id, sec_id, year, semester
	FROM student JOIN takes using(id)
	HAVING course_id, sec_id, year, semester, num
	

---4. Using the university schema, write a SQL query to find the ID and name of each instructor who has never taught a course at the university.  Do this using no subqueries and no set operations (use an outer join).

	SELECT id, name, course_id
	FROM instructor NATURAL LEFT OUTER JOIN teaches
	WHERE course_id is null;
	
---5 Outer join expressions can be computed without using the OUTER JOIN operation.  Rewrite the following queries without using the OUTER JOIN expression.

--SELECT * FROM instructor NATURAL LEFT OUTER JOIN teaches
	SELECT *
	FROM instructor JOIN teaches ON instructor.id = teaches.id
--SELECT * FROM instructor NATURAL FULL OUTER JOIN teaches
	SELECT *
	FROM instructor NATURAL JOIN teaches
					
						
						