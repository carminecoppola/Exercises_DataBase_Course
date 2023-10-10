/*  Un'asta si conclude con una vendita solo se ha avuto almeno 3 rilanci
    da parte di utenti diversi, se non ci sono rilanci di pari importo e 
    se il massimo rilancio è superiore al prezzo base di almeno il 10%.
*/

create or replace trigger controlliAsta before insert on asta
for each row
declare

    num_rilanci			NUMBER;
    max_rilancio		NUMBER;
	r_cont_uguali		NUMBER;
	p_base				NUMBER;

    minimo_rilanci		EXCEPTION;
	rilanci_uguali		EXCEPTION;
	massimo_rilancio	EXCEPTION;

begin

    --Minimo 3 rilanci di utenti diversi 
    
	SELECT 	count(distinct r.login)
    INTO 	num_rilanci
    FROM 	rilanciata r
    WHERE 	r.id_asta = :NEW.id_asta;

	IF num_rilanci < 3 THEN
        raise minimo_rilanci;
	END IF;

	--Rilanci uguali 

	SELECT	count(*)
    INTO	r_cont_uguali
    FROM (	SELECT	 r.prezzo_rilancio, count(*) as num_rilanci
        	FROM 	 rilanciata r
        	WHERE	 r.id_asta =:NEW.id_asta
        	GROUP BY r.prezzo_rilancio
        	HAVING count(*) > 1
    	 );

	IF r_cont_uguali > 0 THEN
        raise rilanci_uguali;
	END IF;

	-- Rilancio troppo basso
	SELECT  max(r.prezzo_rilancio), a.prezzo_base
    INTO	max_rilancio, p_base
    FROM	rilanciata r join asta a on r.id_asta = a.id_asta
    WHERE	a.id_asta =:NEW.id_asta;

	IF max_rilancio < p_base * 0.10 THEN
        raise massimo_rilancio;
	END IF;

	EXCEPTION
    	when minimo_rilanci then
    		raise_application_error('-20001','minimo_rilanci: asta non ha ricevuto almeno 3 rilanci');
		when rilanci_uguali then
    		raise_application_error('-20002','rilanci_uguali: il rilancio di questo prezzo e gia stato fatto');
		when massimo_rilancio then
    		raise_application_error('-20003','massimo_rilancio: non supera il 10% del prezzo base');
		
end;