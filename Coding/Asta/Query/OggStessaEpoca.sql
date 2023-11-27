-- Trova gli oggetti di antiquariato provenienti dalla stessa epoca:

SELECT  a1.codice_oggetto AS cod_a1, a2.codice_oggetto AS cod_a2, a1.periodo_rif AS per_a1, a2.periodo_rif AS per_a2
FROM    ANTIQUARIATO a1 JOIN ANTIQUARIATO a2 ON ((a1.periodo_rif = a2.periodo_rif) and (a1.codice_oggetto <> a2.codice_oggetto))



/*SELF JOIN:
    A self join is a regular join, but the table is joined with itself.

    Self Join Syntax:

    SELECT  column_name(s)
    FROM    table1 T1, table1 T2
    WHERE   condition;
    
    T1 and T2 are different table aliases for the same table.
*/