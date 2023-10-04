/*  7) Trovare il codice e la provenienza di tutti gli oggetti venduti 
       che sono stati all'asta almeno una volta nel mese di gennaio 
       (di qualsiasi anno)  */

SELECT 	 O.codice_oggetto, O.provenienza, A.data_inizio
FROM	 OGGETTO O JOIN ASTA A ON(O.codice_oggetto = a.codice_oggetto)
    	 		   JOIN VENDITA V ON(a.id_asta = v.id_asta)
WHERE	 EXTRACT(MONTH FROM A.data_inizio) = 1
GROUP BY O.codice_oggetto, O.provenienza, A.data_inizio
HAVING COUNT(DISTINCT(a.id_asta)) > 0;


