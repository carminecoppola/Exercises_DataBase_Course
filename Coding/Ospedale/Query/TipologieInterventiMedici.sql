/*	Visualizzare per ogni medico il suo nome, la sua specializzazione  e il numero delle
	tipologie di intervento (si contano solo le tipologie distinte) che ha effettuato	*/

SELECT		P.nome, M.specializzazione, COUNT(DISTINCT I.tipo) AS tipologie_intervento
FROM		PERSONA P JOIN MEDICO M ON(P.cf = M.cf)
					  JOIN EFFETTUA E ON(M.cf = E.cf_med)
					  JOIN INTERVENTO I ON(E.id_int = I.id)
GROUP BY	P.nome, M.specializzazione;
