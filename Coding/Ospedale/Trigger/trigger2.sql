/*  Un paziente non può subire più di due interventi in un mese. Questi devono avvenire a distanza
    di non meno di una settimana uno dall'altro e non possono essere dello stesso tipo.
    Eccezioni:
        too_frequent, time_interval_too_short, already_done. 
*/

create or replace trigger controlloInterv before insert on intervento
for each row
declare

    num_int_mensili			number;
	num_int_sett			number;
	num_tipo				number;

    too_frequent			EXCEPTION;
    time_interval_too_short	EXCEPTION;
    already_done			EXCEPTION;
    
begin

	--1)Mese
    select	count(*)
    into	num_int_mensili
    from	paziente pz join persona p on pz.cf = p.cf
    					join intervento i on p.cf = i.cf_paz
	where	i.id =:NEW.id and i.data_e_ora <= SYSDATE - 31;


	if num_int_mensili > 2	then
        raise too_frequent;
	end if;

	--2)Settimana
	select	count(*)
    into	num_int_sett
    from	paziente pz join persona p on pz.cf = p.cf
    					join intervento i on p.cf = i.cf_paz
    where	i.id =:NEW.id and i.data_e_ora <= SYSDATE - 7;
        

	if num_int_sett > 1	then
        raise time_interval_too_short;
	end if;


	--3)Stesso Tipo

	select	count(i.tipo)
    into	num_tipo
    from	paziente pz join persona p on pz.cf = p.cf
    					join intervento i on p.cf = i.cf_paz
    where	i.tipo =:NEW.tipo and i.data_e_ora <= SYSDATE - 7;

	if num_tipo > 1 then
        raise already_done;
	end if;
        
    

    EXCEPTION
        WHEN too_frequent THEN
    		raise_application_error('-20001','too_frequent: questo paziente ha gia subito 2 interventi questo mese');
		WHEN time_interval_too_short THEN
    		raise_application_error('-20002','time_interval_too_short: questo paziente ha gia subito un intervento questa settimana');
		WHEN already_done THEN
    		raise_application_error('-20003','already_done: questo paziente ha gia subito un interento di questo tipo in questa settimana');
		
end;


-------
/*  Un paziente non può subire più di due interventi in un mese. Questi devono avvenire a distanza
    di non meno di una settimana uno dall'altro e non possono essere dello stesso tipo.
    Eccezioni:
        too_frequent, time_interval_too_short, already_done. 
*/


create or replace trigger ControlloPazienti before insert on Intervento
for each row
declare

	num_int						NUMBER;
	num_int_sett				NUMBER;
	stesso_tipo					NUMBER;
    too_frequent				EXCEPTION;
	time_interval_too_short		EXCEPTION;
    already_done				EXCEPTION;
begin

	select 	count(*)
    into	num_int
    from	intervento i 
    where	i.cf_paz =:NEW.cf_paz AND i.data_e_ora > SYSDATE - 31 ;


    IF num_int > 1 THEN
        RAISE too_frequent;
	END IF;


	select 	count(*)
    into 	num_int_sett
    from	intervento i
    where	i.cf_paz =:NEW.cf_paz AND i.data_e_ora > SYSDATE - 7 ;
    
    IF num_int_sett > 0 THEN
        RAISE time_interval_too_short;
	END IF;


	select 	count(*)
    into	stesso_tipo
    from	intervento i
    where	i.cf_paz =:NEW.cf_paz and i.tipo =:NEW.tipo;

    IF stesso_tipo > 0 THEN
        RAISE already_done;
	END IF;

	EXCEPTION
		WHEN too_frequent THEN
    		RAISE_APPLICATION_ERROR('-20001','too_frequent');
		WHEN time_interval_too_short THEN
    		RAISE_APPLICATION_ERROR('-20002','time_interval_too_short');
		WHEN already_done THEN
    		RAISE_APPLICATION_ERROR('-20003','already_done');
    
end;



