/* Trova l'età media dei dipendenti in ciascun dipartimento:*/

SELECT 	 d.nome_dipartimento , d.numero_dipartimento, 
    	 TRUNC(AVG(EXTRACT(YEAR FROM SYSDATE)) - AVG(EXTRACT(YEAR FROM i.data_nascita)),2) as Età_media
FROM	 dipartimento d JOIN impiegato i ON d.cf_direttore = i.cf_supervisore
GROUP BY d.nome_dipartimento , d.numero_dipartimento
ORDER BY d.numero_dipartimento 


-- Utilizzo TRUNC sulla media per ottenere soltanto le prime due cifre dopo la virgola TRUNC(... , 2).
-- Calcolo la media in facendo la differenza con la data attuale cosi da non avere l'anno di nascita.