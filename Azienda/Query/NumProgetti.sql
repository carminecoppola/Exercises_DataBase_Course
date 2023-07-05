/* -- Trovare il numero dei progetti su cui lavora ciascun impiegato */

SELECT		I.nome, COUNT(L.numero_progetto) AS numero_di_progetti
FROM		IMPIEGATO I JOIN LAVORA_SU L ON I.cf = L.cf_impiegato
GROUP BY 	I.nome;

/* -- Trovare il nome e il numero dei progetti degli impiegati che lavorano su più di 1 progetto */
SELECT		I.nome, COUNT(L.numero_progetto) AS numero_di_progetti
FROM		IMPIEGATO I JOIN LAVORA_SU L ON I.cf = L.cf_impiegato
GROUP BY 	I.nome
HAVING 		COUNT(L.numero_progetto) > 1;