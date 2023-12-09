/* Trovare il CF e il NOME dei direttori di dipartimento che in totale lavorano più di 100 ore */

SELECT      I.cf, max(I.nome) AS direttore_dipartimento, SUM(L.ore) AS ore_di_lavoro
FROM		IMPIEGATO I JOIN DIPARTIMENTO D ON(I.cf = D.cf_direttore)
						JOIN LAVORA_SU L ON(I.cf = L.cf_impiegato)
GROUP BY	I.cf
HAVING		SUM(L.ore) > 50         -- Controllo quale direttore ha la somma delle ore > 50
ORDER BY	ore_di_lavoro DESC;     -- Ordino in maniera decrescente

-- N.B. : max(I.nome) viene utilizzata per ottenere il nome del direttore di dipartimento che lavora il numero massimo di ore tra tutti i direttori


