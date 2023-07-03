/*  4) Trovare il login e il nome di tutti gli utenti che hanno rilanciato
       più di due volte, in ASTE DIVERSE, su un oggetto proveniente dal LOUVRE*/

SELECT  U.login, U.nome
FROM    UTENTE U JOIN RILANCIATA R ON U.login = R.login
                 JOIN ASTA A ON R.id_asta = A.id_asta
                 JOIN OGGETTO O ON A.codice_oggetto = O.codice_oggetto
WHERE   O.provenienza = 'LOUVRE'
GROUP BY U.login, U.nome
HAVING COUNT(DISTINCT A.id_asta) > 2;           --Quando si utilizza DISTINCT, vengono eliminati i duplicati e viene restituito solo un valore unico per ogni combinazione di valori nella colonna specificata.

--Output: 3 persone poiche la condizione è che abbiano rilanciato più di 2 volte 
