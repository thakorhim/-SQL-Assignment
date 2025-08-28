CREATE DATABASE ab;
USE ab;

CREATE TABLE customer(
customer_id INT PRIMARY KEY,
cust_name VARCHAR(50),
city VARCHAR(50),
grade INT,
salesmen_id INT);

INSERT INTO customer (customer_id,cust_name,city,grade,salesmen_id)
VALUES
(3002,"Nick Rimando","New York",100,5001),
(3007,"Brad Davis","New York",200,5001),
(3005,"Graham Zusi","California",200,5002),
(3008,"Julian Green","London",300,5002),
(3004,"Fabian Johnson","Paris",300,5006),
(3009,"Geoff Cameron","Berlin",100,5003),
(3003,"Jozy Altidor","Moscow",200,5007),
(3001,"Brad Guzan","London",NULL,5005);

CREATE TABLE IF NOT EXISTS orders (
ord_no INT PRIMARY KEY,
purch_amn DECIMAL(6,2),
ord_date date,
customer_id INT,
salesmen_id INT
);


INSERT INTO orders (ord_no, purch_amn, ord_date, customer_id, salesmen_id) VALUES
(70001,150.5,'2012-05-10',3005,5002),
(70009,270.65,'2012-09-10',3001,5005),
(70002,65.26,'2012-10-05',3002,5001),
(70004,110.5,'2012-08-17',3009,5003),
(70007,948.5,'2012-09-10',3005,5002),
(70005,2400.6,'2012-07-27',3007,5001),
(70008,5760,'2012-09-10',3002,5001),
(70010,1983.43,'2012-10-10',3004,5006),
(70003,2480.4,'2012-10-10',3009,5003),
(70012,250.45,'2012-06-27',3008,5002),
(70011,75.29,'2012-08-17',3003,5007),
(70013,3045.6,'2012-04-25',3002,500);

CREATE TABLE item_mast(
prod_id INT PRIMARY KEY,
prod_name VARCHAR(50),
prod_price DECIMAL(6,2),
prod_com INT);

INSERT INTO item_mast VALUES
(101,"Motherboard",3200.00,15),
(102,"Keyboard",450.00,16),
(103,"ZIP drive",250.00,14),
(104,"Speaker",550.00,16),
(105,"Monitor",5000.00,11),
(106,"DVD drive",900.00,12),
(107,"CD drive",800.00,12),
(108,"Printer",2600.00,13),
(109,"Refill cartridge",350.00,13),
(110,"Mouse",250.00,12);

CREATE TABLE employe_det (
emp_id INT PRIMARY KEY,
emp_fname VARCHAR(50),
emp_lname VARCHAR(50),
job_id VARCHAR(10),
salary DECIMAL(10,2),
commision DECIMAL(10,2),
dept_id INT,
mang_id INT
);


INSERT INTO employe_det VALUES
(100,'John','Smith','IT_PROG',6000,NULL,60, 200),
(101, 'Jane', 'Doe', 'MK_MAN', 9000, 500, 40, 201),
(102, 'Alice', 'Brown', 'FI_CLERK', 3000, NULL, 40, 201),
(103, 'Bob', 'Jones', 'HR_REP', 4000, NULL, 50, 202),
(104, 'Charlie', 'Adams', 'SA_REP', 4500, 300, 80, 203),
(105, 'Daniel', 'Lee', 'SA_MAN', 12000, 800, 80, 203),
(106, 'Eva', 'Green', 'MK_REP', 3500, NULL, 40, 201),
(169, 'Tom', 'Brady', 'FI_CLERK', 4200, NULL, 40, 201),
(182, 'Liam', 'Wilson', 'SA_REP', 6700, 400, 80, 203);

CREATE TABLE department (
dept_id INT PRIMARY KEY,
depat_name VARCHAR(50),
location VARCHAR(50));

INSERT INTO department VALUES
(40, 'Finance', 'Toronto'),
(50, 'HR', 'New York'),
(60, 'IT', 'Chicago'),
(80, 'Sales', 'Toronto');


#1.write a SQL query to find customers who are either from the city 'NewYork' or who do not have a grade greater than 100. Return customer_id, cust_name, city, grade, and salesman_id.
SELECT * FROM customer
WHERE city = 'New York' AND grade <= 100;

#2. write a SQL query to find all the customers in ‘New York’ city who have agradevalue above 100. Return customer_id, cust_name, city, grade, and salesman_id. 
SELECT * FROM customer
WHERE city = 'New York' AND grade >= 100;

#3. Write a SQL query that displays order number, purchase amount, and the
#achieved and unachieved percentage (%) for those orders that exceed 50%of thetarget value of 6000.
select ord_no, purch_amn, round((purch_amn/6000)*100,2) from orders where (purch_amn > (purch_amn/6000)*100)  ;

#4. write a SQL query to calculate the total purchase amount of all orders. Returntotal purchase amount.
SELECT SUM(purch_amn) FROM orders;

#5. write a SQL query to find the highest purchase amount ordered by each customer. Return customer ID, maximum purchase amount.
SELECT customer_id,MAX(purch_amn) FROM orders
GROUP BY customer_id
LIMIT 1;

#6. write a SQL query to calculate the average product price. Return average product price.
SELECT AVG(prod_price) FROM item_mast;

#7. write a SQL query to find those employees whose department is located at ‘Toronto’. Return first name, last name, employee ID, job ID.
SELECT
e.emp_fname,
e.emp_lname,
e.emp_id,
e.job_id
FROM employe_det AS e
JOIN department AS d
ON e.dept_id = d.dept_id
WHERE d.location = 'Toronto';
	
