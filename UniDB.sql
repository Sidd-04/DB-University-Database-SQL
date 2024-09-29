Create Database University;
Use University;   -- to use database we have created
Create table department(dept_name varchar(25) primary key,building varchar(20)  ,budget float(50));     -- creation of department table.
Insert into department values('CSE','9th block',200000);    -- insertion of value in to  dept table
Insert into department values('Mech','9th block',200000); 
select * from department;
create table instructor(id int(10),name varchar(20),dept_name varchar(25),Salary numeric(8,2),primary key(ID), foreign key(dept_name) references department(dept_name));   /* foreign key used for linking dept with another table dept*/
insert into instructor values(5001,'sidd','CSE',50000);
insert into instructor values(5002,'sidd2','Mech',60000);      -- adding more rows to the table instructor.
insert into instructor values(5003,'sidd3','CSE',70000);
insert into instructor values(5004,'sidd4','Mech',30000);  
select * from instructor;        -- to show instructor table we use this command
Alter table instructor Modify ID varchar(25) Not null;      
Alter table instructor Modify ID varchar(25) check(ID>=5000);      -- to make changes in the instructor table we'll use alter command and make changes.
Alter table instructor modify ID int(10) default(5005) ;
insert into instructor values(default,'sidd5','Mech','80000');    -- default used for value if we not provide anything in input
select * from instructor;

ALTER TABLE instructor MODIFY id int(10);
Alter table department add constraint chk check(budget>20000);   -- we can name constraint. like here we hv named chk
Alter table department drop constraint chk;           -- to delete constraint check.
-- Alter table instructor drop constraint Not null ID  ;
alter table Instructor alter salary set default 45000; 
/*Truncate command is used to remove all records from a table at once.*/
truncate table Instructor;      
select *from Instructor;

/*rename command can be used to rename tables and it's columns*/
rename table instructor to professor;    
select *from professor;
rename table professor to instructor;

/*Here we are using drop commands to drop constraints*/
-- alter table instructor drop constraint unique_ID;
alter table instructor modify dept_name varchar(25) null;
alter table instructor modify dept_name varchar(25);
-- alter table instructor drop constraint instructor_ibfk_1;
-- alter table instructor drop constraint check_1;
alter table instructor drop  primary key;
alter table instructor alter salary drop default;

update instructor set dept_name='Design' where Name='Sidd';

select distinct building from department order by building;  -- Here order by command sorts values in attribute 'building'. By default it is always sorted in ascending order.
select dept_name,building,budget from department order by budget;
select dept_name,building,budget from department order by dept_name,budget;  -- Here Order by command sorts multiple columns in ascending order.
select dept_name,building,budget from department order by budget asc,dept_name desc;
select * from department; 

/*Using AND and OR commands*/
select ID,Name,salary,dept_name from instructor where salary>55000 and ID>=400124; -- AND Command is uused to compare two relations and it gives result as true if and only if all statements are true.
select ID,Name,salary,dept_name from instructor where salary>55000 or ID>=400124; -- OR Commands gives Result True only if one of the statements is true.

select ID,Name,dept_name,salary from instructor where dept_name in ('CSE','Mech') or salary>50000;
select ID,Name,dept_name,salary from instructor where dept_name='Mech' and salary>50000;
select ID,Name,dept_name,salary from instructor where dept_name not in ('CSE','Mech','Civil','Law','Health Sciences');

select name,ID,salary from instructor where salary between 40000 and 60000;
select dept_name,budget from department where budget between 200000 and 300000;
select name,ID,salary from instructor where salary not between 40000 and 60000;

/*like command is used to search for a particular record and it's details in a table. It takes a substring which it uses to search in the table for the required record*/
select name,ID,dept_name from instructor where name like '%si%';
select name,ID,salary from instructor where name like '%sid%';
select name,ID,salary from instructor where name like 's%';

alter table instructor add column attendance varchar(3);
update instructor set attendance='93%' where ID=400129;
select *from instructor;

