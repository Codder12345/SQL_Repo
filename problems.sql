create database problems;


/*
comment has been adde 
*/
use face_recognizer;
show tables;

use problems;
show tables;


# SQL employee table creation 

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2)
);


# insert values to employee table 
INSERT INTO employee (emp_id, name, department_id, salary)
VALUES
    (1, 'John Doe', 101, 5000),
    (2, 'Jane Smith', 102, 5500),
    (3, 'Robert Brown', 103, 6000),
    (4, 'Emily Davis', 104, 6500),
    (5, 'Michael Wilson', 105, 7000),
    (6, 'Laura Johnson', 101, 7500),
    (7, 'David Miller', 102, 8000),
    (8, 'Sophia Garcia', 103, 8500),
    (9, 'Daniel Martinez', 104, 9000),
    (10, 'Chloe Anderson', 105, 5200),
    (11, 'Ethan Taylor', 101, 5800),
    (12, 'Isabella Moore', 102, 6300),
    (13, 'Alexander Jackson', 103, 6700),
    (14, 'Amelia Thomas', 104, 7200),
    (15, 'Olivia Harris', 105, 7700),
    (16, 'Benjamin Martin', 101, 8200),
    (17, 'Charlotte White', 102, 8600),
    (18, 'Lucas Perez', 103, 5100),
    (19, 'Ava Clark', 104, 5400),
    (20, 'Mason Rodriguez', 105, 5900);
    
    
select * from employee;


/*
emp_id: Unique ID for each employee, starting from 1.
name: Employee names for demonstration purposes. You can modify them as needed.
department_id: Assigned to departments starting from 101. Some employees share the same department_id.
salary: Ranges from 5000 to 9000 with variations.
*/


/*
Here is the SQL query to create a departments table with department_id and department_name columns:
*/

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments (department_id, department_name)
VALUES
    (101, 'Human Resources'),
    (102, 'Finance'),
    (103, 'Engineering'),
    (104, 'Marketing'),
    (105, 'Sales');
    
    
select * from departments;

/*
department_id: A unique identifier for each department.
department_name: A descriptive name for each department (e.g., "Human Resources").
*/


# prject table 
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);



INSERT INTO projects (project_id, project_name, emp_id)
VALUES
    (1, 'Project Alpha', 1),
    (2, 'Project Beta', 2),
    (3, 'Project Gamma', 3),
    (4, 'Project Delta', 4),
    (5, 'Project Epsilon', 5),
    (6, 'Project Zeta', 6),
    (7, 'Project Eta', 7),
    (8, 'Project Theta', 8),
    (9, 'Project Iota', 9),
    (10, 'Project Kappa', 10),
    (11, 'Project Lambda', 11),
    (12, 'Project Mu', 12),
    (13, 'Project Nu', 13),
    (14, 'Project Xi', 14),
    (15, 'Project Omicron', 15),
    (16, 'Project Pi', 16),
    (17, 'Project Rho', 17),
    (18, 'Project Sigma', 18),
    (19, 'Project Tau', 19),
    (20, 'Project Upsilon', 20);

select * from projects;

/*
project_id: A unique identifier for each project.
project_name: Name of the project.
emp_id: Links the project to an employee (emp_id from the employee table).
The FOREIGN KEY constraint ensures referential integrity between the projects table and the employee table. If an emp_id does not exist in the employee table, the record cannot be added to the projects table.

*/

# Q1. Retrieve all employee names and their respective department names.
select * from employee;
select * from departments;

select emp_id as 'Employee ID', employee.department_id as 'Department ID',name as 'Employee name '  , department_name as 'Department Name' 
from employee
inner join departments on employee.department_id = departments.department_id;



# Q2. List all employees and their projects, including employees without any projects.
select * from employee;
select * from departments;
select * from projects;

select name,project_name 
from employee
inner join projects on employee.emp_id = projects.emp_id;


#Q3. Retrieve all projects and the employees working on them, even if some projects have no assigned employees.

# to delete rows from emp_id 11 to 20 to solve the above question
delete from projects
where emp_id between 11 and 20;

select employee.emp_id as 'Employee ID', name as 'Employee name',project_name as 'Assigned Projects'   
from employee 
left join projects on employee.emp_id = projects.emp_id;

select * from projects;

# Q4. List all employees and all projects, even if there is no match between them.
select name,project_name from  (departments,employee,projects);

select employee.emp_id,name as employee_name,project_id,project_name
from employee
left join projects on employee.emp_id = projects.emp_id;

/*
union
select employee.emp_id,employee.name as employee_name,projects.project_id,projects.project_name
from projects
left join employee
on employee.emp_id = projects.emp_id;
*/


