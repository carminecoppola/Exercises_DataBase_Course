/* Trovare il CF e NOME degli impiegati che lavorano più di 300 ore su almeno un progetto */

SELECT		I.cf, I.nome
FROM		IMPIEGATO I JOIN LAVORA_SU L ON I.cf = L.cf_impiegato
WHERE 		L.ore >= 300;