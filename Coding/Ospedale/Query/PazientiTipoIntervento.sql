/*  Visualizzare il CF e la data di nascita di tutti i pazienti che hanno subito 
	sia interventi di tipo ‘LASER’ che interventi di tipo ‘CHIRURGIA GENERALE’	*/

SELECT 	DISTINCT(P.cf), P.data_nascita
FROM	Persona P JOIN PAZIENTE PZ ON(P.cf = PZ.cf)
				  JOIN INTERVENTO I ON(P.cf = I.cf_paz)
WHERE	P.cf IN( SELECT	I.cf_paz
    			 FROM	INTERVENTO I
    			 WHERE 	tipo = 'LASER'
    		   )
AND		P.cf IN( SELECT	I.cf_paz
    			 FROM	INTERVENTO I
    			 WHERE 	tipo = 'CHIRURGIA GENERALE'
    		   );