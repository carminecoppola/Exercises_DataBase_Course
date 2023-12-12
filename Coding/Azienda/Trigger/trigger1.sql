
/*  Un impiegato che lavora per più di 200 ore su un progetto non può essere assegnato ad un
    secondo progetto. 
    Se un impiegato lavora su due progetti per più di 300 ore totali, non può essere
    assegnato ad un terzo.
    Un impiegato al massimo è assegnato a quattro progetti diversi.
    Eccezioni: 
        ore_progetto_sature, ore_progetti_sature, troppi_progetti.
*/


create or replace trigger ControlloAzienda before insert on LAVORA_SU
for each row
declare

	sum_ore				 NUMBER;
	num_progg_dist		 NUMBER;
    tot_ore_progg		 NUMBER;
    
    ore_progetto_sature  EXCEPTION;
	ore_progetti_sature  EXCEPTION;
	troppi_progetti 	 EXCEPTION;

begin

	select 	  DISTINCT SUM(l.ore)
    into	  sum_ore
    from	  impiegato i join lavora_su l on i.cf = l.cf_impiegato
	where	  l.numero_progetto =:NEW.numero_progetto
    group by  i.nome,l.numero_progetto;

	IF sum_ore > 200 THEN
        RAISE ore_progetto_sature;
	END IF;


	-- Piu di 2 progetti somma ore > 300
	select 	count(DISTINCT l.numero_progetto), sum(l.ore)
    into	num_progg_dist, tot_ore_progg
    from	impiegato i join lavora_su l on i.cf = l.cf_impiegato
    where	l.numero_progetto =:NEW.numero_progetto
    group by i.nome;
	

	IF num_progg_dist > 1 AND tot_ore_progg > 300 THEN	
        RAISE ore_progetti_sature;
	END IF;


	-- Un impiegato al massimo è assegnato a 4 progetti diversi

	IF num_progg_dist > 4 THEN
        RAISE troppi_progetti;
	END IF;
    

    EXCEPTION
    	WHEN ore_progetto_sature THEN
    		RAISE_APPLICATION_ERROR('-20001','ore_progetto_sature:');
		WHEN ore_progetti_sature THEN
    		RAISE_APPLICATION_ERROR('-20002','ore_progetti_sature:');
		WHEN troppi_progetti THEN
    		RAISE_APPLICATION_ERROR('-20003','troppi_progetti:');

end;