#  Q5. Find the total salary of employees in each department.
select * from employee;
select * from departments;
select * from projects;

select employee.department_id as 'Department ID',department_name as 'Department Name', sum(salary) as 'Department Wise Salary Distribution',count(emp_id) as 'No of Employees' , round((sum(salary) / count(emp_id)),2) as 'department wise average salary of employees ' 
from employee
left join departments on employee.department_id = departments.department_id
group by employee.department_id ;


/*
101	Human Resources	26500.00	4	6625.00
102	Finance	28400.00	4	7100.00
103	Engineering	26300.00	4	6575.00
104	Marketing	28100.00	4	7025.00
105	Sales	25800.00	4	6450.00
*/



# Q6. Find the average salary of employees in each department.

select employee.department_id as 'Department ID', department_name as 'Department Name' , sum(salary)  as 'Salary of Departments',count(employee.department_id) as 'Employees in each Department' , round((sum(salary) / count(employee.department_id) ),2) as 'Average salary of employees in each department'
from employee
left join departments on employee.department_id = departments.department_id
group by employee.department_id;



# Q7. Find the number of employees in each department.

select employee.department_id as 'Department ID', department_name as 'Department Name' , count(department_name) as 'Employees in each Department'
from employee
left join departments on employee.department_id = departments.department_id
group by employee.department_id;


#Q8. Retrieve departments with more than 2 employees.

select employee.department_id as 'Employee ID', department_name as 'Department Name', count(employee.department_id)  as 'Employees in each Departhment'
from employee 
left join departments on employee.department_id = departments.department_id
group by employee.department_id
having count(employee.department_id) >2;

# Q9. Write a procedure to insert a new employee into the employees table and then call the procedure.





# Q10. Create a view that displays the employees' names, their department names, and their salaries.
select * from employee;

select emp_id as 'Employee Id',name as 'Name' ,department_name as 'Department Name' , salary as 'Salary'
from employee
left join departments on employee.department_id = departments.department_id;


# Q11. Create a trigger that automatically sets the salary field to a default value of 5000 
# if it is not provided during an insert operation into the employees table.

/*

insert into employee (emp_id, name, department_id, salary)
values (21,'Pooja Waykar',104,50000),
		(22,'Pranav Sirsufale',104,50000),
        (23,'Nick Jones',105,null);
        
delimiter //
create trigger set_default_salary
before insert on employee
for each row
begin
    if new.salary is null then
        set new.salary = 5000;
    end if;
end;
delimiter ;





select * from employee;
select * from departments;

/*
BEFORE INSERT:
Ensures the trigger runs before an insert operation on the employee table.
FOR EACH ROW:
Applies the trigger logic to each row being inserted.
NEW.salary:
Refers to the value of the salary field being inserted.
If NEW.salary IS NULL, the trigger sets it to 5000.
*/







/*
show triggers like 'employee';


	
    

delete from employee 
where emp_id between 21 and 23;

CREATE TABLE trigger_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_message VARCHAR(255),
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from  trigger_log;

DELIMITER //
CREATE TRIGGER set_default_salary
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.salary IS NULL THEN
        SET NEW.salary = 5000;
    END IF;
    
END

DELIMITER ;


DELIMITER //
CREATE TRIGGER set_default_salary
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.salary IS NULL THEN
        SET NEW.salary = 5000;
    END IF;
    INSERT INTO trigger_log (log_message) 
    VALUES (CONCAT('Trigger fired for employee ID: ', NEW.emp_id));
END;
DELIMITER ;


insert into employee (emp_id, name, department_id, salary)
values
    (21, 'Pooja Waykar', 104, 50000),
    (22, 'Pranav Sirsufale', 104, 50000),
    (23, 'Nick Jones', 105, null); 
    
show triggers like 'set_default_salary';



select * from employee;


show columns from employee;

*/



# Q12. Create a trigger that logs any changes to the salary of employees into a separate table salary_changes.

select * from employee;


#############################

create table salary_changes (
    change_id int auto_increment primary key,
    emp_id int not null,
    old_salary decimal(10, 2),
    new_salary decimal(10, 2),
    change_time timestamp default current_timestamp,
    changed_by_user varchar(100)
);

select * from salary_changes;

delimiter //
create trigger log_salary_changes
after update on employee
for each row
begin
    if old.salary <> new.salary then
        insert into salary_changes (emp_id, old_salary, new_salary)
        values (old.emp_id, old.salary, new.salary);
    end if;
end//
delimiter ;

show triggers like 'log_salary_changes';

update employee 
set salary = 600 
where emp_id = 20;

select * from salary_changes;

select * from employee;











 















/*

*/

/*

*/

/*

*/








