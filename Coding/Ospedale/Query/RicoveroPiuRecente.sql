/*  Per ogni sala operatoria, visualizzare la data di ricovero dell'ultima persona che si
    è operata in quella sala e il numero complessivo di interventi in essa effettuati   */

SELECT V.sala_op, P.data_ric, V.totale_operazioni
FROM INTERVENTO I JOIN ( SELECT sala_op, MAX(data_e_ora) AS LAST_OP_DATE, COUNT(*) AS totale_operazioni
                         FROM INTERVENTO
                         GROUP BY sala_op
                    	)V ON (I.data_e_ora = V.LAST_OP_DATE AND I.sala_op = V.sala_op)
						JOIN PAZIENTE P ON I.cf_paz = P.cf;


-- Sottoquery per ottenere la sala operatoria, la data di ricovero più recente e il totale degli interventi per ciascuna sala

-- Join con la tabella PAZIENTE per ottenere la data di ricovero

-- MAX(data_e_ora) per ottenere la data e l'ora più recenti dell'intervento.