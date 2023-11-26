CREATE TABLE employees
(
	employee_id varchar(25) NOT NULL,
	first_name varchar(25),
	last_name varchar(25),
	email varchar(25),
	phone_number varchar(25),
	date_hired date NOT NULL,
	salary money,
	CONSTRAINT emp_pkey PRIMARY KEY(employee_id)
);



CREATE TABLE job
(
	job_id varchar(25) NOT NULL,
	job_title varchar(25),
	min_salary money,
	max_salary money,
	CONSTRAINT job_pkey PRIMARY KEY(job_id)
);

CREATE TABLE dependents
(
	dependent_id varchar(25) NOT NULL,
	first_name varchar(25) NOT NULL,
	last_name varchar(25) NOT NULL,
	relationship varchar(25),
	CONSTRAINT dep_pkey PRIMARY KEY(dependent_id)

);

CREATE TABLE departments
(
	department_id varchar(25)NOT NULL,
	department_name varchar(25),
	CONSTRAINT dept_pkey PRIMARY KEY(department_id)
);

CREATE TABLE locations
(
	location_id varchar(25) NOT NULL,
	street_address varchar(25) NOT NULL,
	postal_code varchar(25) NOT NULL,
	city varchar(25) NOT NULL,
	state_province varchar(25) NOT NULL,
	CONSTRAINT loc_pkey PRIMARY KEY(location_id)
);

CREATE TABLE countries
(
	country_id varchar(25) NOT NULL,
	country_name varchar(25) NOT NULL,
	region_id varchar(25) NOT NULL,
	CONSTRAINT country_pkey PRIMARY KEY(country_id),
	CONSTRAINT country_fkey FOREIGN KEY(region_id)
		REFERENCES regions(region_id) MATCH SIMPLE
);

CREATE TABLE regions 
(
	region_id varchar(25)NOT NULL,
	region_name varchar(25),
	CONSTRAINT region_pkey PRIMARY KEY(region_id)
);

----------------------------------------RELATIONSHISPS OF ENTITES------------------------------------------

CREATE TABLE emp_job
(
	employee_id varchar(25) NOT NULL,
	job_id varchar(25) NOT NULL,
	CONSTRAINT emp_job_pkey PRIMARY KEY(employee_id, job_id),
	CONSTRAINT emp_job_fkey1 FOREIGN KEY(employee_id)
		REFERENCES employees(employee_id) MATCH SIMPLE,
	CONSTRAINT emp_job_fkey2 FOREIGN KEY(job_id)
		REFERENCES job(job_id) MATCH SIMPLE
);

CREATE TABLE manages
(
	managee_id varchar(25),
	manager_id varchar(25), 
	CONSTRAINT manages_pkey PRIMARY KEY (managee_id, manager_id),
	CONSTRAINT manages_fkey1 FOREIGN KEY (managee_id) 
		REFERENCES employees (employee_id) MATCH SIMPLE,
	CONSTRAINT manages_fkey2 FOREIGN KEY (manager_id)
		REFERENCES employees (employee_id) MATCH SIMPLE
);

CREATE TABLE dep_emp
(
	employee_id varchar(25) NOT NULL,
	dependent_id varchar(25) NOT NULL,
	CONSTRAINT dep_emp_pkey PRIMARY KEY (employee_id, dependent_id),
	CONSTRAINT dep_emp_fkey1 FOREIGN KEY (employee_id)
		REFERENCES employees (employee_id) MATCH SIMPLE,
	CONSTRAINT dep_emp_fkey2 FOREIGN KEY (dependent_id)
		REFERENCES dependents(dependent_id) MATCH SIMPLE
);

CREATE TABLE emp_dept
(
	employee_id varchar(25) NOT NULL,
	department_id varchar(25) NOT NULL,
	CONSTRAINT emp_dept_pkey PRIMARY KEY (employee_id, department_id),
	CONSTRAINT emp_dept_fkey1 FOREIGN KEY (employee_id)
		REFERENCES employees (employee_id) MATCH SIMPLE,
	CONSTRAINT emp_dept_fkey2 FOREIGN KEY (department_id)
		REFERENCES departments(department_id) MATCH SIMPLE
);

CREATE TABLE dept_locate
(
	department_id varchar(25) NOT NULL,
	location_id varchar(25) NOT NULL,
	CONSTRAINT dept_locate_pkey PRIMARY KEY (department_id, location_id),
	CONSTRAINT dept_locate_fkey1 FOREIGN KEY (department_id)
		REFERENCES departments(department_id) MATCH SIMPLE,
	CONSTRAINT dept_locate_fkey2 FOREIGN KEY (location_id)
		REFERENCES locations(location_id) MATCH SIMPLE
);

CREATE TABLE locate_country
(
	location_id varchar(25) NOT NULL,
	country_id varchar(25) NOT NULL,
	CONSTRAINT locate_country_pkey PRIMARY KEY (location_id, country_id),
	CONSTRAINT locate_country_fkey1 FOREIGN KEY (location_id)
		REFERENCES locations(location_id) MATCH SIMPLE,
	CONSTRAINT locate_country_fkey2 FOREIGN KEY (country_id)
		REFERENCES countries(country_id) MATCH SIMPLE
);



