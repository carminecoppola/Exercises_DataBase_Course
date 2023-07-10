/*	Visualizzare le date di ricovero di tutti i pazienti che non hanno subito alcun intervento	*/

SELECT		P.nome, PZ.data_ric
FROM		PERSONA P JOIN PAZIENTE PZ ON(P.cf = PZ.cf)
					  JOIN INTERVENTO I ON(P.cf = I.cf_paz)
WHERE		P.cf NOT IN(I.cf_paz);


-- N.B: no data found