#8. write a SQL query to find those employees whose salary is lower than that of employees whose job title is "MK_MAN". Exclude employees of the Jobtitle‘MK_MAN’. Return employee ID, first name, last name, job ID.
SELECT emp_id,emp_fname,emp_lname,job_id,salary FROM employe_det
WHERE salary < (SELECT MAX(salary) FROM employe_det WHERE job_id = "MK_MAN")
AND job_id != "MK_MAN"; 	

#9. write a SQL query to find all those employees who work in department ID80or40. Return first name, last name, department number and department name. 
SELECT 
e.emp_fname,
e.emp_lname,
e.dept_id,
d.depat_name
FROM employe_det AS e
JOIN department AS d
ON e.dept_id = d.dept_id
WHERE d.dept_id IN  (40,80);

#10.write a SQL query to calculate the average salary, the number of employees receiving commissions in that department. Return department name, averagesalary and number of employees.
SELECT 
d.depat_name,
AVG(salary) AS avg_salary, 
COUNT(CASE WHEN e.commision IS NOT NULL AND e.commision > 0 THEN 1 END) AS empl_with_comm
FROM department AS d
JOIN employe_det AS e
ON d.dept_id = e.dept_id
GROUP BY d.depat_name; 

#11. write a SQL query to find out which employees have the same designationas theemployee whose ID is 169. Return first name, last name, department ID and jobID.
SELECT emp_fname,
       emp_lname,
       job_id
FROM employe_det
WHERE job_id = (
    SELECT job_id
    FROM employe_det
    WHERE emp_id = 169
)
AND emp_id <> 169;

#12.write a SQL query to find those employees who earn more than the averagesalary. Return employee ID, first name, last name
SELECT
emp_id,
emp_fname,
emp_lname,
salary
FROM employe_det
WHERE salary > (SELECT AVG(salary) FROM employe_det);

#13.write a SQL query to find all those employees who work in the Finance
#department. Return department ID, name (first), job ID and department name.

SELECT 
e.dept_id,
e.emp_fname,
e.emp_lname,
e.job_id,
d.depat_name
FROM employe_det As e
JOIN department As d
ON e.dept_id = d.dept_id
WHERE d.depat_name = "Finance";

#14. From the following table, write a SQL query to find the employees whoearnlessthan the employee of ID 182. Return first name, last name and salary.

SELECT 
emp_fname,
emp_lname,
salary
FROM employe_det
WHERE salary <(SELECT salary FROM employe_det WHERE emp_id = 182);

#15.Create a stored procedure CountEmployeesByDept that returns the number of employees in each department
DELIMITER $$
CREATE PROCEDURE count_employe()
BEGIN
SELECT dept_id,COUNT(*) 
FROM employe_det 
GROUP BY dept_id;
END $$
DELIMITER ;

CALL count_employe();	

#16.Create a stored procedure AddNewEmployee that adds a new employee to the database.
DELIMITER //
CREATE PROCEDURE addnew_employe(
IN emp_id INT,
IN emp_fname VARCHAR(50),
IN emp_lname VARCHAR(50),
IN job_id VARCHAR(10),
IN salary DECIMAL(10,2),
IN commision DECIMAL(10,2),
IN dept_id INT,
IN mang_id INT
)
BEGIN
INSERT INTO employe_det(emp_id,emp_fname,emp_lname,job_id,salary,commision,dept_id,mang_id)
VALUES (emp_id,emp_fname,emp_lname,job_id,salary,commision,dept_id,mang_id);
END //
DELIMITER ;

CALL addnew_employe(109,"Paresh","Diop","IT_PROG",15000.00,200.00,50,201);

#17.Create a stored procedure DeleteEmployeesByDept that removes all employeesfrom a specific department
DELIMITER $$
CREATE PROCEDURE  deleteall_emp(
IN dept_id INT)
BEGIN
DELETE FROM employe_det WHERE dept_id = dept_id;
END $$
DELIMITER ;

CALL deleteall_emp(40);

#18.Create a stored procedure GetTopPaidEmployees that retrieves the highest-paidemployee in each department.

DELIMITER $$
CREATE procedure gettoppaid_emp()
BEGIN
select e.emp_id,e.emp_fname,e.emp_lname,e.salary,e.dept_id from employe_det as e where e.salary = 
(select max(salary) from employe_det where dept_id = e.dept_id)order by e.salary DESC;
END $$
DELIMITER ;

CALL gettoppaid_emp();


#19.Create a stored procedure PromoteEmployee that increases an employee’s salaryand changes their job role

DELIMITER $$
CREATE PROCEDURE  PROMOTE_EMP_S(
	IN P_EMP_ID INT,
	IN PNEW_JOB_ID VARCHAR(45),
	IN PSALARY_INCR DECIMAL(10,2))
BEGIN
update employe_det
set salary = salary + PSALARY_INCR,
	job_id = PNEW_JOB_ID
    where emp_id = P_EMP_ID;
END $$
DELIMITER ;

CALL PROMOTE_EMP_S(100,"MK_MAN",-10000.00);

Set SQL_SAFE_UPDATES = 0;

 #20.Create a stored procedure AssignManagerToDepartment that assigns a newmanager to all employees in a specific department.

DELIMITER $$
CREATE PROCEDURE ASSIGN_MAN(
	IN A_dept_id INT,
    IN A_manager_id INT)
BEGIN
	UPDATE employe_det
    SET mang_id = A_manager_id
    WHERE dept_id = A_dept_id;
END $$
DELIMITER ;

CALL ASSIGN_MAN (40,201);