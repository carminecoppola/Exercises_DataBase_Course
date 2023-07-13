/*  Un impiegato riceve in assegnazione solo progetti diretti dal dipartimento per cui lavora.
    Se riceve più di un progetto in assegnazione, essi devono avere la stessa sede.
    Eccezioni: 
        dipartimento_incompatibile, sede_incompatibile.
*/



CREATE OR REPLACE TRIGGER ControlloDipartimento BEFORE INSERT ON PROGETTO
FOR EACH ROW
DECLARE
    dip_provenienza     NUMBER;
    dip_assegnato       NUMBER;
    sede_assegnazione   VARCHAR2(20);
    sede_dipartimento   VARCHAR2(20);
BEGIN
    SELECT  dipartimento_responsabile 
    INTO    dip_provenienza
    FROM    PROGETTO P
    WHERE   P.numero_progetto :=NEW.numero_progetto;

    SELECT  numero_dipartimento
    INTO    dip_assegnato
    FROM    IMPIEGATO I
    WHERE   I.cf =:NEW.cf_impiegato;


    IF(dip_provenienza <> dip_assegnato) THEN 
        RAISE_APPLICATION_ERROR(-3000, 'dipartimento_incompatibile: errore in fase di assrgnazione del dipartimento');
    END IF;


    SELECT  sede_progetto 
    INTO    sede_dipartimento
    FROM    PROGETTO P
    WHERE   P.numero_progetto := NEW.numero_progetto;

    SELECT  DISTINCT(citta_sede)
    INTO    sede_assegnazione
    FROM    PROGETTO P JOIN LAVORA_SU LS ON(P.numero_progetto = LS.numero_progetto)
    WHERE   dip_provenienza = dip_assegnato and cf_impiegato=:NEW.cf_impiegato;


    IF(sede_assegnazione <> sede_dipartimento) THEN 
        RAISE_APPLICATION_ERROR(-3001, 'sede_incompatibile: errore in fase di assrgnazione del dipartimento');
    END IF;
END;