/*as command renames a table temporarily in the query's result set*/
select Dept_name,building,budget from department limit 3,6;
select concat('1','','2') as 'result';
select distinct T.name from instructor as T,instructor as S
where T.salary>S.salary and S.dept_name='CSE';
select distinct D.dept_name from department as D,department as F
where D.budget>F.budget and F.dept_name='CSE';

select * from department;
-- Aggregate function
select count(*) from department;
select max(budget) from department;
select dept_name,max(salary) from instructor group by dept_name;
select dept_name, max(budget) from department group by dept_name;
select count(building) from department;
select count(distinct building) from department;
select avg(budget) from department group by building;

-- select 1+2;  

select sum(building + budget) from department;
Select building, SUM(budget) FROM department GROUP BY building;

-- group by 
select building from department group by building;
select building,avg(budget) from department group by building;
-- having  use with group by -always use having not where with group by.
-- select *

-- ISNOT OR IS operator  used to deal with null values.
select dept_name,building from department where building is not NULL;
SELECT Dept_name FROM instructor GROUP BY Dept_name HAVING COUNT(*) < 3;
SELECT Dept_name FROM department GROUP BY Dept_name HAVING COUNT(*) < 1;


-- Null use with aggregate function.
select avg(budget) from department where building is not NULL;
select max(budget) from department where building is not NULL;
select count(*),building from department group by building having building is not NULL;


create table student (id int primary key, name varchar(50), dept_name varchar(25), tot_cred int, foreign key (dept_name) references department(dept_name));
create table advisor (s_id int, i_id int(10), primary key (s_id), foreign key (s_id) references student(id), foreign key (i_id) references instructor(id));
create table course (course_id int primary key, title varchar(20), dept_name varchar(25), credits int, foreign key (dept_name) references department(dept_name));
create table prereq (course_id int, prereq_id int, primary key (course_id, prereq_id), foreign key (course_id) references course(course_id), foreign key (prereq_id) references course(course_id));
create table section (course_id int, sec_id int, semester varchar(10), year int, building varchar(30), room_number int, time_slot_id int, primary key (course_id, sec_id, semester, year), foreign key (course_id) references course(course_id), foreign key (building, room_number) references classroom(building, room_number), foreign key (time_slot_id) references time_slot(time_slot_id));
create table classroom (building varchar(30), room_number int, capacity int, primary key (building, room_number));
create table teaches (id int, course_id int, sec_id int, semester varchar(10), year int, primary key (id, course_id, sec_id, semester, year), foreign key (id) references instructor(id), foreign key (course_id, sec_id, semester, year) references section(course_id, sec_id, semester, year));
create table takes (id int, course_id int, sec_id int, semester varchar(10), year int, grade char(2), primary key (id, course_id, sec_id, semester, year), foreign key (id) references student(id), foreign key (course_id, sec_id, semester, year) references section(course_id, sec_id, semester, year));
create table time_slot (time_slot_id int primary key, day varchar(10), start_time time, end_time time);

-- drop table if exists advisor, takes, teaches, section, prereq, course, time_slot, student, classroom;

-- insert into course values(5003,'CSE45','CSE',4);


-- Insert into the student table
INSERT INTO student (id, name, dept_name, tot_cred) 
VALUES (1, 'John Doe', 'CSE', 15);
INSERT INTO student (id, name, dept_name, tot_cred) 
VALUES (2, 'dee gee', 'CSE', 16);
INSERT INTO student (id, name, dept_name, tot_cred) 
VALUES (3, 'dee', 'CSE', 17);

-- Insert into the advisor table
INSERT INTO advisor (s_id, i_id) 
VALUES (1, 5003);

-- Insert into the course table
INSERT INTO course (course_id, title, dept_name, credits) 
VALUES (101, 'Programming', 'CSE', 4);
INSERT INTO course (course_id, title, dept_name, credits) 
VALUES (102, 'Programming', 'CSE', 4);
INSERT INTO course (course_id, title, dept_name, credits) 
VALUES (103, 'Programming', 'CSE', 4);
INSERT INTO course (course_id, title, dept_name, credits) 
VALUES (104, 'Programming', 'CSE', 4);

