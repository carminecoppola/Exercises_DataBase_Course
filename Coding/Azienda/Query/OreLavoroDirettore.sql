/*  Trovare il CF e il nome dei direttori di dipartimento, inoltre calcolare per ciascuno il totale delle ore lavorate */

SELECT		D.cf_direttore, I.nome, SUM(L.ore) AS totale_ore_di_lavoro      -- Seleziono il cf e il nome del direttore inoltre creo una nuova colonna per salvare le ore totali di lavoro
FROM		IMPIEGATO I JOIN LAVORA_SU L ON(I.cf = L.cf_impiegato)
						JOIN PROGETTO P ON(L.numero_progetto = P.numero_progetto)
						JOIN DIPARTIMENTO D ON(P.dipartimento_responsabile = D.numero_dipartimento)
GROUP BY	D.cf_direttore, I.nome                  -- Ordino in base a CF e NOME
ORDER BY	SUM(L.ore) DESC;                        -- Calcolo la somma delle ore di lavoro e le ordino dal più grande al più piccolo