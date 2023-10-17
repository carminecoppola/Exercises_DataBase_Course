/*  2) Trovare il nome e il CF di tutti gli utenti che hanno 
       effettuato più di due acquisti */

ρ Numero_Acquisti (COUNT(*) ⨝ (Utente(u) ⨝ (u.login = r.login) Rilanciata(r) 
                                         ⨝ (r.id_asta = a.id_asta) Asta(a) 
                                         ⨝ (a.id_asta = v.id_asta) Vendita(v))
                  )
π u.nome, v.CF (Numero_Acquisti)
σ Numero_Acquisti > 2 (Numero_Acquisti)