-- Insert into the prereq table
-- Assuming course_id 102 exists as a prerequisite
INSERT INTO prereq (course_id, prereq_id) 
VALUES (101, 102); 

-- Insert into the classroom table
INSERT INTO classroom (building, room_number, capacity) 
VALUES ('9th block', 101, 30);

-- Insert into the time_slot table
INSERT INTO time_slot (time_slot_id, day, start_time, end_time) 
VALUES (1, 'Monday', '09:00:00', '10:30:00');
INSERT INTO time_slot (time_slot_id, day, start_time, end_time) 
VALUES (2, 'Tuesday', '09:00:00', '12:30:00');

-- Insert into the section table
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) 
VALUES (101, 1, 'Fall', 2024, '9th block', 101, 1);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) 
VALUES (102, 2, 'odd', 2017, '9th block', 101, 1);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) 
VALUES (104, 4, 'odd', 2017, '9th block', 101, 1);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) 
VALUES (103, 3, 'even', 2018, '9th block', 101, 1);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) 
VALUES (103, 3, 'odd', 2017, '9th block', 101, 1);


-- Insert into the teaches table
INSERT INTO teaches (id, course_id, sec_id, semester, year) 
VALUES (5004, 101, 1, 'Fall', 2024);

-- Insert into the takes table
INSERT INTO takes (id, course_id, sec_id, semester, year, grade) 
VALUES (1, 101, 1, 'Fall', 2024, 'A');
INSERT INTO takes (id, course_id, sec_id, semester, year, grade) 
VALUES (2, 102, 2, 'odd', 2017, 'A');
INSERT INTO takes (id, course_id, sec_id, semester, year, grade) 
VALUES (3, 103, 2, 'even', 2018, '8');


-- find the id of the instructor and course id of the instructor who have taught some course.   teaches table.
-- find the name of instructor and course id of the instructor who have taught some course in cse department . 
-- delete all the tuple in the instructor for the instructor associated with building located in 9th block.
-- Increase the salary of instructor by 5 percent who have the salary less then average salary.

SELECT instructor.id, teaches.course_id 
FROM instructor, teaches
WHERE instructor.id = teaches.id;

SELECT instructor.name, teaches.course_id 
FROM instructor, teaches
WHERE instructor.id = teaches.id
AND instructor.dept_name = 'CSE';

SELECT * 
FROM instructor
WHERE dept_name IN (SELECT dept_name FROM department WHERE building = '9th block');

set sql_safe_updates=0;
Delete from instructor where dept_name in(select dept_name from department where building='9th block');
UPDATE instructor SET salary = salary * 1.05 WHERE salary < (select t.my_avg from (select avg(salary) as my_avg from instructor) as t);

-- Nested Subqueries.
select course_id from section where year=2017 and semester ='odd' and course_id in (select course_id from section where year=2018 and semester='even');
select dept_name,average from (select dept_name,avg(salary) as average from instructor group by dept_name) as S where average>10000;
select dept_name,(select count(*) from instructor where department.dept_name=instructor.dept_name) as num_instructions from department;
select dept_name,count(*) as num from instructor where dept_name in(select dept_name from department) group by dept_name;
select T.course_id from course as T where (select R.course_id from section as R where R.course_id=T.course_id and R.year=2017 group by R.course_id having count(*)=1);
select s.course_id from section as s where s.semester = 'odd' and s.year = 2017 and exists (select course_id from section as t where t.semester = 'even' and t.year = 2018 and t.course_id = s.course_id);
select name from instructor where salary>all(select salary from instructor where dept_name='CSE');
select name from instructor where salary>some(select salary from instructor where dept_name='CSE');

-- If you have 4 common attributes (columns) between two tables, you typically have two choices when performing a JOIN operation:
SELECT * FROM table1 t1 JOIN table2 t2 ON t1.attr1 = t2.attr1 AND t1.attr2 = t2.attr2 AND t1.attr3 = t2.attr3 AND t1.attr4 = t2.attr4;

