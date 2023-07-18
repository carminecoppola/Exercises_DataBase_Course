/* 6) Visualizzare tutti gli Autori e tutti i Tipi di tutte le opere d'arte che non 
      sono mai state messe all'asta */

SELECT  OP.autore, OP.tipo
FROM    OPERA_D_ARTE OP JOIN OGGETTO O ON OP.codice_oggetto = O.codice_oggetto
                        JOIN ASTA A ON O.codice_oggetto = A.codice_oggetto
WHERE   O.codice_oggetto NOT IN (SELECT codice_oggetto FROM ASTA)
GROUP BY OP.autore, OP.tipo;


--NON LO SO
SELECT  OP.autore, OP.tipo
FROM    OPERA_D_ARTE OP JOIN OGGETTO O ON OP.codice_oggetto = O.codice_oggetto
                        JOIN ASTA A ON O.codice_oggetto = A.codice_oggetto
WHERE   A.codice_oggetto IS NULL
GROUP BY OP.autore, OP.tipo;
