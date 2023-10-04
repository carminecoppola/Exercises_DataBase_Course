/*  Visualizzare per ogni infermiere il suo nome, la sua data di assunzione e il numero delle
	tipologie di intervento (si contano solo le tipologie distinte) a cui ha assistito  */

SELECT		P.nome, I.data_ass, COUNT(DISTINCT IT.tipo) AS tipo_interventi      --Avviene qua il conteggio delle tipologie NON SOTTO FROM
FROM		PERSONA P JOIN INFERMIERE I ON(P.cf = I.cf) 
    				  JOIN ASSISTE A ON(I.cf = A.cf_inf)
					  JOIN INTERVENTO IT ON(A.id_int = IT.id)
GROUP BY P.nome, I.data_ass;