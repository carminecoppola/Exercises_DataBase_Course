/*Trova tutti gli impiegati che NON hanno familiari a carico:*/

SELECT 	i.nome,i.cognome,i.cf
FROM	impiegato i
WHERE	NOT EXISTS(
    SELECT 	1
    FROM	familiare_a_carico f
    WHERE	i.cf = f.cf_impiegato
);


--Per controllare
select 	DISTINCT i.nome,i.cognome,i.cf,f.nome_familiare,f.relazione_parentela
from 	impiegato i join familiare_a_carico f on i.cf = f.cf_impiegato
where	i.cf = '111111111111145'    -- inserire il CF di chi si vuole controllare
order by i.cf