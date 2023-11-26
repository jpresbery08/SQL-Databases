
---------------------------------------- Create Tables ----------------------------------------

	BEGIN;
		CREATE TABLE people
		(
			pname varchar(20) NOT NULL,
			dob date NOT NULL,
			address varchar(50),
			member_status varchar(10),
			CONSTRAINT people_pkey PRIMARY KEY (pname, dob),
			CONSTRAINT people_mem_stat CHECK (member_status IN ('Bronze', 'Silver', 'Gold'))
		);
	COMMIT;

	BEGIN;
		CREATE TABLE accounts
		(
			act_id varchar(9) NOT NULL,
			pname varchar(20) NOT NULL,
			dob date NOT NULL,
			balance money NOT NULL,
			CONSTRAINT accounts_pkey PRIMARY KEY (act_id),
			CONSTRAINT accounts_fkey FOREIGN KEY (pname, dob) REFERENCES people (pname,dob)
				--ON DELETE CASCADE
				--ON UPDATE CASCADE,
			CONSTRAINT accounts_min_balance CHECK (balance >= '250.00')
		);
	COMMIT;

	BEGIN;
		CREATE TABLE loans
		(
			loan_number varchar(9) NOT NULL,
			act_id varchar(9) NOT NULL,
			cosign_pname varchar(20) DEFAULT 'BANK_COSIGN',
			cosign_dob date NOT NULL DEFAULT '01/01/0001',
			principal money NOT NULL,
			rate numeric(3,2),
			CONSTRAINT loans_pkey PRIMARY KEY (loan_number),
			CONSTRAINT loans_fkey_1 FOREIGN KEY (act_id) REFERENCES accounts (act_id)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
			CONSTRAINT loans_fkey_2 FOREIGN KEY (cosign_pname, cosign_dob) REFERENCES people (pname, dob)
				ON DELETE SET DEFAULT
				ON UPDATE CASCADE
				DEFERRABLE INITIALLY IMMEDIATE
		);
	COMMIT;

---------------------------------------- Insert Values ----------------------------------------
	
	BEGIN;
		INSERT INTO people (pname, dob, address, member_status)
		VALUES ('Bob', '3/19/1954', '1300 Eagle Road', 'Gold');

		INSERT INTO people (pname, dob, address, member_status)
		VALUES ('Alice', '12/21/2000', '54 Rega Street', 'Bronze');
	COMMIT;
	
	BEGIN;
		INSERT INTO accounts (act_id, pname, dob, balance)
		VALUES ('123456789', 'Bob', '3/19/1954', '4201.54');

		INSERT INTO accounts (act_id, pname, dob, balance)
		VALUES ('987654321', 'Alice', '12/21/2000', '2305.69');
	COMMIT;
	
	-- More info about deferred constraints at: https://www.postgresql.org/docs/9.1/sql-set-constraints.html
	
	BEGIN;
		SET CONSTRAINTS loans_fkey_2 DEFERRED;

		INSERT INTO loans (loan_number, act_id, cosign_pname, cosign_dob, principal, rate)
		VALUES ('142536251', '987654321' , 'Hans', '11/05/1993', 6000.00, 4.25);

		INSERT INTO people (pname, dob, address, member_status)
		VALUES ('Hans', '11/05/1993', '563 Russell Road', NULL);
	COMMIT;
	
---------------------------------------- Alter Constraint ----------------------------------------
	
	ALTER TABLE accounts DROP CONSTRAINT accounts_min_balance;
	ALTER TABLE accounts ADD CONSTRAINT accounts_min_balance CHECK (balance >= '150.00');
	
---------------------------------------- Delete Tuples ----------------------------------------

	-- Below query will violate loans_fkey_2 constraint
	BEGIN;
		DELETE FROM people
		WHERE pname = 'Hans';
	COMMIT;
	
	-- Fix by either adding (BANK_COSIGN, 0001-01-01) to people first, or by deferring constraint
	-- Show how I can delete, but not commit:
	BEGIN;
		SET CONSTRAINTS loans_fkey_2 DEFERRED;
		
		DELETE FROM people
		WHERE pname = 'Hans';
	COMMIT;
	
	-- Correctly Implement:
	BEGIN;
		SET CONSTRAINTS loans_fkey_2 DEFERRED;
		
		DELETE FROM people
		WHERE pname = 'Hans';
		
		INSERT INTO people (pname, dob, address, member_status)
		VALUES ('BANK_COSIGN', '01/01/0001', 'BANK_LOCATION', NULL);
	COMMIT;
	























