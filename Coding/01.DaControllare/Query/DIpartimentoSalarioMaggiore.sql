/* Trova il nome del dipartimento con il salario medio più alto tra tutti i dipendenti in quel dipartimento:*/

SELECT d.nome_dipartimento, d.numero_dipartimento, AVG(i.stipendio) AS salario_medio
FROM dipartimento d JOIN impiegato i ON d.cf_direttore = i.cf_supervisore
GROUP BY d.nome_dipartimento, d.numero_dipartimento
ORDER BY salario_medio DESC
FETCH FIRST 1 ROW ONLY; 

-- Utilizzo FETCH FIRST poichè voglio solo la prima riga poichè 
-- dopo aver ordinato in maniera decrescente avrò il dipartimento 
-- con la  media maggiore in cima



