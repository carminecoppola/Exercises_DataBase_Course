/*  Un'asta si conclude con una vendita solo se ha avuto almeno 3 rilanci
    da parte di utenti diversi, se non ci sono rilanci di pari importo e 
    se il massimo rilancio è superiore al prezzo base di almeno il 10%.
*/

create or replace trigger ControlloAsta before insert on Vendita
for each row
declare

    pari_ril		NUMBER;
	max_ril			NUMBER;
    pz_base			NUMBER;
	num_ril			NUMBER;

    minmio_rilanci 	EXCEPTION;
    pari_rilanci	EXCEPTION;
    max_rilancio 	EXCEPTION;
    
begin


    /* 1) Un'asta si conclude con una vendita solo se ha avuto
   		  almeno 3 rilanci da parte di utenti diversi */

    select  count(DISTINCT r.login)
    into	num_ril
    from 	rilanciata r
    where	r.id_asta =:NEW.id_asta;

    IF	num_ril > 2 THEN
    	RAISE minmio_rilanci;
	END IF;
    
    -- 2) Se NON ci sono rilanci di pari importo

    select  count(*)
    into	pari_ril
    from	rilanciata r1 join rilanciata r2 on r1.id_asta = r2.id_asta
    where	r1.prezzo_rilancio = r2.prezzo_rilancio; -- Dovrebbe essere :=NEW.prezzo_rilancio ma da errore

    IF	pari_ril > 0 THEN
    	RAISE pari_rilanci;
	END IF;


    -- 3) Massimo rilancio è superiore al prezzo base di almeno il 10%

	SELECT 	MAX(r.prezzo_rilancio)
    INTO	max_ril
    FROM	rilanciata r
    WHERE	r.id_asta =:NEW.id_asta;

	SELECT 	prezzo_base
    INTO	pz_base
    FROM	asta a join rilanciata r on a.id_asta = r.id_asta
    WHERE	r.prezzo_rilancio = max_ril;

    -- Calcolo il prezzo base dell'oggetto messo all'asta grazie alla 
    -- riga WHERE r.prezzo_rilancio = max_ril calcolato in precedenza

	IF	max_ril <= pz_base * 0.10 THEN
    	RAISE max_rilancio;
	END IF;

    EXCEPTION
    	WHEN minmio_rilanci THEN
    		RAISE_APPLICATION_ERROR('-20001','minmio_rilanci');
    	WHEN pari_rilanci THEN
    		RAISE_APPLICATION_ERROR('-20002','pari_rilanci');
		WHEN max_rilancio THEN
    		RAISE_APPLICATION_ERROR('-20003','max_rilancio');
    	

end;

