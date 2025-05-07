Student Management System
A structured SQL-based system designed for tracking students, instructors, courses, enrollments, and academic performance efficiently.

  Project Overview
This project simulates a real-world academic database system, helping institutions organize student records, course enrollments, instructor assignments, and performance tracking.

Key Features:
✅ Student-course enrollments 
✅ Grade tracking and performance analysis 
✅ Instructor-course relationships 
✅ Automated deletion of dependent records using cascading foreign keys


Installation Steps
1️⃣ Clone the repository

sh
git clone https://github.com/your-username/student-management-system.git
cd student-management-system
2️⃣ Open the SQL editor 3️⃣ Execute the schema file

sql
\i schema_and_queries.sql
🧱 Understanding the Database Structure
Core Tables & Relationships
The system consists of four main tables that work together for seamless academic management:

Table	Purpose
students	Stores student records (ID, name, email, date of birth)
instructors	Tracks instructor information
courses	Contains course details and assigned instructors
enrollments	Links students to courses, storing grades & registration dates
Database Integrity
Primary keys ensure uniqueness

Foreign keys establish relationships between tables

Cascading delete prevents orphan records

Indexes enhance query speed