-- subqueries in from clause
select dept_name,average from(select dept_name,avg(salary) as average from instructor group by dept_name having avg(salary)>10000 ) as S;
select dept_name,average from(select dept_name,avg(salary) as average from instructor group by dept_name) as S where average>10000;

-- subqueries in select clause
select dept_name,(select count(*) from instructor where department.dept_name=instructor.dept_name) as num_instructor from department;

/* Errors
Error Code: 1248. Every derived table must have its own alias" occurs in MySQL when you create a subquery (derived table), but you forget to give it an alias (a temporary name).
Error Code: 1111. Invalid use of group function -->for this error use group by function.

The error in your query comes from trying to apply the avg(salary) > 10000 filter directly in the WHERE clause of the inner query, which is not allowed because AVG() is an aggregate function and needs to be filtered after the grouping. means
WHERE filters rows before aggregation.
HAVING filters results after aggregation (like AVG(), SUM(), etc.).
Use HAVING when you need to filter based on aggregate functions.
*/
-- Set Operations in MySQL.

select * from instructor where dept_name='CSE';

-- Project operation:
-- Ex- Find out the name and salary of instructor.
 select distinct name,salary from instructor;
 -- Ex- Find the instructor who have taught some course.
 select distinct instructor.name,teaches.course_id from instructor,teaches where teaches.id=instructor.id;
  -- Ex- Find the courses taught in odd 2017 semester and even 2018 semester.

 -- Cartesian Product:
 -- Ex- Find the instructor who have taught some course.
 select distinct instructor.name,teaches.course_id from instructor,teaches where teaches.id=instructor.id;
-- union:
 select course_id from section where semester='odd' and year=2017 union select course_id from section where semester='even' and year=2018;
 
-- intersect Operation:
select course_id from section where semester='odd' and year=2017 intersect select course_id from section where semester='even' and year=2018;
select course_id from section where semester='odd' and year=2017 and course_id in (select course_id from section where semester='even' and year=2018);

-- except operation:
select course_id from section where semester='odd' and year=2017 and course_id not in (select course_id from section where semester='even' and year=2018);
select course_id from section as s where s.semester='odd' and s.year =2017 except select course_id from section as t where t.semester='even' and t.year=2018;

-- Find the name of students who have not taken any course before odd semester 2012.
select S.ID,S.name from student as S where ID not in (select ID  from takes as T where T.year<2012 and T.semester='odd');
select S.ID,S.name,S.dept_name from student as S left join takes as T on S.ID=T.ID and T.year<2012 and T.semester='odd';
select *from student;

-- Find the name of all the students who have taken atleast one Computer Science Course.
select *from takes;
select *from course;
select takes.ID,takes.year from takes join course on takes.course_id=course.course_id and course.dept_name='CSE';

-- Find the names of all the instructors in CSE department together with the course titles of all the courses that instructor teaches.
select instructor.ID,instructor.name,course.title from instructor join teaches on instructor.ID=teaches.ID join course on teaches.course_id=course.course_id where instructor.dept_name='CSE';


-- lab questions.
-- Find the id and date of studnets who has not taken any course.
-- Find the name of all  the students who have taken atleast one computer science course
-- FInd the name of all the instructor cse department together with the course title of all the course to that instructor teaches.

select id, 'n/a' as date from student where id not in (select id from takes);
select name from student where id in (select id from takes where course_id in (select course_id from course where dept_name = 'cse'));
select instructor.name, course.title from instructor, teaches, course where instructor.id = teaches.id and teaches.course_id = course.course_id and instructor.dept_name = 'cse';

-- joins
-- select name from department full join takes where dept_name='CSE';
select student.name from student join takes on student.id = takes.id join course on takes.course_id = course.course_id where course.dept_name = 'cse';
select instructor.name, course.title from instructor join teaches on instructor.id = teaches.id join course on teaches.course_id = course.course_id where instructor.dept_name = 'cse';
select instructor.name, course.title from instructor left join teaches on instructor.id = teaches.id left join course on teaches.course_id = course.course_id where instructor.dept_name = 'cse';


