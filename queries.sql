create database course_management;   ---creating the database
create schema course_management;     ---creating schema
create table course_management.students(
student_id int not NULL,
first_name varchar(50)not NULL,
last_name varchar(50)not NULL,
email varchar(50)not NULL,
date_of_birth date not NULL,
primary key(student_id)

);   

CREATE TABLE course_management.instructors( ----creating table instructors
instructor_id int NOT NULL ,
first_name varchar(50)NOT NULL,
last_name varchar(50)NOT NULL,
email varchar(50)NOT NULL,
primary key(instructor_id)
);

CREATE TABLE course_management.courses(                 --- creatimg table courses
course_id int NOT NULL,
course_name varchar(50) NOT NULL,
course_description text NOT NULL,

primary key(course_id),
instructor_id int,
foreign key(instructor_id) references course_management.instructors(instructor_id) on delete cascade

);

create table course_management.enrollments(                                     ----ctreating table enrollments
enrollment_id int NOT NULL,
student_id int NOT NULL,
foreign key(student_id) references course_management.students(student_id) on delete cascade,
course_id int NOT NULL,
foreign key(course_id) references course_management.courses(course_id) on delete cascade,
enrollment_date date NOT NULL,
my_grade char(1) not Null, 
primary key(enrollment_id)

);

INSERT INTO course_management.students                ---inserting values to table students
    (student_id, first_name, last_name, email, date_of_birth) 
VALUES                                                         ----actual values
    (1, 'Winnie', 'Jemutai', 'jemutai5@gmail.com', '2005-12-20'),
    (2, 'Nicodemus', 'Koech', 'nicode@gmail.com', '2000-10-20'),
    (3, 'Glenda', 'Jerono', 'glendah5@gmail.com', '2002-04-12'),
    (4, 'Brandon', 'Albert', 'brandon5@gmail.com', '1996-09-12'),
    (5, 'Julian', 'Alvarez', 'julian5@gmail.com', '2004-02-13'),
    (6, 'Nicole', 'Kerubo', 'nicole5@gmail.com', '2003-02-10'),
    (7, 'Precious', 'Brown', 'precious5@gmail.com', '2007-05-22'),
    (8, 'Justine', 'Blue', 'blue5@gmail.com', '1999-06-14'),
    (9, 'Nico', 'Williams', 'williams5@gmail.com', '2000-07-14'),
    (10, 'Bukayo', 'Saka', 'gianna@gmail.com', '1996-08-14');
select*from course_management.students;


insert into course_management.instructors(instructor_id,first_name,last_name,email) ----inseting to table instructors
values(101,'john','smith','smith001@gmail.com'),                                     --actual values
     (102,'Grace','wainaina','grace1@gmail.com'),
     (103,'benard','smith','benard45@gmail.com');
select*from course_management.instructors;

insert into course_management.courses(course_id,course_name,course_description,instructor_id)--inserting into table courses
values(201,'web_development','Learning HTML, CSS, JavaScript, and backend frameworks',101),
      (202,'Data science','learning phyton,using tools like excel,power bi,',101),
      (203,'Artificial Intelligence', 'Fundamentals of AI, machine learning, and deep learning.', 102),
      (204,'Cyber Security', 'Explore encryption, hacking techniques, and security protocols.', 103),
      (205,'Block chain','involes learning cryptography,distributed systems and decentalized networks.',102);
select*from course_management.courses;

insert into course_management.enrollments(enrollment_id,student_id,course_id,enrollment_date,my_grade) --inserting the values into the enrollment table
VALUES                                                   ----actual values
    (301,1,201,'2025-05-04','A'),
    (302,2,202,'2025-05-05','B'),
    (303,2,203,'2025-06-05','A'),
    (304,3,204,'2025-05-04','C'),
    (305,2,205,'2025-04-09','F'),
    (306,4,205,'2025-04-20','B'),
    (307,5,201,'2025-04-22','D'),
    (308,6,203,'2025-04-20','F'),
    (309,7,201,'2025-04-20','B'),
    (310,8,202,'2025-04-20','F'),
    (311,8,205,'2025-04-20','A'),
    (312,2,204,'2025-04-20','D'),
    (313,6,204,'2025-04-20','A'),
    (314,5,205,'2025-04-20','A'),
    (315,4,202,'2025-04-20','B'); 
select*from course_management.enrollments;

----SQL QUERIES
---student enrolled in atleast one course.
select distinct student_id,first_name,last_name
from course_management.students 
where student_id in(select student_id from course_management.enrollments);

---student enrolled in more than 2 courses

SELECT s.student_id, s.first_name, s.last_name,
COUNT(e.course_id) AS total_courses  ----Counts how many courses each student is enrolled in.
FROM course_management.enrollments e
JOIN course_management.students s ON e.student_id = s.student_id ---Links students to their enrollment records
GROUP BY s.student_id, s.first_name, s.last_name    ----Groups students together to calculate their enrollments.
HAVING COUNT(e.course_id) > 2;   ----Filters only students with more than two courses.

---courses with total enrolled students
SELECT c.course_id, c.course_name,
COUNT(e.student_id) AS total_students  -----Counts how many students have enrolled in each course.
FROM course_management.courses c
LEFT JOIN course_management.enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;   ----Groups by course ID and name to get the total enrollments per course.

