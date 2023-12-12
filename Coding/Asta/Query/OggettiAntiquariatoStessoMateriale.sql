/*  Trova tutti gli oggetti di antiquariato che hanno lo stesso materiale 
	di un altro oggetto di antiquariato, escludendo gli oggetti stessi.  */

SELECT  DISTINCT a1.codice_oggetto AS Ogg1,a1.materiale , a2.codice_oggetto AS ogg2,a2.materiale
FROM	antiquariato a1 JOIN antiquariato a2 ON a1.codice_oggetto <> a2.codice_oggetto
WHERE	a1.materiale = a2.materiale
ORDER BY a1.codice_oggetto;