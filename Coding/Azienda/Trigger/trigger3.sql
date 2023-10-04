/* 	Creare un trigger che controlli che ogni impiegato non abbia piu di 3 familiari a carico.
	Eccezzioni:
		troppi_familiari;
*/

CREATE OR REPLACE TRIGGER cont_fam BEFORE INSERT OR UPDATE ON FAMILIARE_A_CARICO
FOR EACH ROW
DECLARE
	cont_fam	NUMBER;
BEGIN
	SELECT	COUNT(*)
	INTO	cont_fam
	FROM	FAMILIARE_A_CARICO
	WHERE	cf_impiegato =:NEW.cf_impiegato;

	IF(cont_fam = 3) THEN
		RAISE_APPLICATION_ERROR(-2009,'troppi_familiari: Errore questo impiegato ha gia 3 familiari a carico');
	END IF;
END;
	