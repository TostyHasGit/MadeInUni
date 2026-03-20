-- Zeigen der Eingabezeile
\set ECHO all 

-- Erstellen der Tabelle Studierende 
CREATE TABLE studierende (
	vorname VARCHAR(80), 
	name VARCHAR(80), 
	matnr INT);

-- Eintragen der beiden Beispielwerte
INSERT INTO studierende VALUES ('Susi', 'Sinnlos', 4711);
INSERT INTO studierende VALUES ('Rudi', 'Ratlos', 0815);
INSERT INTO studierende VALUES ('Martin', 'Damm', 0);

-- Wir zeigen die komplette Tabelle an
SELECT * FROM studierende; 

-- Die Tabelle hat die gewünschten Eigenschaften (Relationenschema)
\d studierende 

-- wir räumen wieder auf und löschen die Relation
DROP TABLE studierende; 


