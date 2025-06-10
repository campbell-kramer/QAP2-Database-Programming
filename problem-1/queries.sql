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

INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('Ellen', 'Ripley', 'jonesy92@weylandyutani.com', '2120-06-03'),
('Arthur', 'Dallas', 'cpt_dallas@weylandyutani.com', '2120-06-03'),
('Joan', 'Lambert', 'babygirl99@weylandyutani.com', '2120-06-03'),
('Thomas', 'Kane', 'gilbertkane@weylandyutani.com', '2120-06-03'),
('Dennis', 'Parker', 'DParker80@weylandyutani.com', '2120-06-03');

INSERT INTO departments (department_name) VALUES
('Weyland-Yutani'),
('Seegson'),
('Walmart');

INSERT INTO professors (first_name, last_name, department_id) VALUES
('Peter', 'Weyland', 1),
('Hideo', 'Yutani', 1),
('Josiah', 'Sieg', 2),
('Sam', 'Walton', 3);

INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Space Mining 1001', 'Introductory course for space mining majors.', (SELECT professor_id FROM professors WHERE first_name = 'Hideo' AND last_name = 'Yutani')),
('Company Etiquette', 'Immerses students in proper behaviour and conduct while working for a corporation.', (SELECT professor_id FROM professors WHERE first_name = 'Peter' AND last_name = 'Weyland')),
('Deep Space Psychological Assessment', 'Trains and tests student ability to safely live in deep space for extended periods.', (SELECT professor_id FROM professors WHERE first_name = 'Josiah' AND last_name = 'Sieg'));

INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
((SELECT student_id FROM students WHERE first_name = 'Ellen' AND last_name = 'Ripley'), (SELECT course_id FROM courses WHERE course_name = 'Space Mining 1001'), '2120-08-18'),
((SELECT student_id FROM students WHERE first_name = 'Joan' AND last_name = 'Lambert'), (SELECT course_id FROM courses WHERE course_name = 'Company Etiquette'), '2120-08-30'),
((SELECT student_id FROM students WHERE first_name = 'Thomas' AND last_name = 'Kane'), (SELECT course_id FROM courses WHERE course_name = 'Deep Space Psychological Assessment'), '2120-09-01'),
((SELECT student_id FROM students WHERE first_name = 'Arthur' AND last_name = 'Dallas'), (SELECT course_id FROM courses WHERE course_name = 'Company Etiquette'), '2120-07-29'),
((SELECT student_id FROM students WHERE first_name = 'Dennis' AND last_name = 'Parker'), (SELECT course_id FROM courses WHERE course_name = 'Space Mining 1001'), '2120-08-25');

SELECT first_name || ' ' || last_name AS full_name FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN courses ON courses.course_id = enrollments.course_id
WHERE courses.course_name = 'Space Mining 1001';

SELECT 
    courses.course_name,
    professors.first_name || ' ' || professors.last_name AS professor_full_name
FROM courses
JOIN professors ON courses.professor_id = professors.professor_id;

SELECT DISTINCT course_name FROM courses
JOIN enrollments ON courses.course_id = enrollments.course_id;
