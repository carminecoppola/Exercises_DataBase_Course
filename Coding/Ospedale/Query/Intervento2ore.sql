/*  Visualizzare la data di nascita e il sesso di tutte le persone che hanno subito un 
    intervento di durata superiore alle 2 ore nell'ultima settimana (si considera l'ora di 
    sistema come riferimento).   */


SELECT		P.data_nascita, P.sesso
FROM		PERSONA P JOIN PAZIENTE PZ ON(P.cf = PZ.cf)
					  JOIN INTERVENTO I ON(P.cf = I.cf_paz)
WHERE		(SYSDATE - I.data_e_ora > 7 AND I.durata > 2);