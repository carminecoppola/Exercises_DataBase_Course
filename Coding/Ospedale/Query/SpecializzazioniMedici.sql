/*	Visualizzare le specializzazioni di tutti i medici che hanno effettuato interventi di tipo
	‘CHIRURGIA GENERALE’ oppure di tipo ‘CHIRURGIA PLASTICA’	*/

SELECT	DISTINCT P.nome, M.specializzazione
FROM	PERSONA P JOIN MEDICO M ON(P.cf = M.cf)
				  JOIN EFFETTUA E ON(M.cf = E.cf_med)
				  JOIN INTERVENTO I ON(E.id_int = I.id)
WHERE	I.tipo = 'CHIRURGIA GENERALE' OR I.tipo = 'CHIRURGIA PLASTICA';

