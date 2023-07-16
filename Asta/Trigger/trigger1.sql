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