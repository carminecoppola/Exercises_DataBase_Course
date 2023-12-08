/*  Visualizzare i nomi e i cognomi dei medici che non hanno effettuato interventi
    nell'ultima settimana (si considera l'ora di sistema come riferimento). */


SELECT 	 P.nome, P.cognome, M.specializzazione as medico, IT.data_e_ora
FROM	 persona P JOIN medico M ON (P.cf = M.cf)
				  JOIN effettua E ON(M.cf = E.cf_med)
				  JOIN intervento IT ON (E.id_int = IT.id)
where	 IT.data_e_ora < SYSDATE - 7
order by IT.data_e_ora DESC;

