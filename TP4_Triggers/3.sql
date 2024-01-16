CREATE OR REPLACE TRIGGER control_insert_update_employees
BEFORE INSERT OR UPDATE OF salary ON employees
FOR EACH ROW
WHEN (NEW.job_id <> 'PRESIDENT')
DECLARE
  min_sal jobs.min_salary%TYPE;
  max_sal jobs.max_salary%TYPE;
BEGIN
  SELECT min_salary, max_salary
  INTO min_sal, max_sal
  FROM grille
  WHERE job = :NEW.job_id;

  IF :NEW.salary NOT BETWEEN min_sal AND max_sal THEN
    RAISE_APPLICATION_ERROR(-20001, 'Le salaire doit etre compris entre ' || min_sal || ' et ' || max_sal);
  END IF;
END;
/

CREATE OR REPLACE VIEW GRILLE
AS
SELECT job_id as job, min_salary, max_salary
FROM JOBS;

UPDATE EMPLOYEES
SET SALARY = 3000
WHERE EMPLOYEE_ID = 208;
