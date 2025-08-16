SELECT e.employee_id,
       CONCAT(e.first_name,' ',e.last_name) AS name,
       d.name AS department,
       e.salary,
       CONCAT(m.first_name,' ',m.last_name) AS manager
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employees m ON e.manager_id = m.employee_id;


SELECT d.name AS department,
       ROUND(AVG(e.salary),2) AS avg_salary,
       RANK() OVER (ORDER BY AVG(e.salary) DESC) AS rank
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY avg_salary DESC;


SELECT e.employee_id,
       CONCAT(e.first_name,' ',e.last_name) AS name,
       e.salary
FROM employees e
JOIN (
   SELECT department_id, AVG(salary) AS avg_sal
   FROM employees
   GROUP BY department_id
) dept_avg ON e.department_id = dept_avg.department_id
WHERE e.salary > dept_avg.avg_sal;


DELIMITER $$
CREATE PROCEDURE add_employee(
  IN p_first VARCHAR(50), IN p_last VARCHAR(50), IN p_email VARCHAR(100),
  IN p_phone VARCHAR(20), IN p_hiredate DATE, IN p_job INT, IN p_dept INT,
  IN p_manager INT, IN p_salary DECIMAL(10,2)
)
BEGIN
  INSERT INTO employees (first_name,last_name,email,phone,hire_date,job_id,department_id,manager_id,salary)
  VALUES (p_first,p_last,p_email,p_phone,p_hiredate,p_job,p_dept,p_manager,p_salary);
  SELECT LAST_INSERT_ID() AS new_employee_id;
END $$
DELIMITER ;



