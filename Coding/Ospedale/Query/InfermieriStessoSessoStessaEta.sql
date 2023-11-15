 /* Visualizzare CF, nome e cognome di tutti gli infermieri che hanno alemno 
    un collega dello stesso sesso e della stessa età */

SELECT P.nome, P.cognome, P.CF
FROM   Persona P JOIN
                    (
                        SELECT P.data_nascita, P.sesso, P.CF
                        FROM    Persona P JOIN INFERMIERE I ON P.cf = I.cf 

                    )subq ON P.data_nascita = subq.data_nascita AND P.sesso = subq.sesso
WHERE   P.cf <> subq.cf


-- Traccia Esame spiegata dal professore