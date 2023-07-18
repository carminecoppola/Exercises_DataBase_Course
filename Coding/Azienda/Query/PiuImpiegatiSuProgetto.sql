/* Trovare il NOME dei progetti su cui lavorano più di due impiegati*/

SELECT		P.nome_progetto
FROM		IMPIEGATO I JOIN LAVORA_SU L ON I.cf = L.cf_impiegato
						JOIN PROGETTO P ON L.numero_progetto = P.numero_progetto
GROUP BY	P.numero_progetto, P.nome_progetto
HAVING		COUNT(L.cf_impiegato) > 2;

--Oppure:
SELECT		P.nome_progetto
FROM		IMPIEGATO I JOIN LAVORA_SU L ON I.cf = L.cf_impiegato
						JOIN PROGETTO P ON L.numero_progetto = P.numero_progetto
GROUP BY	P.numero_progetto, P.nome_progetto
HAVING		COUNT(*) > 2;