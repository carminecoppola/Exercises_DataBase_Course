/*  Un medico può partecipare ad un intervento solo se ha già effettuato altri due interventi 
    dello stesso tipo oppure almeno uno degli altri medici coinvolti nello stesso intervento ha
    già effettuato altri due interventi dello stesso tipo. 
    Egli NON può svolgere più di 3 interventi nello stesso giorno. 
    Eccezioni: 
        unexperienced_doctor, unexperienced_team, doctor_overloaded.   
*/

CREATE OR REPLACE TRIGGER ControlloMedico BEFORE INSERT ON EFFETTUA
FOR EACH ROW

DECLARE
  cont NUMBER(2,0);
  tipo INTERVENTO.TIPO%TYPE;

BEGIN
  -- 1) Controllo se il medico ha già effettuato due interventi dello stesso tipo
  SELECT I.tipo INTO tipo
  FROM INTERVENTO I
  WHERE I.id = :NEW.id_int;

  SELECT COUNT(*) INTO cont
  FROM EFFETTUA E JOIN INTERVENTO I ON (E.id_int = I.id)
  WHERE I.tipo = tipo AND E.cf_med = :NEW.cf_med;

  IF cont < 2 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Il medico non ha ancora effettuato due interventi dello stesso tipo.');
  END IF;

  -- 2) Controllo se almeno uno degli altri medici coinvolti ha effettuato due interventi dello stesso tipo
  SELECT COUNT(*) INTO cont
  FROM EFFETTUA E JOIN INTERVENTO I ON (E.id_int = I.id)
  WHERE I.tipo = tipo AND E.id_int = :NEW.id_int AND E.cf_med != :NEW.cf_med;

  IF cont = 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Nessun altro medico coinvolto ha effettuato due interventi dello stesso tipo.');
  END IF;

  -- 3) Controllo se il medico ha già effettuato tre interventi nello stesso giorno
  SELECT COUNT(*) INTO cont
  FROM EFFETTUA E JOIN INTERVENTO I ON (E.id_int = I.id)
  WHERE E.cf_med = :NEW.cf_med AND TRUNC(I.data_e_ora) = TRUNC(:NEW.data_e_ora);

  IF cont >= 3 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Il medico ha già effettuato tre interventi nello stesso giorno.');
  END IF;

END;
/
