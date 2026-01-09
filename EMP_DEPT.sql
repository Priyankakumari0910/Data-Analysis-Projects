create database EMP_DEPT;
use EMP_DEPT;


-- 1.Create the Employee Table as per the Below Data Provided

CREATE TABLE employee (
    empno      INT PRIMARY KEY,                -- Cannot be NULL or duplicate
    ename      VARCHAR(50),
    job        VARCHAR(30) DEFAULT 'CLERK',    -- Default job is CLERK
    mgr        INT,
    hiredate   DATE,
    sal        DECIMAL(10,2) CHECK (sal > 0),  -- Salary must be positive
    comm       DECIMAL(10,2),
    deptno     INT,                            -- Only once
    CONSTRAINT fk_dept
        FOREIGN KEY (deptno)
        REFERENCES dept(deptno)                -- Foreign key reference
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;



INSERT INTO employee (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
(7369, 'SMITH',  'CLERK',     7902, '1980-12-17',  800.00,  NULL, 20),
(7499, 'ALLEN',  'SALESMAN',  7698, '1981-02-20', 1600.00,  300.00, 30),
(7521, 'WARD',   'SALESMAN',  7698, '1981-02-22', 1250.00,  500.00, 30),
(7566, 'JONES',  'MANAGER',   7839, '1981-04-02', 2975.00,  NULL, 20),
(7654, 'MARTIN', 'SALESMAN',  7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE',  'MANAGER',   7839, '1981-05-01', 2850.00,  NULL, 30),
(7782, 'CLARK',  'MANAGER',   7839, '1981-06-09', 2450.00,  NULL, 10),
(7788, 'SCOTT',  'ANALYST',   7566, '1987-04-19', 3000.00,  NULL, 20),
(7839, 'KING',   'PRESIDENT', NULL,  '1981-11-17', 5000.00,  NULL, 10),
(7844, 'TURNER', 'SALESMAN',  7698, '1981-09-08', 1500.00,  0.00,   30),
(7876, 'ADAMS',  'CLERK',     7788, '1987-05-23', 1100.00,  NULL, 20),
(7900, 'JAMES',  'CLERK',     7698, '1981-12-03', 950.00,   NULL, 30),
(7902, 'FORD',   'ANALYST',   7566, '1981-12-03', 3000.00,  NULL, 20),
(7934, 'MILLER', 'CLERK',     7782, '1982-01-23', 1300.00,  NULL, 10);

SHOW CREATE TABLE employee;


-- 2.Create the Dept Table as below

CREATE TABLE dept (
    deptno INT PRIMARY KEY,
    dname  VARCHAR(50),
    loc    VARCHAR(50)
);


INSERT INTO dept (deptno, dname, loc) VALUES
(10, 'OPERATIONS','BOSTON'),
(20,'RESEARCH','DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'ACCOUNTING', 'NEW YORK');

-- 3. List the Names and salary of the employee whose salary is greater than 1000

select ename,sal
from employee
where sal > 1000
order by sal desc ;

-- 4. List the details of the employees who have joined before end of September 81.

select * from employee
where hiredate < '1981-09-30';

-- 5.	List Employee Names having I as second character.


select ename
from employee
where ename like '_I%'; 


-- 6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns

select 
    ename as "employee Name",
    sal as "Salary",
    sal * 0.40 as "Allowances",
    sal * 0.10 as "P.F.",
    (sal + (sal * 0.40) - (sal * 0.10)) as "Net Salary"
from 
    employee;


-- 7. List Employee Names with designations who does not report to anybody

select 
    ename as "employee Name",
    job as "Designation"
from 
    employee
where mgr IS NULL;
    
    
-- 8.	List Empno, Ename and Salary in the ascending order of salary.

select empno,ename,sal
from employee
order by sal ;


-- 9.How many jobs are available in the Organization ?


select 
    COUNT(DISTINCT job) as Total_Jobs
from employee;

 --  10.	Determine total payable salary of salesman category
   
SELECT SUM(sal + IFNULL(comm,0)) AS Total_Payable_Salary
FROM employee
WHERE job='SALESMAN';


-- 11.	List average monthly salary for each job within each department  

select 
    deptno as Department_Number,
    job as Job_Title,
    AVG(sal) as Average_Monthly_Salary
from 
    employee
group by 
    deptno, job
order by
    deptno, job;

-- 12.	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.

select e.ename as Employee_Name,e.sal as Salary,d.dname as Department_Name
from employee  as e JOIN dept as d on e.deptno = d.deptno;


-- 13.Create the Job Grades Table as below


CREATE TABLE jobgrade (
    grade CHAR(1),
    lowest_sal INT,
    highest_sal INT
);

INSERT INTO jobgrade (grade, lowest_sal, highest_sal)
VALUES
('A', 0, 999),
('B', 1000, 1999),
('C', 2000, 2999),
('D', 3000, 3999),
('E', 4000, 5000);
 
-- 14.	Display the last name, salary and  Corresponding Grade.

select e.ename as Employee_Name,e.sal as Salary,j.grade as Grade
from employee as e JOIN jobgrade as  j ON e.sal between j.lowest_sal AND j.highest_sal;

-- 15.	Display the Emp name and the Manager name under whom the Employee works in the below format .

select 
    e.ename as "Emp",
    m.ename as "Mgr",
    CONCAT(e.ename, ' reports to ', m.ename) as "Emp Report to Mgr"
from
    employee e
JOIN 
    employee m 
on
    e.mgr = m.empno;


-- 16.	Display Empname and Total sal where Total Sal (sal + Comm)


Select 
    ename as EmpName,
    (sal + IFNULL(comm, 0)) AS Total_Sal
from
    employee;
    
    
-- 17.	Display Empname and Sal whose empno is a odd number
select 
    ename as EmpName,
    sal as Salary
from 
    employee
where 
    MOD(empno, 2) <> 0;
    
    -- 18.	Display Empname , Rank of sal in Organisation , Rank of Sal in their department
    
    
    select
    ename as EmpName,
    deptno as DeptNo,
    sal as Salary,
    Rank() OVER (order by sal desc) AS Org_Rank,
    Rank() OVER (PARTITION BY deptno order by sal desc) as Dept_Rank
from employee;
    
    
    -- 19.	Display Top 3 Empnames based on their Salary
    
    select ename as Emp,sal as Salary
    from employee
    order by Salary desc limit 3;
    
   -- 20. Display Empname who has highest Salary in Each Department.
    
    select e.ename as EmpName,
    e.deptno as DeptNo,
    e.sal as Salary
from employee e
where 
    e.sal = (select MAX(sal)from employee where deptno = e.deptno);
    
    
    
    
    
    
