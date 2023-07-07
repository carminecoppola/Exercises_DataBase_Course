/*  Visualizzare i nomi e i cognomi degli infermieri che hanno assistito almeno due 
    interventi nell'ultima settimana (si considera l'ora di sistema come riferimento) */

SELECT		P.nome, P.cognome, COUNT(*) AS Interventi
FROM		PERSONA P JOIN INFERMIERE F ON(P.cf = F.cf)
				  	  JOIN ASSISTE A ON(F.cf = A.cf_inf)
				      JOIN INTERVENTO I ON(A.id_int = I.id)
WHERE		(SYSDATE - I.data_e_ora) > 7
GROUP BY	P.nome, P.cognome
HAVING	COUNT(*) > 1;

