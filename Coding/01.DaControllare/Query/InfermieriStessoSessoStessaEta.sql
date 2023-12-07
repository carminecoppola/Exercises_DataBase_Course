 /* Visualizzare CF, nome e cognome di tutti gli infermieri che hanno alemno 
    un collega dello stesso sesso e della stessa età */

SELECT 	P.cf,P.nome, P.cognome, P.sesso, P.data_nascita
from	PERSONA P join INFERMIERE I on P.cf = I.cf 
    			  join (
    					  SELECT  P2.cf,P2.sesso,P2.data_nascita
    					  from	  PERSONA P2 join INFERMIERE I2 on P2.cf = I2.cf
    					)subq on EXTRACT(YEAR FROM P.data_nascita) = EXTRACT(YEAR FROM subq.data_nascita) and P.sesso = subq.sesso
WHERE	P.cf <> subq.cf ;


-- Traccia Esame spiegata dal professore