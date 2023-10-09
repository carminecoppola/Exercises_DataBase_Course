/* Trovare il nome dei progetti in cui il totale delle ore lavorate da tutti gli impiegati è superiore a 800 */

SELECT      max(P.nome_progetto), SUM(L.ore) as Ore_Totali          -- Il valore calcolato dalla somma viene etichettato nella colonna Ore_Totali
FROM        IMPIEGATO I JOIN LAVORA_SU L ON I.cf = L.cf_impiegato   
                        JOIN PROGETTO P ON L.numero_progetto = P.numero_progetto
GROUP BY    L.numero_progetto                                       -- Raggruppo tutto in base al numero del progetto
HAVING		SUM(L.ore) > 800;                                       -- Filtra per includere solo i progetti la cui somma delle ore ('Ore_Totali') è maggiore di 800  
