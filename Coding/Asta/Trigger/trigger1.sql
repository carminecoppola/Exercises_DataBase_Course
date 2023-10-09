/*  La durata di un'asta non può essere inferiore a tre giorni. 
    In un mese un oggetto non può essere messo all'asta più di tre volte. 
    Il rilancio minimo dev'essere almeno il 10% del prezzo base. 
    Eccezioni: 
        rilancio_minimo_troppo_basso, asta_troppo_breve, oggetto_troppe_volte_in_vendita. 
*/

CREATE OR REPLACE TRIGGER ControlloAsta BEFORE INSERT ON ASTA
FOR EACH ROW
DECLARE
    rilancio      NUMBER;
    Pzbase        NUMBER;
    dStart        DATE;
    dEnd          DATE;
    contatore     NUMBER;
    mese_attuale  VARCHAR2(7);

BEGIN
    SELECT  rilancio_min, prezzo_base
    INTO    rilancio, Pzbase
    FROM    ASTA
    WHERE   id_asta = :NEW.id_asta;

    IF (rilancio < (Pzbase * 0.1)) THEN
        RAISE_APPLICATION_ERROR(-2990, 'rilancio_minimo_troppo_basso: il prezzo di rilancio è inferiore al 10% del prezzo base');
    END IF;

    SELECT  data_inizio, data_fine
    INTO    dStart, dEnd
    FROM    ASTA
    WHERE   id_asta = :NEW.id_asta;

    IF (dEnd - dStart < 3) THEN
        RAISE_APPLICATION_ERROR(-2991, 'asta_troppo_breve: la durata di un asta non può essere inferiore a tre giorni');
    END IF;

    -- Calcola il mese corrente nel formato 'YYYY-MM'
    mese_attuale := TO_CHAR(SYSDATE, 'YYYY-MM');

    -- Conta quante volte l'oggetto è stato messo all'asta nel mese corrente
    SELECT COUNT(*)
    INTO contatore
    FROM ASTA
    WHERE codice_oggetto = :NEW.codice_oggetto
    AND TO_CHAR(data_inizio, 'YYYY-MM') = mese_attuale;

    IF contatore >= 3 THEN
        RAISE_APPLICATION_ERROR(-2992, 'oggetto_troppe_volte_in_vendita: In un mese un oggetto non può essere messo all asta più di tre volte');
    END IF;

END;


/*  La durata di un'asta non può essere inferiore a tre giorni. 
    In un mese un oggetto non può essere messo all'asta più di tre volte. 
    Il rilancio minimo dev'essere almeno il 10% del prezzo base. 
    Eccezioni: 
        rilancio_minimo_troppo_basso, asta_troppo_breve, oggetto_troppe_volte_in_vendita. 
*/

create or replace trigger controlloAsta before insert on asta
for each row
declare

	d_s 		DATE;
    d_f			DATE;
	cont_ogg	NUMBER;
	r_min		NUMBER;
	p_base		NUMBER;
    
    rilancio_minimo_troppo_basso	EXCEPTION;
	asta_troppo_breve				EXCEPTION;
	oggetto_troppe_volte_in_vendita	EXCEPTION;
	
begin

    select	data_inizio, data_fine
    into	d_s, d_f
    from	asta
    where	id_asta =:NEW.id_asta;

	if (d_f - d_s) < 3 then
        raise asta_troppo_breve;
	end if;


	select	count(*)
    into	cont_ogg
    from 	asta 
    where	(codice_oggetto =:NEW.codice_oggetto and TO_DATE(data_inizio,'MM')= TO_DATE(:NEW.data_inizio,'MM'));

	if cont_ogg > 3 then
        raise oggetto_troppe_volte_in_vendita;
	end if;

	select 	rilancio_min, prezzo_base
    into 	r_min,p_base
    from	asta
    where	id_asta =:NEW.id_asta;

    if r_min < p_base * 0.10 then
        raise rilancio_minimo_troppo_basso;
	end if;

	exception
        when asta_troppo_breve then
        	raise_application_error('-20001','asta_troppo_breve: asta che ha una durata inferiore a 3 giorni ');
		when oggetto_troppe_volte_in_vendita then
        	raise_application_error('-20002','oggetto_troppe_volte_in_vendita: oggetto messo in vendita più di 3 volte ');
    	when rilancio_minimo_troppo_basso then
            raise_application_error('-20003','rilancio_minimo_troppo_basso: il prezzo del rilancio minimo è troppo basso');
end;