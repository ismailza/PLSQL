-- Create table history 
-- DROP TABLE history;
CREATE TABLE history (
  employee_id NUMBER(6),
  operation_date TIMESTAMP,
  operation_type VARCHAR2(10)
);

CREATE OR REPLACE TRIGGER insert_operation
AFTER INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW
DECLARE
  operation VARCHAR2(10);
BEGIN
  IF INSERTING THEN
    operation := 'INSERTING';
  ELSIF UPDATING THEN
    operation := 'UPDATING';
  ELSE
    operation := 'DELETING';
  END IF;
  INSERT INTO history (employee_id, operation_date, operation_type)
  VALUES (:NEW.employee_id, CURRENT_TIMESTAMP, operation);
END;
/
