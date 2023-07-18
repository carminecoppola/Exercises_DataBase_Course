/*  Un oggetto non può essere rimesso all'asta se è stato già venduto oppure se non è passata
    più di una settimana dall'ultima volta che è stato messo all'asta rimanendo invenduto.
    Gli oggetti di provenienza 'LOUVRE' non possono andare all'asta.
    Eccezioni: 
        oggetto_già_venduto, periodo_trascorso_dall_ultima_asta_troppo_breve, oggetto_non_valido
*/


/*  Un oggetto non può essere rimesso all'asta se è stato già venduto oppure se non è passata
    più di una settimana dall'ultima volta che è stato messo all'asta rimanendo invenduto.
    Gli oggetti di provenienza 'LOUVRE' non possono andare all'asta.
    Eccezioni: 
        oggetto_già_venduto, periodo_trascorso_dall_ultima_asta_troppo_breve, oggetto_non_valido
*/


CREATE OR REPLACE TRIGGER ControlloOggetti BEFORE INSERT ON ASTA
FOR EACH ROW
DECLARE
    prov 		VARCHAR2(40);
	lastAsta 	DATE;
    currentDate DATE := SYSDATE;
BEGIN

    -- Controllo provenienza
    SELECT O.provenienza
    INTO prov
    FROM ASTA A JOIN OGGETTO O ON (A.codice_oggetto = O.codice_oggetto)
    WHERE A.codice_oggetto = :NEW.codice_oggetto;

    IF prov = 'LOUVRE' THEN
        RAISE_APPLICATION_ERROR(-3000, 'oggetto_non_valido: gli oggetti di provenienza LOUVRE non possono andare all asta');
    END IF;

	-- Controllo oggetto già venduto
    SELECT	MAX(DATA_RICEZ_PAG)
    INTO 	lastAsta
    FROM 	VENDITA
    WHERE 	ID_ASTA = :NEW.codice_oggetto;

    IF lastAsta IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-3001, 'oggetto_già_venduto: l''oggetto è stato già venduto');
    END IF;

    -- Controllo periodo trascorso dall'ultima asta
    IF lastAsta IS NOT NULL AND currentDate - lastAsta < 7 THEN
        RAISE_APPLICATION_ERROR(-3002, 'periodo_trascorso_dall_ultima_asta_troppo_breve: non è passata una settimana dall''ultima asta');
    END IF;
	

END;


-- Primo inserimento per il LOUVRE
INSERT INTO ASTA(ID_ASTA, RILANCIO_MIN, PREZZO_BASE, DATA_INIZIO, DATA_FINE, CODICE_OGGETTO) VALUES
('A000000022', 6000, 24000, to_date('01-02-2019 10:00','dd-mm-yyyy hh24:mi'),to_date('01-04-2019 18:00','dd-mm-yyyy hh24:mi'),'1000000010');




