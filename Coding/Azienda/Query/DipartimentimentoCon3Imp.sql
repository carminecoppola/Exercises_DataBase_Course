/*Trova tutti i dipartimenti che hanno almeno tre impiegati (compreso il direttore)*/

SELECT d.nome_dipartimento, COUNT(*) AS num_impiegati
FROM dipartimento d JOIN impiegato i ON d.numero_dipartimento = i.numero_dipartimento
WHERE EXISTS (
    SELECT 1
    FROM impiegato i2
    WHERE i.numero_dipartimento = i2.numero_dipartimento 
    	AND i.CF <> i2.CF
)
GROUP BY d.numero_dipartimento, d.nome_dipartimento
HAVING COUNT(*) >= 3
ORDER BY d.numero_dipartimento;



-- Per controllare
select 	 d.nome_dipartimento, i.nome
from	 dipartimento d join impiegato i on d.numero_dipartimento = i.numero_dipartimento
where 	 i.cf <> d.cf_direttore
order by d.nome_dipartimento