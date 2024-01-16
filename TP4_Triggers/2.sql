CREATE OR REPLACE TRIGGER employe_embauche
BEFORE INSERT ON employees
FOR EACH ROW
WHEN (NEW.hire_date > SYSDATE)
BEGIN
  RAISE_APPLICATION_ERROR(-20001, 'la date d embauche doit etre inferieur a la date du jour');
END;
/

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (employees_seq.nextval, 'Ismail', 'ZAHIR', 'ismail', '123456789', '01-JAN-23', 'IT_PROG', 10000, NULL, 100, 60);
