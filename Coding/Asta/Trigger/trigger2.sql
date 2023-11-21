/*  Un oggetto non può essere rimesso all'asta se è stato già venduto oppure se non è passata
    più di una settimana dall'ultima volta che è stato messo all'asta rimanendo invenduto.
    Gli oggetti di provenienza 'LOUVRE' non possono andare all'asta.
    Eccezioni: 
        oggetto_già_venduto, periodo_trascorso_dall_ultima_asta_troppo_breve, oggetto_non_valido
*/


CREATE OR REPLACE TRIGGER ControlloAsta BEFORE INSERT ON Asta
FOR EACH ROW
DECLARE

ogg_vend		NUMBER;
poco_tempo		NUMBER;
prov_ogg		CHAR;

oggetto_gia_venduto    							   EXCEPTION;
periodo_trascorso_dall_ultima_asta_troppo_breve    EXCEPTION;
oggetto_non_valido    							   EXCEPTION;
BEGIN

	-- Un oggetto non può essere rimesso all'asta se è stato già venduto

    	SELECT	COUNT(*)
        INTO	ogg_vend
        FROM	ASTA A JOIN VENDITA V ON A.id_asta = V.id_asta 
    				   JOIN OGGETTO O ON A.codice_oggetto = O.codice_oggetto
        WHERE	A.codice_oggetto =:NEW.codice_oggetto;

		IF	ogg_vend >= 1 THEN
            RAISE oggetto_gia_venduto;
		END IF;
    
    
    -- oppure se non è passata più di una settimana dall'ultima volta che è stato messo all'asta rimanendo invenduto.

		SELECT	COUNT(*)
        INTO	poco_tempo
        FROM	ASTA 
        WHERE	codice_oggetto =:NEW.codice_oggetto AND data_fine >:NEW.data_inizio - 7;

		IF	poco_tempo >= 1 THEN
            RAISE periodo_trascorso_dall_ultima_asta_troppo_breve;
		END IF;
    
	-- Gli oggetti di provenienza 'LOUVRE' non possono andare all'asta.

    	SELECT 	O.provenienza
    	INTO 	prov_ogg
    	FROM	Asta A JOIN Oggetto O ON (A.codice_oggetto =  O.codice_oggetto)
        WHERE	O.codice_oggetto =:NEW.codice_oggetto;


    	IF (prov_ogg = 'LOUVRE') THEN
    		RAISE oggetto_non_valido;
		END IF;


	EXCEPTION
        WHEN oggetto_gia_venduto THEN
	        RAISE_APPLICATION_ERROR('-20001','oggetto_gia_venduto:');
		 WHEN periodo_trascorso_dall_ultima_asta_troppo_breve THEN
	        RAISE_APPLICATION_ERROR('-20002','periodo_trascorso_dall_ultima_asta_troppo_breve:');
		 WHEN oggetto_non_valido THEN
	        RAISE_APPLICATION_ERROR('-20003','oggetto_non_valido:');
		
    
END;


-- Altra Prova Ma credo Sbagliata


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

