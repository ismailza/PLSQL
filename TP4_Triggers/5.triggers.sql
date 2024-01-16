-- Triggers

-- 1.	Il ne doit pas être possible de modifier la note min dans la table prerequis.
CREATE OR REPLACE TRIGGER TRG_PREREQUIS_NOTEMIN
BEFORE UPDATE OF noteMin ON PREREQUIS
BEGIN
  RAISE_APPLICATION_ERROR(-20001, 'Impossible de modifier la note min');
END;
/

-- 2.	Dans un module, il ne doit pas y avoir plus de effecMax élèves inscrits.
CREATE OR REPLACE TRIGGER TRG_MODULE_EFFECTIF
BEFORE INSERT OR UPDATE OF codMod ON INSCRIPTION
FOR EACH ROW
DECLARE
  effecMax MODULE.effecMax%TYPE;
  nbInsc INTEGER;
BEGIN
  SELECT effecMax INTO effecMax
  FROM MODULE 
  WHERE codMod = :NEW.codMod;
  SELECT COUNT(*) INTO nbInsc
  FROM INSCRIPTION 
  WHERE codMod = :NEW.codMod;
  IF nbInsc >= effecMax THEN
    RAISE_APPLICATION_ERROR(-20002, 'Impossible de s inscrire, effectif max atteint');
  END IF;
END;
/

-- 3.	On ne peut créer un examen pour un module que s’il y a des élèves inscrits dans ce module.
CREATE OR REPLACE TRIGGER TRG_EXAMEN_INSCRIPTION
BEFORE INSERT ON EXAMEN
FOR EACH ROW
DECLARE
  nbInsc INTEGER;
BEGIN
  SELECT COUNT(*) INTO nbInsc 
  FROM INSCRIPTION 
  WHERE codMod = :NEW.codMod;
  IF nbInsc = 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Impossible de creer un examen pour un module sans inscrits');
  END IF;
END;
/

-- 4.	Un élève ne peut passer un examen que si sa date d’inscription est antérieure à la date de l’examen.
CREATE OR REPLACE TRIGGER TRG_DATE_EXAMEN
BEFORE INSERT OR UPDATE OF dateInsc ON INSCRIPTION
FOR EACH ROW
DECLARE
  dateExam EXAMEN.dateExam%TYPE;
BEGIN
  SELECT dateExam INTO dateExam 
  FROM EXAMEN 
  WHERE codMod = :NEW.codMod;
  IF :NEW.dateInsc >= dateExam THEN
    RAISE_APPLICATION_ERROR(-20004, 'Impossible de s inscrire a un examen dont la date est anterieure a la date d inscription');
  END IF;
END;
/

-- 5.	Un élève s’inscrivant à un module doit avoir eu au moins la note min à tous les modules pré-requis.
CREATE OR REPLACE TRIGGER TGR_PREREQUIS
BEFORE INSERT ON INSCRIPTION
FOR EACH ROW
DECLARE
  nbPrereq INTEGER;
  prereqPassed INTEGER;
BEGIN
  SELECT COUNT(*) INTO nbPrereq
  FROM PREREQUIS 
  WHERE codMod = :NEW.codMod;
  SELECT COUNT(*) INTO prereqPassed
  FROM RESULTAT R, (SELECT codModPrereq, noteMin FROM PREREQUIS WHERE codMod = :NEW.codMod) P
  WHERE R.numEtud = :NEW.numEtud
  AND R.codMod = P.codModPrereq
  AND R.note >= P.noteMin;

  IF prereqPassed < nbPrereq THEN
    Raise_Application_Error(-20005, 'Impossible de s inscrire a un module sans avoir eu au moins la note min a tous les prerequis');
  END IF;
END;
/

-- 6.	Créer une vue de résultats, qui contiendra le nom et la moyenne de chaque étudiant s’il a passé les examens de tous les modules dans lesquels il est inscrit.
CREATE OR REPLACE VIEW RESULTATS_FINAL_VIEW
AS
SELECT E.numEtud, nom, prenom, AVG(note) AS moyenne
FROM ETUDIANT E, RESULTAT R
WHERE E.numEtud = R.numEtud
GROUP BY E.numEtud, nom, prenom
HAVING COUNT(DISTINCT codMod) = (SELECT COUNT(*) FROM INSCRIPTION WHERE numEtud = E.numEtud);

-- 7.	Revenez sur la première contrainte : il ne doit être possible de modifier une note min dans la table prerequis que s’il n’existe pas d’élève dont une inscription serait invalidée.
CREATE OR REPLACE TRIGGER TRG_PREREQUIS_NOTEMIN2
BEFORE UPDATE OF noteMin ON PREREQUIS
FOR EACH ROW
DECLARE
  nbInsc INTEGER;
BEGIN
  SELECT COUNT(*) INTO nbInsc
  FROM INSCRIPTION I, RESULTAT R
  WHERE I.codMod = :NEW.codMod
  AND I.numEtud = R.numEtud
  AND R.note < :NEW.noteMin;
  IF nbInsc > 0 THEN
    RAISE_APPLICATION_ERROR(-20007, 'Impossible de modifier la note min');
  END IF;
END;
/

-- 8.	Il ne doit être possible de modifier effecMax que si des étudiants ne se retrouvent pas avec une inscription invalidée.
CREATE OR REPLACE TRIGGER TRG_MODULE_EFFECTIF2
BEFORE UPDATE OF effecMax ON MODULE
FOR EACH ROW
DECLARE
  nbInsc INTEGER;
BEGIN
  SELECT COUNT(*) INTO nbInsc
  FROM INSCRIPTION
  WHERE codMod = :NEW.codMod;
  IF nbInsc > :NEW.effecMax THEN
    RAISE_APPLICATION_ERROR(-20008, 'Impossible de modifier l effectif max');
  END IF;
END;
/
