#STUDENT MANAGEMENT SYSTEM 
---
A comprehensive SQL-based system for managing students, instructors, courses, enrollments, and academic insights.
---
##OVERVIEW

A SQL-based database system designed to manage students, courses, instructors, enrollments, and academic performance, providing insightful queries
and optimized relational structures.
 
##Requirements
---

Before running the SQL code, ensure you have: 
✔️ A PostgreSQL/MySQL database system installed 
✔️ A SQL editor (e.g., pgAdmin, MySQL Workbench) 
✔️ Basic knowledge of SQL for executing scripts

  ## Installation Steps
  Clone the repository:

sh
git clone https://github.com/your-username/student-management-system.git
cd student-management-system
 
  Open the SQL editor and execute the schema file:

sql
\i schema_and_queries.sql

 ##UNDERSTANDING THE DATABASE STRUCTURE
 
  ##Core Tables & Relationships
This system is built using relational database principles ensuring structured and efficient data management.

  Table	   Purpose
---
🎓 students	Stores student records (ID, name, email, date of birth)
👨‍🏫 instructors	Tracks instructor details and course assignments
📚 courses	Contains course descriptions and assigned instructors
📝 enrollments	Links students to courses, including grades and registration dates
 # Database Integrity Features:
✔️ Primary keys ensure uniqueness 
✔️ Foreign keys establish relationships between tables
✔️ Cascading delete prevents orphan records 
✔️ Indexes enhance query speed
---
## SQL QUERIES & INSIGHTS
## Key Queries
---
These queries allow administrators and instructors to analyze student engagement and performance effectively.

### Students Currently Enrolled

sql
SELECT DISTINCT student_id, first_name, last_name 
FROM student_management.students 
WHERE student_id IN (SELECT student_id FROM student_management.enrollments);
Reveals students who are actively registered.

### Course Popularity Analysis

sql
SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM student_management.courses c
LEFT JOIN student_management.enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
Helps academic teams optimize course offerings.

 Instructor Load Report

sql
SELECT i.instructor_id, i.first_name, i.last_name, COUNT(c.course_id) AS total_courses
FROM student_management.instructors i
LEFT JOIN student_management.courses c ON i.instructor_id = c.instructor_id
GROUP BY i.instructor_id, i.first_name, i.last_name;
Identifies instructors managing multiple courses.

📸 SAMPLE OUTPUT DESCRIPTIONS
1️⃣ Students Enrolled in More Than Two Courses
🎓 student_id	🏷️ first_name	🏷️ last_name	📊 total_courses
1️⃣	Winnie	Jemutai	3️⃣
2️⃣	Nicodemus	Koech	4️⃣
2️⃣ Course Popularity Analysis
🏛️ course_id	📚 course_name	👨‍🎓 total_students
201	Web Development	8️⃣
202	Data Science	5️⃣


  CHALLENGES FACED & LESSONS LEARNED
  Designing efficient joins between tables required careful query optimization to prevent performance issues.

 Schema Design Considerations

✔ Foreign key constraints ensured data integrity
✔ Indexes optimized retrieval speed 
✔ Normalization reduced redundancy
---
 FUTURE ENHANCEMENTS

  Add user authentication for role-based access 
  Integrate an interactive dashboard for real-time updates 
  Automate alerts for struggling students based on performance data 
  Expand reporting features with advanced SQL analytics
