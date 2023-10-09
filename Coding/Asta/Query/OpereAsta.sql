/* 6) Visualizzare tutti gli Autori e tutti i Tipi di tutte le opere d'arte che non 
      sono mai state messe all'asta */

SELECT  OP.autore, OP.tipo
FROM    OPERA_D_ARTE OP JOIN OGGETTO O ON OP.codice_oggetto = O.codice_oggetto
                        JOIN ASTA A ON O.codice_oggetto = A.codice_oggetto
WHERE   O.codice_oggetto NOT IN (SELECT codice_oggetto FROM ASTA)
GROUP BY OP.autore, OP.tipo;

-- no data found

--select  autore,tipo,codice_oggetto
--from    opera_d_arte;
--select  codice_oggetto
--from    asta;

--GIUSTA
SELECT   OA.autore, OA.tipo
FROM	   OGGETTO O JOIN OPERA_D_ARTE OA ON (O.codice_oggetto = OA.codice_oggetto)
WHERE	   O.codice_oggetto NOT IN (SELECT  A.codice_oggetto FROM  ASTA A);

