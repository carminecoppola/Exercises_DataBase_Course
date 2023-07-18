/*  Trovare il nome dei supervisori di primo livello dei direttori */

SELECT		I.nome
FROM		IMPIEGATO I
WHERE		I.cf IN(  SELECT  I.cf_supervisore
    				  FROM	  IMPIEGATO I JOIN DIPARTIMENTO D ON (I.cf = D.cf_direttore)
                   );
