/* -- Trovare il numero dei progetti su cui lavora ciascun impiegato */

SELECT 	DISTINCT i.cognome, i.nome,p.numero_progetto, count(DISTINCT p.numero_progetto) AS num_progetti
FROM	impiegato i JOIN lavora_su l ON i.cf = l.cf_impiegato
					JOIN progetto p ON l.numero_progetto = p.numero_progetto
GROUP BY  i.cognome, i.nome,p.numero_progetto;




/* -- Trovare il nome e il numero dei progetti degli impiegati che lavorano su più di 1 progetto */
SELECT		I.nome, COUNT(L.numero_progetto) AS numero_di_progetti
FROM		IMPIEGATO I JOIN LAVORA_SU L ON I.cf = L.cf_impiegato
GROUP BY 	I.nome
HAVING 		COUNT(L.numero_progetto) > 1;