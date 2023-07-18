/*  Un medico può partecipare al massimo a 10 interventi in una settimana 
    e di al più tre tipi diversi. In ogni intervento almeno due medici 
    devono avere la stessa specializzazione.
*/

CREATE OR REPLACE TRIGGER InterventiMedici 
BEFORE INSERT ON INTERVENTO
FOR EACH ROW
DECLARE
    totInterv   NUMBER;
    tipoInterv  VARCHAR(30);
    codfMedico  CHAR(16);
    specializz  VARCHAR(50);
BEGIN

    SELECT  COUNT(*),COUNT(DISTINCT(I.tipo))
    INTO    totInterv,tipoInterv
    FROM    INTERVENTO I JOIN EFFETTUA E ON(I.id = E.id_int)
    WHERE  	cf_med =:NEW.cf_med
    GROUP BY M.cf;

    IF(totInterv > 2)THEN
        RAISE_APPLICATION_ERROR(-2001,'MaxInterventi: Attenzione questo medico ha effettuato gia 10 interventi');
    END IF;

    IF(tipoInterv > 3)THEN
        RAISE_APPLICATION_ERROR(-2003,'MaxTipiInterventi: Attenzione questo medico ha effettuato gia 3 tipo di interventi diversi');
    END IF;

END;

------------
CREATE OR REPLACE TRIGGER InterventiMedici 
BEFORE INSERT ON EFFETTUA
FOR EACH ROW
DECLARE
    totInterv   NUMBER;
    tipoInterv  VARCHAR(30);
    codfMedico  CHAR(16);
    specializz  VARCHAR(50);
BEGIN

    SELECT  COUNT(*)
    INTO    totInterv
    FROM    EFFETTUA
    WHERE  	cf_med =:NEW.cf_med;

    IF(totInterv > 6 )THEN
        RAISE_APPLICATION_ERROR(-2001,'MaxInterventi: Attenzione questo medico ha effettuato gia 10 interventi');
    END IF;

END;