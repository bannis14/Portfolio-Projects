--Employees Database


-- Select employees with the first name 'Mayumi' and last name 'Schueller'

Select first_name, last_name from employees
Where first_name = 'Mayumi' and last_name = 'Schueller';

-- Select the first names of female employees

Select first_name from employees
Where gender = 'F';

-- Select the employee number, first name, and age of employees whose first name starts with 'M'

Select emp_no, first_name, EXTRACT (YEAR FROM AGE(birth_date)) as "age" From employees
Where first_name ILIKE 'M%';

-- Count the number of employees whose first name starts with 'A' and ends with 'R'

Select count(first_name) From employees
Where first_name ILIKE 'A%R';

-- Select employees older than 60 years

Select first_name, last_name from employees
Where Date_part('year', CURRENT_DATE) - Date_part('year', birth_date) > 60;

-- Count the number of employees hired in February

Select count(emp_no) From employees
Where extract(month from hire_date) = 2;

-- Count the number of employees born in November

Select count(emp_no) from employees
Where extract(month from birth_date) = 11;

-- Find the age of the oldest employee

select max(age(birth_date)) from employees;

-- Select distinct job titles

select distinct title from titles;

-- Select distinct birth dates of employees

select distinct birth_date from employees;

-- Select employees ordered by first name in ascending order and last name in descending order

Select first_name, last_name from employees
Order by first_name ASC, last_name DESC;

-- Select employees ordered by age in descending order

Select first_name, last_name from employees
Order by age(birth_date) DESC;

-- Select employees whose first name starts with 'K' ordered by hire date in ascending order

Select first_name, last_name from employees
Where first_name ILIKE 'K%'
Order by hire_date ASC;

-- Count the number of employees hired on each date and order by the count in descending order

SELECT hire_date, count(emp_no) as amount
From Employees
Group by hire_date
Order by "amount" DESC;

-- Select employees and count the number of titles they have, only for those hired after 1991 and having more than 2 titles

Select e.emp_no, count(t.title) as "amount of titles"
From employees as e
Join titles as t using(emp_no)
Where extract(year from e.hire_date) > 1991
Group by e.emp_no
Having count(t.title) > 2
Order by e.emp_no;

-- Select employees and count the number of salary changes they have had, only for those working in the 'Development' department and having more than 15 salary changes

Select e.emp_no, count(s.from_date) as "amount of raises"
From employees as e
Join salaries as s using(emp_no)
Join dept_emp as de using(emp_no)
Where de.dept_no = 'd005'
Group by e.emp_no
Having count(s.from_date) > 15
Order by e.emp_no ;

-- Select employees and count the number of departments they have worked for, only for those who have worked for more than 1 department

Select e.emp_no, count(de.from_date) as "Department Change"
From employees as e
Join dept_emp as de using (emp_no)
Group by e.emp_no 
Having count(de.from_date) > 1;

-- Select employees and their department names

Select e.first_name, e.last_name, dp.dept_name
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
Join departments as dp on dp.dept_no = de.dept_no;

-- Create a view named "90-95" showing employees hired between 1990 and 1995

Create view "90-95" as
Select emp_no, first_name, last_name, hire_date
from employees
where extract(year from hire_date) between 1990 AND 1995;

-- Create a view named "bigbucks" showing employees who have ever had a salary over 80000

create view "bigbucks" as 
select e.first_name, e.last_name, s.salary
from employees as e
join salaries as s on e.emp_no = s.emp_no
Where salary > 80000
order by salary asc;

-- Select employees who have emp_no 110183 as a manager

Select e.emp_no, e.first_name, e.last_name 
from employees as e
Join dept_emp as de on de.emp_no = e.emp_no
Join dept_manager as dm on de.dept_no = dm.dept_no
Where dm.emp_no = 110183;
