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







/*  Un oggetto non può essere rimesso all'asta se è stato già venduto oppure se non è passata
    più di una settimana dall'ultima volta che è stato messo all'asta rimanendo invenduto.
    Gli oggetti di provenienza 'LOUVRE' non possono andare all'asta.
    Eccezioni: 
        oggetto_gia_venduto, periodo_trascorso_dall_ultima_asta_troppo_breve, oggetto_non_valido
*/



create or replace trigger controlloOggetti before insert on asta
for each row
declare 

	oggetto_venduto		number;
	poco_tempo			number;
	oggetto_louvre		number;
    
	oggetto_gia_venduto				 EXCEPTION;
	periodo_trasc_ultima_asta_breve  EXCEPTION;
	oggetto_non_valido				 EXCEPTION;


begin

    select 	count(*)
    into	oggetto_venduto
    from 	asta a join vendita v on a.id_asta = v.id_asta
	where	a.id_asta =:NEW.id_asta;

	select 	count(*)
    into	poco_tempo
    from 	asta a join vendita v on a.id_asta = v.id_asta
	where	a.codice_oggetto =:NEW.codice_oggetto and a.data_fine >= SYSDATE - 7;

	select	count(*)
    into	oggetto_louvre
    from 	asta a join ( select 	o.codice_oggetto, o.provenienza
        			   	  from		oggetto o 
        			      where		o.provenienza = 'LOUVRE'
    				    )subq on a.codice_oggetto = subq.codice_oggetto;


	if oggetto_venduto > 0 then
    	raise oggetto_gia_venduto;
	end if;

	if poco_tempo > 0 then
    	raise periodo_trasc_ultima_asta_breve;
	end if;

    if oggetto_louvre > 0 then
        	raise oggetto_non_valido;
	end if;

        
	exception
        when oggetto_gia_venduto then
        	raise_application_error('-20001','oggetto_gia_venduto: asta di questo oggetto è gia terminata');
		when periodo_trasc_ultima_asta_breve then
            raise_application_error('-20002','periodo_trasc_ultima_asta_breve: oggetto messo all asta prima di una settimana');
		when oggetto_non_valido then
            raise_application_error('-20003','oggetto_non_valido: oggetto proveniente da louvre');

end; 