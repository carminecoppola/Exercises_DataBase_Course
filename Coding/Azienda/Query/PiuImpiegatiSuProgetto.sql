/* Trovare il NOME dei progetti su cui lavorano più di tre impiegati*/

SELECT 	p.nome_progetto,COUNT(DISTINCT l.cf_impiegato) AS num_imp_progetto
FROM	progetto p JOIN lavora_su l ON p.numero_progetto = l.numero_progetto
GROUP BY p.nome_progetto
HAVING COUNT(DISTINCT l.cf_impiegato) > 3
ORDER BY p.nome_progetto;

-- Per controllare

SELECT 	i.nome,p.nome_progetto
FROM	impiegato i JOIN lavora_su l ON i.cf = l.cf_impiegato
					JOIN progetto p ON l.numero_progetto = p.numero_progetto
where	p.nome_progetto = 'PJ1' -- Varia in base a quale progetto vogliamo controllare
ORDER BY p.nome_progetto;