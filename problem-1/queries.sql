CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    enrollment_date DATE
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name TEXT
);

CREATE TABLE professors (
	professor_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	department_id INT REFERENCES departments(department_id)
)

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name TEXT,
    course_description TEXT,
	professor_id REFERENCES professors(professor_id)
);

CREATE TABLE enrollments (
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    enrollment_date DATE
	PRIMARY KEY (student_id, course_id)
);
