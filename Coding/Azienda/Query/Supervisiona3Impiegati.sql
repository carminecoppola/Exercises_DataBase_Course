/*  Nome e cognome di tutti i supervisori che supervisionano almeno 3 impiegati */

SELECT	I.nome, I.cognome
FROM	IMPIEGATO I
WHERE	I.cf IN(  SELECT	I.cf_supervisore
    			  FROM		IMPIEGATO I
    			  GROUP BY	I.cf_supervisore
    			  HAVING 	COUNT(*) > 2
    		   );