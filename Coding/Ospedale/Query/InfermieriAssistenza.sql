/*  Visualizzare i nomi e i cognomi degli infermieri che hanno assistito almeno due 
    interventi nell'ultima settimana (si considera l'ora di sistema come riferimento) */

SELECT		P.nome, P.cognome, COUNT(*) AS Interventi
FROM		PERSONA P JOIN INFERMIERE F ON(P.cf = F.cf)
				  	  JOIN ASSISTE A ON(F.cf = A.cf_inf)
				      JOIN INTERVENTO I ON(A.id_int = I.id)
WHERE		(SYSDATE - I.data_e_ora) > 7 -- Più complesso potremmo fare it.data_e_ora > SYSDATE - 7
GROUP BY	P.nome, P.cognome
HAVING	COUNT(*) > 1;



/*  Visualizzare i nomi e i cognomi degli infermieri che hanno assistito almeno due 
    interventi nell'ultimo mese (si considera l'ora di sistema come riferimento) */

select p.nome,p.cognome, count(*) as int_last_week
from persona p join infermiere i on (p.cf = i.cf)
			   join assiste a on (i.cf = a.cf_inf)
			   join intervento it on (a.id_int = it.id)
where it.data_e_ora >= SYSDATE - 28
group by p.nome, p.cognome
having count(*) >  1