---average grade per course
SELECT 
    c.course_id, 
    c.course_name, 
    AVG                                               ---calculates the average numeric grade per course
    (CASE 
        WHEN e.my_grade = 'A' THEN 4
        WHEN e.my_grade = 'B' THEN 3
        WHEN e.my_grade = 'C' THEN 2
        WHEN e.my_grade = 'D' THEN 1
        WHEN e.my_grade = 'F' THEN 0
        ELSE NULL
    END) AS average_grade
FROM course_management.enrollments e
JOIN course_management.courses c ON e.course_id = c.course_id     ---links courses to enrollments
GROUP BY c.course_id, c.course_name;  -----ensures we get an average for each course.

---students who haven't enroled in any course
SELECT s.student_id, s.first_name, s.last_name, s.email
FROM course_management.students s
LEFT JOIN course_management.enrollments e ON s.student_id = e.student_id ---ensures all students are included, even those without enrollments.
WHERE e.student_id IS NULL;---filters only students who don’t appear in the enrollments table.

---students with their average grade across all courses
SELECT 
    s.student_id, 
    s.first_name, 
    s.last_name, 
    AVG(CASE                                       ---computes each student's average grade.
        WHEN e.my_grade = 'A' THEN 4
        WHEN e.my_grade = 'B' THEN 3
        WHEN e.my_grade = 'C' THEN 2
        WHEN e.my_grade = 'D' THEN 1
        WHEN e.my_grade = 'F' THEN 0
        ELSE NULL
    END) AS average_grade
FROM course_management.students s
JOIN course_management.enrollments e ON s.student_id = e.student_id   ---links student data with their enrollments.
GROUP BY s.student_id, s.first_name, s.last_name;                    ----ensures we get individual averages.


---instructors with the number of courses they teach
SELECT 
    i.instructor_id, 
    i.first_name, 
    i.last_name, 
    COUNT(c.course_id) AS total_courses                     ----counts the number of courses each instructor teaches.
FROM course_management.instructors i
LEFT JOIN course_management.courses c ON i.instructor_id = c.instructor_id    ----ensures all instructors appear,
GROUP BY i.instructor_id, i.first_name, i.last_name; ----groups results by instructors to get individual totals.

---students enrolled in a course taught by 'john smith'
SELECT s.student_id, s.first_name, s.last_name, s.email, c.course_name
FROM course_management.students s
JOIN course_management.enrollments e ON s.student_id = e.student_id
JOIN course_management.courses c ON e.course_id = c.course_id
JOIN course_management.instructors i ON c.instructor_id = i.instructor_id
WHERE i.first_name = 'John' AND i.last_name = 'Smith';

---top 3 students by average grade

SELECT 
    s.student_id, 
    s.first_name, 
    s.last_name, 
    AVG                                       ---compute each student's average grade
    (CASE 
        WHEN e.my_grade = 'A' THEN 4               ---for numerical calculations
        WHEN e.my_grade = 'B' THEN 3
        WHEN e.my_grade = 'C' THEN 2
        WHEN e.my_grade = 'D' THEN 1
        WHEN e.my_grade = 'F' THEN 0
        ELSE NULL
    END) AS average_grade
FROM course_management.students s
JOIN course_management.enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY average_grade desc                                           ----Sorts students in descending order
LIMIT 3;                                                              ---give you the three students with the highest average grades


----students failing (grade='F') in 1 or more than 1 course
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS failed_courses
FROM course_management.students s
JOIN course_management.enrollments e ON s.student_id = e.student_id
WHERE e.my_grade = 'F'                                                  ---Filters students who have at least one failing grade
GROUP BY s.student_id, s.first_name, s.last_name                        ---Groups students by ID and name
HAVING COUNT(e.course_id) >= 1;                                         ---ensures students with atleast 1 student appear.

---advanced sql queries
---creating a view named student_course summary

CREATE VIEW student_course_summary as                      ---Stores results as a view
SELECT 
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,   ---Concatenates first and last name
    c.course_name AS course,
    e.my_grade AS grade
FROM course_management.students s
JOIN course_management.enrollments e ON s.student_id = e.student_id ---Joins students, enrollments, and courses to link relevant information.
JOIN course_management.courses c ON e.course_id = c.course_id;

SELECT * FROM student_course_summary;

----adding an index on enrollments .student_id
CREATE INDEX idx_enrollments_student                           ---Defines a new index 
ON course_management.enrollments(student_id);                  ---Creates index on the student_id column of the enrollments table.

SELECT * FROM pg_indexes WHERE tablename = 'enrollments';       ---viewing indexes on a table.

---create a trigger
---step 1 creating log
CREATE TABLE course_management.enrollment_log (
    log_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action TEXT
);
---step 2 Creating a Trigger Function
CREATE OR REPLACE FUNCTION log_enrollment()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO course_management.enrollment_log (student_id, course_id, action)
    VALUES (NEW.student_id, NEW.course_id, 'New Enrollment');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--- step 3 creating a trigger
CREATE trigger enrollment_trigger
AFTER INSERT ON course_management.enrollments
FOR EACH ROW
EXECUTE FUNCTION log_enrollment();

----showing trigger

SELECT trigger_name, event_manipulation, event_object_table, action_statement
FROM information_schema.triggers
WHERE event_object_schema = 'course_management';

















