-- Alles Anzeigen auch Eingabe
\set ECHO all

-- Laufendes Beispiel
CREATE TABLE fakultaet(
       nummer INT,
       name   VARCHAR(80),
       PRIMARY KEY (nummer) -- implicit NOT NULL und UNIQUE
);
CREATE TABLE studierende(
       vorname VARCHAR(80),
       name VARCHAR(80),
       matnr INT PRIMARY KEY, -- kann in dieselbe Zeile geschrieben werden
       fakult INT,
       FOREIGN KEY (fakult) REFERENCES fakultaet (nummer)
);

-- Einfügen von Einzel-Tupeln
INSERT INTO fakultaet VALUES (6, 'Informatik');
INSERT INTO fakultaet VALUES (13); -- default Werte
INSERT INTO fakultaet VALUES (6, 'Ingenieursinformatik'); -- geht nicht
SELECT * FROM fakultaet;

INSERT INTO studierende VALUES ('Rudi', 'Ratlos', 0815, 6);
-- Umsortierung, Weglassen
INSERT INTO studierende (matnr, name) VALUES (4711, 'Sinnlos'); 
SELECT * FROM studierende;

-- Einfügen von Tupel-Mengen
-- Vorbereitung
CREATE TABLE vornamen (nr SERIAL, text VARCHAR(80));
INSERT INTO vornamen (text) VALUES ('Susanne'); 
INSERT INTO vornamen (text) VALUES ('Rudolph');
INSERT INTO vornamen (text) VALUES ('Claudia');
INSERT INTO vornamen (text) VALUES ('Klaus');
SELECT * FROM vornamen;
-- Das eigentliche Einfügen der Tupel-Menge
INSERT INTO studierende (matnr, vorname, fakult) (SELECT nr+1000, text, 6 FROM vornamen);
SELECT * FROM studierende;

-- Update von Tupeln
UPDATE studierende SET name = 'Sinnlos';
SELECT * FROM studierende;
UPDATE studierende SET name = 'Ratlos' WHERE vorname = 'Rudi';
SELECT * FROM studierende;
UPDATE studierende SET name = 'Meier', fakult = 13 WHERE matnr BETWEEN 1003 AND 1004;
SELECT * FROM studierende;

-- Löschen von Tupeln
DELETE FROM studierende WHERE vorname='Klaus';
SELECT * FROM studierende;
DELETE FROM fakultaet WHERE nummer = 6; -- klappt nicht, Integrität verletzt
SELECT * FROM fakultaet;

-- Ändern der Fakultaetsnummer
UPDATE fakultaet SET nummer=66 WHERE nummer=6; -- klappt nicht, Integrität verletzt
INSERT INTO fakultaet VALUES (66, 'Informatik'); -- Alternativ drei Einzelanweisungen
UPDATE studierende SET fakult=66 WHERE fakult = 6;
DELETE FROM fakultaet WHERE nummer = 6;
SELECT * FROM fakultaet;
SELECT * FROM studierende;
-- Ändern der Tabelle, so dass sie definiert ist wie oben 
-- aber mit "ON UPDATE CASCADE" bei Fremdschlüssel
ALTER TABLE studierende DROP CONSTRAINT studierende_fakult_fkey;
ALTER TABLE studierende ADD CONSTRAINT studierende_fakult_fkey FOREIGN KEY (fakult) REFERENCES fakultaet(nummer) ON UPDATE CASCADE;
UPDATE fakultaet SET nummer=6 WHERE nummer=66; -- jetzt klappt die direkte Änderung
SELECT * FROM fakultaet;
SELECT * FROM studierende;

DROP TABLE studierende;
DROP TABLE fakultaet;
DROP TABLE vornamen;