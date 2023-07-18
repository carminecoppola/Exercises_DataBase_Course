/*  5) Trovare il codice e la provenienza di tutti gli oggetti venduti 
       che sono stati all'asta più di due volte nel mese di dicembre 
       (di qualsiasi anno)  */

SELECT  O.codice_oggetto, O.provenienza
FROM    OGGETTO O JOIN ASTA A ON O.codice_oggetto = A.codice_oggetto
                  JOIN VENDITA V ON A.id_asta = V.id_asta
WHERE   EXTRACT(MONTH FROM A.data_inizio) = 12      --Filtra solo le aste che hanno avuto luogo nel mese di dicembre. Utilizziamo la funzione EXTRACT per estrarre il mese dalla colonna "data_inizio" nella tabella ASTA e confrontarlo con il valore 12.
GROUP BY O.codice_oggetto, O.provenienza
HAVING COUNT(DISTINCT A.id_asta) > 2;               --Filtra solo gli oggetti che sono stati all'asta più di due volte. La funzione di aggregazione COUNT(DISTINCT A.id_asta) conta il numero di aste distinte in cui l'oggetto è stato all'asta.
