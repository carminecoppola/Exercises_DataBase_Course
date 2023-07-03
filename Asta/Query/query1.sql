/*  1) Per ogni utente, trovare il suo login, il suo nome e il numero di aste 
       NON CONCLUSE con una vendita in cui ha partecipato. (Output: 5 persone)*/

SELECT 	U.login, U.nome, COUNT(R.id_asta) AS num_aste_non_concluse      --L'alias "num_aste_non_concluse" viene assegnato alla colonna di conteggio.
FROM 	UTENTE U JOIN RILANCIATA R ON U.login = R.login                 --Effettua una join tra la tabella UTENTE e la tabella RILANCIATA utilizzando il campo "login" per collegare le due tabelle.
    		  	 JOIN ASTA A ON A.id_asta = R.id_asta                   --Effettua una join tra la tabella RILANCIATA e la tabella ASTA utilizzando il campo "id_asta" per collegare le due tabelle.
WHERE   A.id_asta NOT IN (SELECT id_asta FROM VENDITA)                  --Filtra solo le aste che non sono presenti nella tabella VENDITA, ovvero le aste non concluse con una vendita.
GROUP BY U.login, U.nome;                                               --Raggruppa i risultati per login e nome dell'utente, in modo da ottenere un unico risultato per ogni utente.



/*  2) Trovare il nome e il CF di tutti gli utenti che hanno effettuato più di due acquisti */

SELECT  U.nome, V.CF
FROM    UTENTE U JOIN RILANCIATA R ON U.login = R.login
                 JOIN ASTA A ON A.id_asta = R.id_asta
                 JOIN VENDITA V ON V.id_asta = A.id_asta
WHERE   R.prezzo_rilancio = V.prezzo_finale                  --Filtra solo i record in cui il prezzo di rilancio nella tabella RILANCIATA è uguale al prezzo finale nella tabella VENDITA.
HAVING COUNT(*)>2
GROUP BY V.CF, U.nome                                        -- Filtra solo gli utenti che hanno effettuato più di 2 acquisti. La funzione di aggregazione COUNT(*) conta il numero di record corrispondenti per ogni utente.                               

-- NB: NON darà output con questo popolamento


/*  3) Trovare il login e il nome di tutti gli utenti che hanno rilanciato almeno
       tre volte su almeno un oggetto proveniente dal LOUVRE*/ 

SELECT  U.login, U.nome
FROM    UTENTE U JOIN RILANCIATA R ON U.login = R.login
                 JOIN ASTA A ON R.id_asta = A.id_asta
                 JOIN OGGETTO O ON A.codice_oggetto = O.codice_oggetto
WHERE   O.provenienza = 'LOUVRE'
GROUP BY U.login, U.nome
HAVING COUNT(*) >= 3;


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


/*  5) Trovare il codice e la provenienza di tutti gli oggetti venduti 
       che sono stati all'asta più di due volte nel mese di dicembre 
       (di qualsiasi anno)  */

SELECT  O.codice_oggetto, O.provenienza
FROM    OGGETTO O JOIN ASTA A ON O.codice_oggetto = A.codice_oggetto
                  JOIN VENDITA V ON A.id_asta = V.id_asta
WHERE   EXTRACT(MONTH FROM A.data_inizio) = 12      --Filtra solo le aste che hanno avuto luogo nel mese di dicembre. Utilizziamo la funzione EXTRACT per estrarre il mese dalla colonna "data_inizio" nella tabella ASTA e confrontarlo con il valore 12.
GROUP BY O.codice_oggetto, O.provenienza
HAVING COUNT(DISTINCT A.id_asta) > 2;               --Filtra solo gli oggetti che sono stati all'asta più di due volte. La funzione di aggregazione COUNT(DISTINCT A.id_asta) conta il numero di aste distinte in cui l'oggetto è stato all'asta.
