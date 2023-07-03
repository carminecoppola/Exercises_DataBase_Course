-- TRACCIA: Per ogni utente, trovare il suo login, il suo nome e il numero di aste 
-- NON CONCLUSE con una vendita in cui ha partecipato. (Output: 5 persone)

SELECT 	U.login, U.nome, COUNT(R.id_asta) AS num_aste_non_concluse      --L'alias "num_aste_non_concluse" viene assegnato alla colonna di conteggio.
FROM 	UTENTE U JOIN RILANCIATA R ON U.login = R.login                 --Effettua una join tra la tabella UTENTE e la tabella RILANCIATA utilizzando il campo "login" per collegare le due tabelle.
    		  	 JOIN ASTA A ON A.id_asta = R.id_asta                   --Effettua una join tra la tabella RILANCIATA e la tabella ASTA utilizzando il campo "id_asta" per collegare le due tabelle.
WHERE   A.id_asta NOT IN (SELECT id_asta FROM VENDITA)                  --Filtra solo le aste che non sono presenti nella tabella VENDITA, ovvero le aste non concluse con una vendita.
GROUP BY U.login, U.nome;                                               --Raggruppa i risultati per login e nome dell'utente, in modo da ottenere un unico risultato per ogni utente.


