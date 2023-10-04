/*  Un impiegato che lavora per più di 100 ore su un progetto non può essere assegnato ad un
    secondo progetto. 
    Se un impiegato lavora su due progetti per più di 100 ore totali, non può essere
    assegnato ad un terzo.
    Un impiegato al massimo è assegnato a quattro progetti diversi.
    Eccezioni: 
        ore_progetto_sature, ore_progetti_sature, troppi_progetti.
*/


CREATE OR REPLACE TRIGGER Controllo_Impiegato BEFORE INSERT ON LAVORA_SU
FOR EACH ROW
DECLARE
	totOre	        NUMBER;
    cont_progetti   NUMBER(2, 0);
BEGIN

    SELECT  COUNT(*)
    INTO    cont_progetti
    FROM    IMPIEGATO I JOIN LAVORA_SU LS ON(I.cf = LS.cf_impiegato)
    WHERE   I.cf =:NEW.cf_impiegato;
    
    IF(cont_progetti > 4) THEN
        RAISE_APPLICATION_ERROR(-20002,'Troppi_progetti: non puoi partecipare ad altri progetti');
    END IF;

    
    SELECT  COUNT(LS.ore)
    INTO    totOre
    FROM    IMPIEGATO I JOIN LAVORA_SU LS ON(I.cf = LS.cf_impiegato)
    WHERE   I.cf =:NEW.cf_impiegato;

    IF(totOre > 100) THEN
        RAISE_APPLICATION_ERROR(-20003,'Ore_progetto_sature: non può essere assegnato a un nuovo progetto');
    END IF;
END;