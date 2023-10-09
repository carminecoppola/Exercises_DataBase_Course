/*  Per ogni sala operatoria, visualizzare la data di ricovero dell'ultima persona che si
    è operata in quella sala e il numero complessivo di interventi in essa effettuati   */

select	i.sala_op, subq.num_int_sala, pz.cf, pz.data_ric, i.data_e_ora
from	intervento i join 
		(
    		select	i.sala_op, max(i.data_e_ora) as maxdata, count(*) as num_int_sala
    		from 	intervento i
    		group by i.sala_op
        )subq on (subq.maxdata = i.data_e_ora and subq.sala_op = i.sala_op)
        JOIN PAZIENTE PZ ON I.cf_paz = PZ.cf;


-- Sottoquery per ottenere la sala operatoria, la data di ricovero più recente e il totale degli interventi per ciascuna sala

-- Join con la tabella PAZIENTE per ottenere la data di ricovero

-- MAX(data_e_ora) per ottenere la data e l'ora più recenti dell'intervento.