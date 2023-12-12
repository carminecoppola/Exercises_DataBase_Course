/* Trova tutti gli utenti che hanno partecipato a tutte le aste di Maggio */

SELECT 	DISTINCT r.login,a.data_inizio
FROM	rilanciata r JOIN asta a ON r.id_asta = a.id_asta
WHERE	EXISTS(
    		SELECT 	1
    		FROM	asta a2
    		WHERE	EXTRACT(MONTH FROM a.data_inizio) = 5 AND 
    			EXISTS(
        				SELECT  1
        				FROM    rilanciata r2 
        				WHERE	r.id_asta <> r2.id_asta AND r.login = r2.login
    				)
		);