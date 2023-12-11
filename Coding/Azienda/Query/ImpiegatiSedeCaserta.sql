/*Trova tutti gli impiegati che lavorano su un progetto nella città di 'Caserta':*/

SELECT 	DISTINCT i.cf,i.nome,i.cognome
FROM	impiegato i JOIN lavora_su l ON i.cf = l.cf_impiegato
					JOIN progetto p ON l.numero_progetto = p.numero_progetto
					JOIN dipartimento d ON p.dipartimento_responsabile = d.numero_dipartimento
WHERE	EXISTS(
    		SELECT 	1
    		FROM	sede_dipartimento sd
    		WHERE	sd.numero_dipartimento = d.numero_dipartimento AND sd.citta_sede = 'CASERTA'
);