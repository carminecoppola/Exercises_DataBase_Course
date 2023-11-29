/*  Visualizzare il nome e cognome degli utenti che nell'anno scorso (fa fede la data di sistema)
    hanno partecipato solo ad aste su opere d'arte di provenienza 'LOUVRE' terminate con una vendita 

	Dovrebbe ritornarmi solo GIANFRANCO
*/

SELECT 	DISTINCT u1.nome, u1.cognome, o1.provenienza
FROM 	utente u1 JOIN 	rilanciata r1 ON u1.login = r1.login
				  JOIN 	asta a1 ON r1.id_asta = a1.id_asta
				  JOIN 	oggetto o1 ON a1.codice_oggetto = o1.codice_oggetto
WHERE 	o1.provenienza = 'LOUVRE' 
AND 	NOT EXISTS (
            SELECT 1
            FROM utente u2 
            JOIN rilanciata r2 ON u2.login = r2.login
            JOIN asta a2 ON r2.id_asta = a2.id_asta
            JOIN oggetto o2 ON a2.codice_oggetto = o2.codice_oggetto
            WHERE u1.login = u2.login AND a2.data_inizio >= SYSDATE - 365
        )
AND 	NOT EXISTS (
            SELECT 1
            FROM utente u3 
            JOIN rilanciata r3 ON u3.login = r3.login
            JOIN asta a3 ON r3.id_asta = a3.id_asta
            JOIN oggetto o3 ON a3.codice_oggetto = o3.codice_oggetto
            WHERE u1.login = u3.login AND o3.provenienza <> 'LOUVRE'
        );


-- Controlla con questo:
select 	u.nome,u.cognome, o.provenienza
from	utente u join rilanciata r on u.login = r.login
				 join asta a on r.id_asta = a.id_asta
				 join oggetto o on a.codice_oggetto = o.codice_oggetto