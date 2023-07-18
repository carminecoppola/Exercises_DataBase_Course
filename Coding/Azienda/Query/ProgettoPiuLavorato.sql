/* Trovare il nome del progetto e ore del progetto con il max numero di ore lavorate */

SELECT		P.nome_progetto, SUM(L.ore) AS ore_lavorate      -- Somma delle ore lavorate (SUM(L.ore)) per ogni progetto
FROM		IMPIEGATO I JOIN LAVORA_SU L ON(I.cf = L.cf_impiegato)
						JOIN PROGETTO P ON(L.numero_progetto = P.numero_progetto)
GROUP BY 	P.nome_progetto             -- Raggruppiamo per nome del progetto 
ORDER BY 	SUM(L.ore) DESC             -- Ordiniamo i risultati in ordine decrescente della somma delle ore lavorate utilizzando In questo modo, il progetto con il massimo numero di ore lavorate sarà in cima alla lista.
FETCH FIRST 1 ROWS ONLY;                -- Viene utilizzata per selezionare solo la prima riga (il progetto con il massimo numero di ore lavorate).

--N.B: NON c'è bisogno di utilizzare la clausola HAVING perché non stiamo applicando alcuna condizione sulla somma delle ore lavorate.