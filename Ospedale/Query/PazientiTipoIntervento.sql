/*  Visualizzare il CF e la data di nascita di tutti i pazienti che hanno subito 
	sia interventi di tipo ‘LASER’ che interventi di tipo ‘CHIRURGIA GENERALE’	*/

SELECT	DISTINCT P.nome, P.cf, P.data_nascita
FROM	PERSONA P JOIN PAZIENTE PZ ON(P.cf = PZ.cf)
				  JOIN INTERVENTO I ON(P.cf = I.cf_paz)
WHERE	I.tipo = 'LASER' OR I.tipo = 'CHIRURGIA GENERALE';