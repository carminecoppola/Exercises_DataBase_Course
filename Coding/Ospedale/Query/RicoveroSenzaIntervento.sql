/*	Visualizzare le date di ricovero di tutti i pazienti che non hanno subito alcun intervento	*/

SELECT	 PZ.cf, P.nome, P.cognome, PZ.data_ric
FROM	PAZIENTE PZ JOIN PERSONA P ON(PZ.cf = P.cf)
					LEFT JOIN INTERVENTO I ON(P.cf = I.cf_paz)
WHERE	I.cf_paz IS NULL;


-- INSERT: 
--insert into PERSONA(CF,NOME,COGNOME,DATA_NASCITA,SESSO) values('AAA0000000010101','ROCCO','SCARPATO',to_date('18/10/1990','dd/mm/yyyy'),'M');
--insert into PAZIENTE(DATA_RIC,DATA_DIM,CF) values(to_date('01/01/2023','dd/mm/yyyy'),to_date('05/01/2023','dd/mm/yyyy'),'AAA0000000010101');

