/*  3) Trovare il login e il nome di tutti gli utenti che hanno rilanciato almeno
       tre volte su almeno un oggetto proveniente dal LOUVRE*/ 

select u.login, u.nome,subq.id_asta, subq.provenienza,subq.codice_oggetto
from	utente u join rilanciata r on u.login = r.login
    			 join (select	o.provenienza, a.id_asta,o.codice_oggetto
                       from		oggetto o join asta a on o.codice_oggetto = a.codice_oggetto
                       where	provenienza = 'LOUVRE'
    				  )subq on r.id_asta = subq.id_asta
group by u.login, u.nome,subq.id_asta,subq.provenienza, subq.codice_oggetto
HAVING COUNT(DISTINCT r.PREZZO_RILANCIO) >= 3;