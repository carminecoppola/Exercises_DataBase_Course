/* 6) Visualizzare tutti gli Autori e tutti i Tipi di tutte le opere d'arte che non 
      sono mai state messe all'asta */

SELECT      OP.autore, OP.tipo
FROM        opera_d_arte OP JOIN oggetto O ON OP.codice_oggetto = O.codice_oggetto
                            LEFT JOIN asta A ON O.codice_oggetto = A.codice_oggetto
WHERE A.codice_oggetto IS NULL;




--GIUSTA
SELECT   OA.autore, OA.tipo
FROM	   OGGETTO O JOIN OPERA_D_ARTE OA ON (O.codice_oggetto = OA.codice_oggetto)
WHERE	   O.codice_oggetto NOT IN (SELECT  A.codice_oggetto FROM  ASTA A);

