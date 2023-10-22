/*  Visualizzare la data di nascita e il sesso di tutte le persone che hanno subito un 
    intervento di durata superiore alle 2 ore nell'ultima settimana (si considera l'ora di 
    sistema come riferimento).   */


SELECT		P.data_nascita, P.sesso
FROM		PERSONA P JOIN PAZIENTE PZ ON(P.cf = PZ.cf)
					  JOIN INTERVENTO I ON(P.cf = I.cf_paz)
WHERE		(SYSDATE - I.data_e_ora > 7 AND I.durata > 2);


select	p.cf ,p.nome, p.data_nascita, subq.cf_paz, subq.data_e_ora, subq.durata
from	persona p join (
                         select	 i.cf_paz,i.durata,i.data_e_ora
                         from	 intervento i
                         where	 i.durata > 2 and i.data_e_ora < sysdate - 7
    					) subq on p.cf = subq.cf_paz
order by subq.durata desc;


--Dovrebbe essere più giusta con il popolamento aggiornato
SELECT P.cf ,P.nome, P.data_nascita, P.sesso,subq.data_e_ora, subq.durata
    FROM persona P JOIN(
		SELECT 	P.nome, IT.cf_paz ,IT.durata, IT.data_e_ora
		FROM	persona P JOIN paziente PZ on(P.cf = PZ.cf)
    			  JOIN intervento IT on(P.cf = IT.cf_paz)
		WHERE	IT.durata > 2
    )subq on subq.cf_paz = P.cf
WHERE SYSDATE - subq.data_e_ora > 7
order by subq.durata desc;