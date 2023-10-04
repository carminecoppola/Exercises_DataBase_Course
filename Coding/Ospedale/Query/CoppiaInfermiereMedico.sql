/*  Visualizzare per ogni coppia medico/infermiere il numero di volte in cui hanno 
    partecipato allo stesso intervento (il numero di volte in cui hanno lavorato assieme) */

SELECT 	P.cf AS CF_MEDICO,I.cf AS CF_INFERMIERE, COUNT(*) AS STESSI_INTERVENTI
FROM 	PERSONA P JOIN MEDICO M ON(P.cf = M.cf)
				  JOIN EFFETTUA E ON(M.cf = E.cf_med)
				  JOIN INTERVENTO IT ON(E.id_int = IT.id)
				  JOIN ASSISTE A ON(IT.id = A.id_int)
				  JOIN INFERMIERE I ON(A.cf_inf = I.cf)
GROUP BY P.cf,I.cf;

--GIUSTA

--Alternativa che non restituisce gli stessi dati ma credo sia buona concettualmente
select distinct m.cf as medico, m.specializzazione as specializzazione, e.id_int, i.cf as infermiere,i.qualifica as qualifica, a.id_int, count(*) as num_int_ins
from persona p  join medico m on (p.cf = m.cf)
				join effettua e on (m.cf = e.cf_med)
    			join intervento it on (e.id_int = it.id)
				join assiste a on (it.id = a.id_int)
    			join infermiere i on(a.cf_inf = i.cf)
where e.id_int = a.id_int
group by m.cf, m.specializzazione, e.id_int,i.cf, i.qualifica, a.id_int
having count(*) > 0

