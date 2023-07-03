/*  3) Trovare il login e il nome di tutti gli utenti che hanno rilanciato almeno
       tre volte su almeno un oggetto proveniente dal LOUVRE*/ 

SELECT  U.login, U.nome
FROM    UTENTE U JOIN RILANCIATA R ON U.login = R.login
                 JOIN ASTA A ON R.id_asta = A.id_asta
                 JOIN OGGETTO O ON A.codice_oggetto = O.codice_oggetto
WHERE   O.provenienza = 'LOUVRE'
GROUP BY U.login, U.nome
HAVING COUNT(*) >= 3;