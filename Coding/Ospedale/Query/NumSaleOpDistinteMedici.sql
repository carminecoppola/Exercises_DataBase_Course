/*  Visualizzare per ogni medico il suo nome, la sua specializzazione e il numero 
	di sale operatorie diverse in cui ha operato	*/

select 	p.nome, m.specializzazione, count(distinct i.sala_op) as num_sal_op_div
from 	persona p join medico m on p.cf = m.cf
				  join effettua e on m.cf = e.cf_med
				  join intervento i on e.id_int = i.id
group by p.nome, m.specializzazione
order by num_sal_op_div ASC;

-- Controllata bene ed è giusta