/*  4) Trovare il login e il nome di tutti gli utenti che hanno rilanciato
       più di due volte, in ASTE DIVERSE, su un oggetto proveniente dal LOUVRE*/

-- 1) Versione Innestata:
--	Mi sono calcolato la provenienza nella query innestata, 
--  ma non so se va bene calolare i rilanci in quel modo

select 	DISTINCT u.login, u.nome, count(DISTINCT r.prezzo_rilancio) as cont_rilanci
from	utente u join rilanciata r on u.login = r.login
				 join asta a on r.id_asta = a.id_asta
    			 join  ( select 	o.provenienza, a.id_asta
                         from		asta a join oggetto o on a.codice_oggetto = o.codice_oggetto
                         where		o.provenienza = 'LOUVRE'
    				   ) subq on subq.id_asta <> a.id_asta
group by u.login, u.nome
having count(DISTINCT r.prezzo_rilancio) > 2;


-- 2) Versione
SELECT U.LOGIN, U.NOME
FROM UTENTE U JOIN RILANCIATA R ON U.LOGIN = R.LOGIN 
    		  JOIN ASTA A ON R.ID_ASTA = A.ID_ASTA 
    		  JOIN OGGETTO O ON A.CODICE_OGGETTO = O.CODICE_OGGETTO
WHERE O.PROVENIENZA = 'LOUVRE'
GROUP BY U.LOGIN, U.NOME
HAVING COUNT(DISTINCT A.ID_ASTA) >= 2;



--3) Innestata
SELECT  U.login, U.nome
FROM	UTENTE U
JOIN(
	SELECT R.login, COUNT(DISTINCT(A.id_asta)) as num_aste_diverse
    	FROM RILANCIATA R JOIN ASTA A ON(R.id_asta = A.id_asta)
    					  JOIN OGGETTO O ON(A.codice_oggetto = O.codice_oggetto)
    	WHERE O.provenienza = 'LOUVRE'
    	GROUP BY R.login
    	HAVING COUNT(DISTINCT A.id_asta) > 2
)RILANCI_UTENTE ON U.login = RILANCI_UTENTE.login;




