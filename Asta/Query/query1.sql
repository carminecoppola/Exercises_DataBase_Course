-- TRACCIA: Per ogni utente, trovare il suo login, il suo nome e il numero di aste 
-- NON CONCLUSE con una vendita in cui ha partecipato. (Output: 5 persone)

SELECT 	U.login, U.nome, COUNT(R.id_asta) AS num_aste_non_concluse
FROM 	UTENTE U JOIN RILANCIATA R ON U.login = R.login 
    		  	 JOIN ASTA A ON A.id_asta = R.id_asta
WHERE   A.id_asta NOT IN (SELECT id_asta FROM VENDITA)
GROUP BY U.login, U.nome;
