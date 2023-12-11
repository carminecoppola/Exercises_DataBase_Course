/* Trova tutti i dipartimenti che hanno almeno un impiegato assegnato: */

SELECT 	*
FROM 	DIPARTIMENTO d
WHERE	EXISTS (
    SELECT 	1
    FROM 	IMPIEGATO i
    WHERE 	i.NUMERO_DIPARTIMENTO = d.NUMERO_DIPARTIMENTO
);

