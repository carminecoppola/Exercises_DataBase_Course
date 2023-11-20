 /*  La durata di un'asta non può essere inferiore a tre giorni. 
    In un mese un oggetto non può essere messo all'asta più di tre volte. 
    Il rilancio minimo dev'essere almeno il 10% del prezzo base. 
    Eccezioni: 
        rilancio_minimo_troppo_basso, asta_troppo_breve, oggetto_troppe_volte_in_vendita. 
*/


CREATE OR REPLACE TRIGGER ControlloAsta BEFORE INSERT ON ASTA
FOR EACH ROW
DECLARE
num_volte_asta	NUMBER;
rilancio_min	EXCEPTION;
a_breve 		EXCEPTION;
ogg_vendita 	EXCEPTION;

BEGIN

	-- La durata di un'asta non può essere inferiore a tre giorni. 

    	IF (TO_DATE(:NEW.data_fine,'YYYY-DD-MM') - TO_DATE(:NEW.data_inizio,'YYYY-DD-MM') < 3) THEN
    		raise a_breve;
		END IF;

    -- In un mese un oggetto non può essere messo all'asta più di tre volte.

    	SELECT 	COUNT(*)
    	INTO	num_volte_asta
    	FROM	ASTA 
    	WHERE	codice_oggetto =:NEW.codice_oggetto and TO_DATE(data_inizio,'MM') = TO_DATE(:NEW.data_inizio,'MM');

    	IF num_volte_asta > 3 THEN
    		raise ogg_vendita;
		END IF;

    -- Il rilancio minimo dev'essere almeno il 10% del prezzo base:

        IF ((:NEW.rilancio_min) < (:NEW.prezzo_base * 10)/100) THEN
            raise rilancio_min;
		END IF;

    EXCEPTION
    	WHEN rilancio_min THEN
    		RAISE_APPLICATION_ERROR('-20001','rilancio_minimo_troppo_basso: ');
		WHEN a_breve THEN
    		RAISE_APPLICATION_ERROR('-20002','asta_troppo_breve: ');
		WHEN ogg_vendita THEN
    		RAISE_APPLICATION_ERROR('-20003','oggetto_troppe_volte_in_vendita: ');
END;