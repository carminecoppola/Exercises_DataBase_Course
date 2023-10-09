/*  Visualizzare il CF, il nome e la data di nascita di tutti i pazienti che 
	sono stati operati dal medico con CF 'AAA0000000000014'	*/

SELECT	P.cf, P.nome, P.data_nascita
FROM	PERSONA P JOIN PAZIENTE PZ ON(P.cf = PZ.cf)
				  JOIN INTERVENTO I ON(P.cf = I.cf_paz)
    			  JOIN EFFETTUA E ON(I.id = E.id_int)
    			  JOIN MEDICO M ON(E.cf_med = M.cf)
WHERE	M.cf = 'AAA0000000000014';



select	p.cf as paziente , p.nome, p.data_nascita, e.cf_med as medico
from 	persona p join paziente pz on p.cf = pz.cf
				  join intervento i on p.cf = i.cf_paz
    			  join effettua e on(i.id = e.id_int)
    			  join medico m on (e.cf_med = m.cf)
where 	m.cf = 'AAA0000000000014';