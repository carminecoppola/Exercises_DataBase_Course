/*  Visualizzare per ogni coppia medico/infermiere il numero di volte in cui hanno 
    partecipato allo stesso intervento (il numero di volte in cui hanno lavorato assieme) */

SELECT 	P.cf AS CF_MEDICO,I.cf AS CF_INFERMIERE, COUNT(*) AS STESSI_INTERVENTI
FROM 	PERSONA P JOIN MEDICO M ON(P.cf = M.cf)
				  JOIN EFFETTUA E ON(M.cf = E.cf_med)
				  JOIN INTERVENTO IT ON(E.id_int = IT.id)
				  JOIN ASSISTE A ON(IT.id = A.id_int)
				  JOIN INFERMIERE I ON(A.cf_inf = I.cf)
GROUP BY P.cf,I.cf;

