/*
    Restituire i medici (CF1) e i loro colleghi con la stessa specializzazione (CF2) 
    che hanno eseguito lo stesso intervento.
*/

SELECT DISTINCT p.nome, p.cognome, m.cf AS CF1, m1.cf AS CF2
FROM persona p JOIN medico m ON p.cf = m.cf
               JOIN effettua e ON m.cf = e.cf_med
               JOIN intervento i ON e.id_int = i.id
               JOIN medico m1 ON m.cf <> m1.cf      --(SELF JOIN)
WHERE m.specializzazione = m1.specializzazione
    AND EXISTS (                                    -- EXISTS(Query Innestata Correlata)
        SELECT 1
        FROM effettua e1
        JOIN medico m2 ON e1.cf_med = m2.cf
        JOIN intervento i2 ON e1.id_int = i2.id
        WHERE m.cf = m2.cf AND i.id = i2.id
    );
