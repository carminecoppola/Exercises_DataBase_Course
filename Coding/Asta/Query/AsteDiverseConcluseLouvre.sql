/*  Visualizzare il nome e cognome degli utenti che nell'anno scorso (fa fede la data di sistema)
    hanno partecipato solo ad aste su opere d'arte di provenienza 'LOUVRE' terminate con una vendita */


select 	distinct u.nome,u.cognome, count(*) as aste_term_con_vendita
from	utente u join rilanciata r on u.login = r.login
				 join asta a on r.id_asta = a.id_asta
    			 join vendita v on a.id_asta = v.id_asta
				 join oggetto o on a.codice_oggetto = o.codice_oggetto
where	o.provenienza = 'LOUVRE' and a.data_fine <= SYSDATE - 365
group by u.nome,u.cognome;