/*
find name of instructors working in department building name includes substring 'block'
Retrive the list of courses taught by instructor whose name consisit of 'R' as foutrth character 
List the name of courses and total no of studnets whre more than 20 % students earn 9 grade. 
Retrive the total count of student in each dpartment who earn more than 8 credits
List the name of cse instructor whose classes are slotted after 12 pm in csc department */

select name from instructor where dept_name in(select dept_name from department where building like '%block');
select course_id from teaches where id in(select id from instructor where name like '___R%');

-- tables- course,instructor,teaches,takes
-- select count(students),name
 -- select c.title, count(t.student_id) as num from course c join takes t on c.course_id = t.course_id group by c.course_id, c.course_name having sum(case when t.grade = 9 then 1 else 0 end) / count(t.student_id) > 0.2;


-- select dept_name,count(*) as num from student  where dept_name in (select dept_name from takes where grade>8) group by dept_name;
select dept_name,count(*) as num from student  where tot_cred>8 group by dept_name;    -- query 4

select name from instructor where id in(select id from teaches where course_id in(select course_id from section where time_slot_id in(select time_slot_id from time_slot where end_time='12:30:00')));

-- select instructor.name from instructor join department where in



-- with clause,views-outd 

create view ins_cse as(select * from instructor where dept_name='CSE');     -- temporary table view
select * from ins_cse;

-- with clause
with Maxbudget(value) as (select max(budget)from department)
select department.dept_name from department,Maxbudget where department.budget=Maxbudget.value;

with department_total(dept_name,total_salary) as(select dept_name,sum(Salary) from instructor group by dept_name),dept_avg(avgtotal_salary) as (select avg(total_salary) from department_total)
select dept_name from department_total,dept_avg where total_salary>avgtotal_salary;

-- Views

-- simple view
create view faculty14 as select ID,name,dept_name from instructor;
select name from faculty14 where dept_name='CSE' ;

insert into faculty14 (ID, name, dept_name) values (101, 'Dr. John Doe', 'Physics');

create view faculty126 as select ID,name from instructor;
insert into faculty126 (ID, name) values (101, 'Dr. John Doe');


create view totalSalary as (select dept_name,sum(salary) from instructor group by dept_name);
select *from totalSalary;

create view physics_odd_2017 as(select c.course_id,c.title,s.sec_id,s.building,s.room_number from course as c,section as s where c.course_id=s.course_id and dept_name='CSE' and s.year=2017 and s.semester='odd');
select * from physics_odd_2017;

create view physics_odd_2017_9blocks as(select course_id,title,room_number from physics_odd_2017 where building='9th block' )with check option;
select * from physics_odd_2017_9blocks;



-- Lab 24/09/2024 ques
-- create a view that has dept_name ,no of employees,avg(salary) of the instructor where the no of instructor is more than 3;
-- create a view consisting of dept_name and average total credits of the student in that department.
-- create a view consisting of course_id,section_id,course_name(title),semester,year,room no,building and organise the classes scheduled for different courses department wise.
-- create a view consistin of dept_name,instructor name,course_id,section_id,semester,year,room_no, and organise the classes schedule for different courses according to the name of instructor.

-- if we want to update,insert created view then we'll use WITH CHECK OPTION clause, which ensures that any INSERT or UPDATE operations through the view do not violate the view's conditions.
select * from instructor;

create view ins32 as (select dept_name,count(name) as total_instructor,avg(Salary) from instructor group by dept_name having count(name)>1 );   -- query 1
select * from ins32;

create view stu as(select dept_name,avg(tot_cred) from student group by dept_name);  -- query 2

create view schedule141 as(select c.course_id,c.dept_name,s.sec_id ,c.title,s.semester,s.year,s.room_number from course c join section s on c.course_id=s.course_id order by c.dept_name);    -- query 3
select * from schedule141;

create view scheduled41 as(select i.dept_name,i.name,s.course_id,s.sec_id ,s.semester,s.year,s.room_number from instructor i,section s order by i.name);    -- query 4
select * from scheduled41;
