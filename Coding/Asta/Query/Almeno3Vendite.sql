-- Recupera il nome degli utenti che hanno acquistato più di un oggetto nello stesso mese:


SELECT  u.nome,r.login, COUNT(*) as oggetti_acquistati
FROM    utente u JOIN rilanciata r ON u.login = r.login
                 JOIN asta a ON r.id_asta = a.id_asta
                 JOIN vendita v ON a.id_asta = v.id_asta
GROUP BY u.nome,r.login
HAVING COUNT(*) > 3;

/*
--Per controllare
    SELECT a.id_asta, r.login
    FROM asta a JOIN rilanciata r ON a.id_asta = r.id_asta 
                JOIN vendita v ON a.id_asta = v.id_asta
*/