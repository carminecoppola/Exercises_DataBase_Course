/*  Visualizzare il nome e cognome degli utenti che nel 2010 
    si sono aggiudicati tutte le aste a cui hanno partecipato */

select  distinct u.nome,u.cognome, a.data_inizio
from    utente u join rilanciata r on u.login = r.login
                 join asta a on r.id_asta = a.id_asta
                 join vendita v on a.id_asta = v.id_asta
where   extract(YEAR FROM a.data_inizio) = '2010';

--Algebra Relazionale:

π u.nome,u.cognome  ((Utente (u) ⋈ (u.login = r.login) Rilanciata (r)) 
                                ⋈ (r.id_asta = a.id_asta)Asta(a)
                                ⋈ (a.id_asta = u.id_asta)Vendita(v)
                    )
σ(YEAR(a.data_inizio)) = '2010'


