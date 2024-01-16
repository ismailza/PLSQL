CREATE OR REPLACE TRIGGER employe_insert
BEFORE INSERT ON employees
FOR EACH ROW
WHEN (new.salary > 5000)
BEGIN
  :NEW.salary := 5000;
END;
/

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (employees_seq.nextval, 'Ismail', 'ZAHIR', 'jdoe', '123456789', SYSDATE, 'IT_PROG', 10000, NULL, 100, 60);
