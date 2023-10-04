/*  Un impiegato ha al massimo due familiari a carico, necessariamente di sesso diverso. 
    Se entrambi i familiari a carico sono più anziani dell'impiegato, egli riceve un 
    aumento di stipendio del 10% .
    Eccezioni: 
        troppi_familiari_a_carico, sesso_incompatibile.
*/

CREATE OR REPLACE TRIGGER Aumento_familiari BEFORE INSERT ON IMPIEGATO
FOR EACH ROW
DECLARE
	anniFamiliare	DATE;
	anniImpiegato	DATE;
	countFamiliari	NUMBER;
BEGIN

	SELECT	COUNT(*)
    INTO	countFamiliari
    FROM	FAMILIARE_A_CARICO
    WHERE	CF_IMPIEGATO = :NEW.CF;

	IF(countFamiliari > 2) THEN
        RAISE_APPLICATION_ERROR(-3002, 'troppi_familiari_a_carico: Attenzione questo impiegato ha troppi familiari a carico');
	END IF;
    
    SELECT 	F.DATA_NASCITA
    INTO	anniFamiliare
    FROM	FAMILIARE_A_CARICO F JOIN IMPIEGATO I ON(F.CF_IMPIEGATO = I.CF)
    WHERE	F.CF_IMPIEGATO = :NEW.CF;

	SELECT 	I.DATA_NASCITA
    INTO	anniImpiegato
    FROM	IMPIEGATO I
    WHERE	I.CF = :NEW.CF;

	IF(anniImpiegato < anniFamiliare)THEN
        UPDATE 	IMPIEGATO
        SET 	STIPENDIO = STIPENDIO + (STIPENDIO * 20)
        WHERE   CF = :NEW.CF;
    END IF;

END;