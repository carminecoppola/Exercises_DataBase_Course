/*
    Per ogni impiegato con più di due familiari a carico dello stesso sesso, mostrare il 
    suo nome e la sua data di nascita
*/

SELECT 	DISTINCT i.nome as impiegato,f.nome_familiare as familiare,f.data_nascita ,f.sesso
FROM	IMPIEGATO i JOIN FAMILIARE_A_CARICO f ON i.cf = f.cf_impiegato
WHERE	EXISTS(
    			SELECT 	1
    			FROM	IMPIEGATO i1 JOIN FAMILIARE_A_CARICO f1 ON i1.cf = f1.cf_impiegato
    			WHERE	i.cf = i1.cf AND f.sesso = f1.sesso
    			HAVING COUNT (*) > 1
)
ORDER BY i.nome;

-- Test:
SELECT 	i.nome as impiegato,f.nome_familiare as familiare,f.data_nascita ,f.sesso
FROM	impiegato i JOIN familiare_a_carico f ON i.cf = f.cf_impiegato;
