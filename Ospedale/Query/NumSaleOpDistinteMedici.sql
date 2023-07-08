/*  Visualizzare per ogni medico il suo nome, la sua specializzazione e il numero 
	di sale operatorie diverse in cui ha operato	*/

SELECT		P.nome, M.specializzazione, COUNT(DISTINCT I.sala_op) AS num_sale_operatorie
FROM		PERSONA P JOIN MEDICO M ON(P.cf = M.cf)
					  JOIN EFFETTUA E ON(M.cf = E.cf_med)
					  JOIN INTERVENTO I ON(E.id_int = I.id)
GROUP BY	P.nome, M.specializzazione;


-- Controllata bene ed è giusta