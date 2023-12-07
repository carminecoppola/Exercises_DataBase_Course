/*  Visualizzare i nomi e i cognomi degli infermieri che hanno assistito almeno due 
    interventi nell'ultima settimana (si considera l'ora di sistema come riferimento) */

SELECT		P.nome, P.cognome, COUNT(DISTINCT I.id) AS Interventi
FROM		PERSONA P JOIN INFERMIERE F ON(P.cf = F.cf)
				  	  JOIN ASSISTE A ON(F.cf = A.cf_inf)
				      JOIN INTERVENTO I ON(A.id_int = I.id)
WHERE		I.data_e_ora > SYSDATE - 7 -- Più complesso potremmo fare it.data_e_ora > SYSDATE - 7
GROUP BY	P.nome, P.cognome
HAVING	COUNT(DISTINCT I.id) > 2;

-- Per controllare
select 	it.data_e_ora,p.nome
from	intervento it join assiste a on it.id = a.id_int
					  join infermiere i on a.cf_inf = i.cf
					  join persona p on i.cf = p.cf
order by it.data_e_ora DESC