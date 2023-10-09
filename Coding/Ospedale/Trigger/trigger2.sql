/*  Un paziente non può subire più di due interventi in un mese. Questi devono avvenire a distanza
    di non meno di una settimana uno dall'altro e non possono essere dello stesso tipo.
    Eccezioni:
        too_frequent, time_interval_too_short, already_done. 
*/

CREATE OR REPLACE TRIGGER controllo_interventi
BEFORE INSERT OR UPDATE ON INTERVENTO 
FOR EACH ROW
DECLARE
    v_count NUMBER;
    v_last_intervento DATE;
    v_tipo_intervento VARCHAR2(30);
BEGIN    
    -- Controlla solo se viene inserito o aggiornato un nuovo intervento
    IF INSERTING OR (UPDATING AND :OLD.ID IS NULL) THEN
        -- Conta il numero di interventi del paziente nello stesso mese
        SELECT COUNT(*), MAX(DATA_E_ORA), MAX(TIPO)
        INTO v_count, v_last_intervento, v_tipo_intervento
        FROM INTERVENTO I
        WHERE cf_paz = :NEW.cf_paz
        AND EXTRACT(MONTH FROM DATA_E_ORA) = EXTRACT(MONTH FROM :NEW.DATA_E_ORA)
        AND EXTRACT(YEAR FROM DATA_E_ORA) = EXTRACT(YEAR FROM :NEW.DATA_E_ORA);

        -- Verifica se il paziente ha già effettuato 2 interventi nello stesso mese
        IF v_count >= 2 THEN
            RAISE_APPLICATION_ERROR(-20001, 'already_done: Il paziente ha già effettuato 2 interventi nello stesso mese.');
        END IF;

        -- Verifica se l'ultimo intervento è avvenuto meno di una settimana fa
        IF v_last_intervento IS NOT NULL AND :NEW.DATA_E_ORA - v_last_intervento < 7 THEN
            RAISE_APPLICATION_ERROR(-20002, 'time_interval_too_short: L''intervento deve avvenire almeno una settimana dopo l''ultimo intervento.');
        END IF;

        -- Verifica se il nuovo intervento ha lo stesso tipo dell'ultimo intervento
        IF v_tipo_intervento = :NEW.TIPO THEN
            RAISE_APPLICATION_ERROR(-20003, 'already_done: L''ultimo intervento è dello stesso tipo del nuovo intervento.');
        END IF;
    END IF;
END;




/* Inserimenti per provare:

1)  INSERT INTO INTERVENTO (ID, TIPO, DATA_E_ORA, DURATA, SALA_OP, CF_PAZ)
    VALUES (200, 'CHIRURGIA PLASTICA', TO_DATE('2023-07-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 'SALA UNO', 'AAA0000000000002');
2)  INSERT INTO INTERVENTO (ID, TIPO, DATA_E_ORA, DURATA, SALA_OP, CF_PAZ)
    VALUES (210, 'CHIRURGIA PLASTICA', TO_DATE('2023-07-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 'SALA DUE', 'AAA0000000000002');
*/




create or replace trigger controllopaziente before insert on intervento
for each row
declare
	num_int_mese			number(2,0);
	num_tip_div				number(2,0);
    
    too_frequent			EXCEPTION;
	time_interval_too_short	EXCEPTION;
	already_done			EXCEPTION;

begin
	select	count(i.id)
    into	num_int_mese
    from	intervento i join persona p on i.cf_paz = p.cf
    					 join paziente pz on p.cf = pz.cf
    where	(i.id =:NEW.id and i.data_e_ora >= SYSDATE - 31);


    IF num_int_mese > 2 THEN
    	RAISE too_frequent;
	END IF;


	select	count(i.tipo)
    into	num_tip_div
    from	intervento i join persona p on i.cf_paz = p.cf
    					 join paziente pz on p.cf = pz.cf
	where	(i.tipo =:NEW.tipo and i.id =:NEW.id);

    IF num_tip_div > 1 THEN
    	RAISE already_done;
	END IF;
        

    EXCEPTION
    	WHEN too_frequent THEN
    		RAISE_APPLICATION_ERROR('-20001','too_frequent: il paziente ha gia effettuato 2 interventi questo mese');
		WHEN already_done THEN
    		RAISE_APPLICATION_ERROR('-20002','already_done: il paziente ha gia effettuato gia un intervento di questo tipo');
end;

