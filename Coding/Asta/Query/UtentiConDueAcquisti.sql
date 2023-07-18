/*  2) Trovare il nome e il CF di tutti gli utenti che hanno effettuato più di due acquisti */

SELECT  U.nome, V.CF
FROM    UTENTE U JOIN RILANCIATA R ON U.login = R.login
                 JOIN ASTA A ON A.id_asta = R.id_asta
                 JOIN VENDITA V ON V.id_asta = A.id_asta
WHERE   R.prezzo_rilancio = V.prezzo_finale                  --Filtra solo i record in cui il prezzo di rilancio nella tabella RILANCIATA è uguale al prezzo finale nella tabella VENDITA.
HAVING COUNT(*)>2
GROUP BY V.CF, U.nome                                        -- Filtra solo gli utenti che hanno effettuato più di 2 acquisti. La funzione di aggregazione COUNT(*) conta il numero di record corrispondenti per ogni utente.                               

-- NB: NON darà output con questo popolamento

