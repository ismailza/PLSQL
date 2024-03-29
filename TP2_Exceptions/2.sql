ACCEPT v_emp_num PROMPT 'Enter employee id : '
DECLARE
  ID_empty EXCEPTION;
  PRAGMA EXCEPTION_INIT(ID_empty, -20001);
  emp_num employees.employee_id%TYPE := '&v_emp_num';
  TYPE emp_rec IS RECORD (
    num employees.employee_id%TYPE,
    prenom employees.first_name%TYPE,
    nom employees.last_name%TYPE,
    salaire employees.salary%TYPE,
    nom_dept departments.department_name%TYPE
  );
  employe emp_rec;
BEGIN
  
  IF emp_num IS NULL THEN
    RAISE ID_empty;
  END IF;
  SELECT employee_id, first_name, last_name, salary, department_name
  INTO employe
  FROM employees E , departments D
  WHERE employee_id = emp_num
  AND E.department_id = D.department_id;

  DBMS_OUTPUT.PUT_LINE('Numero employe : ' || employe.num);
  DBMS_OUTPUT.PUT_LINE('Prenom employe : ' || employe.prenom);
  DBMS_OUTPUT.PUT_LINE('Nom employe : ' || employe.nom);
  DBMS_OUTPUT.PUT_LINE('Salaire employe : ' || employe.salaire);
  DBMS_OUTPUT.PUT_LINE('Nom departement : ' || employe.nom_dept);
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Aucun employe avec ce numero ');
  WHEN ID_empty THEN DBMS_OUTPUT.PUT_LINE('Numero employe vide');
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Une erreur est survenue');
END;
/