--3.6--

CREATE TABLE marks
(
	id varchar(20),
	score numeric,
	PRIMARY KEY(id),
	FOREIGN KEY marks_fkey (id)
		REFERENCES student(id)
);

update student
set 