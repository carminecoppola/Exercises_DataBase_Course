/*  Visualizzare i nomi e i cognomi dei medici che non hanno effettuato interventi
    nell'ultima settimana (si considera l'ora di sistema come riferimento). */


SELECT	P.nome, P.cognome
FROM	PERSONA P JOIN MEDICO M ON(P.cf = M.cf)
				  JOIN EFFETTUA E ON(M.cf = E.cf_med)
				  JOIN INTERVENTO I ON(E.id_int = I.id)
WHERE	(SYSDATE - I.data_e_ora) > 7;           -- Seleziona solo i medici che non hanno effettuato interventi nell'ultima settimana

-- N.B: Controllare se va bene la questione della DATA