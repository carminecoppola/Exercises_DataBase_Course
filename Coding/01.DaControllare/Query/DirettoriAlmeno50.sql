/* Trovare il CF e il NOME dei direttori di dipartimento che lavorano più di 50 ore */

select 	DISTINCT i.nome,i.cognome,i.cf,l.ore
from	dipartimento d join impiegato i on d.cf_direttore = i.cf_supervisore
					   join lavora_su l on i.cf = l.cf_impiegato
where	l.ore > 250;
