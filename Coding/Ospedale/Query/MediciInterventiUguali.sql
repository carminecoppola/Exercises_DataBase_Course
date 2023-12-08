-- Selezionare il nome e il cognome dei medici che hanno effettuato piu di un intervento dello stesso tipo

select 	p.nome,p.cognome, count(*) as num_int_stesso_tipo
from	persona p join medico m on p.cf = m.cf
    			  join effettua e on m.cf = e.cf_med
				  join intervento i on e.id_int = i.id
where exists ( select  1
    		   from    effettua e1 join intervento i1 on e1.id_int = i1.id
    		   where   e.cf_med = e1.cf_med AND i.tipo = i1.tipo
			   having count(*) > 2
    		 )
group by p.nome,p.cognome;


-- Per Controllare
select  p.nome,p.cognome,i.tipo
from   	persona p join medico m on p.cf = m.cf
    			  join effettua e on m.cf = e.cf_med
    			  join intervento i on e.id_int = i.id
order by p.nome
