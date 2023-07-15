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
    WHERE   P.numero_progetto = :NEW.numero_progetto;

    SELECT  NUMERO_DIPARTIMENTO
    INTO    dip_assegnato
    FROM    IMPIEGATO I
    WHERE   I.CF = (SELECT CF_IMPIEGATO FROM LAVORA_SU WHERE NUMERO_PROGETTO = :NEW.NUMERO_PROGETTO);

    IF(dip_provenienza <> dip_assegnato) THEN 
        RAISE_APPLICATION_ERROR(-3000, 'dipartimento_incompatibile: errore in fase di assegnazione del dipartimento');
    END IF;

    SELECT  SEDE_PROGETTO 
    INTO    sede_dipartimento
    FROM    PROGETTO P
    WHERE   P.NUMERO_PROGETTO = :NEW.NUMERO_PROGETTO;

    SELECT  DISTINCT(CITTA_SEDE)
    INTO    sede_assegnazione
    FROM    SEDE_DIPARTIMENTO SD
    WHERE   SD.NUMERO_DIPARTIMENTO = dip_assegnato;

    IF(sede_assegnazione <> sede_dipartimento) THEN 
        RAISE_APPLICATION_ERROR(-3001, 'sede_incompatibile: errore in fase di assegnazione del dipartimento');
    END IF;
END;
