/*  
	Un medico può partecipare al massimo a 10 interventi in una settimana, al più di tre 
	tipi diversi. In ogni intervento almeno due medici devono avere la stessa specializzazione.
		- MaxInterventi, MaxTipoInterventi, MinMediciSpecializ
*/

create or replace trigger ControlloMedici 
before insert on effettua
for each row
declare
    num_int_sett        NUMBER;
    num_int_distinti    NUMBER;
    num_medici_stessa_specializzazione NUMBER;

    MaxInterventi       EXCEPTION;
    MaxTipoInterventi   EXCEPTION;
    MinMediciSpecializ  EXCEPTION;

begin

    -- Controlla il numero di interventi in una settimana e le tipologie
    select  count(*), count(distinct i.tipo)
    into    num_int_sett, num_int_distinti
    from    effettua e 
            join intervento i on e.id_int = i.id
    where   e.id_int = :NEW.id_int and i.data_e_ora >= SYSDATE - 7;

    IF num_int_sett > 9 THEN
        RAISE MaxInterventi;
    END IF;

    IF num_int_distinti > 2 THEN
        RAISE MaxTipoInterventi;
    END IF;

    -- Controlla che ci siano almeno due medici con la stessa specializzazione nello stesso intervento
    select  count(distinct m.cf)
    into    num_medici_stessa_specializzazione
    from    effettua e
            join medico m on e.cf_med = m.cf
    where   e.id_int = :NEW.id_int
    group by m.specializzazione
    having count(distinct m.cf) < 2;    -- Chi contiene meno di due medici con la stessa specializzazione

    IF num_medici_stessa_specializzazione > 0 THEN  -- Quindi se c'è qualcuno che fa un intervento con meno di due medici da Errore
        RAISE MinMediciSpecializ;
    END IF;

EXCEPTION
    WHEN MaxInterventi THEN
        RAISE_APPLICATION_ERROR('-20001', 'MaxInterventi');
    WHEN MaxTipoInterventi THEN
        RAISE_APPLICATION_ERROR('-20002', 'MaxTipoInterventi');
    WHEN MinMediciSpecializ THEN
        RAISE_APPLICATION_ERROR('-20003', 'MinMediciSpecializ');

end;
