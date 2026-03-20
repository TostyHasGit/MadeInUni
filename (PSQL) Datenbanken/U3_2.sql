CREATE TABLE Vorlesung(
    nummer INT PRIMARY KEY,
    titel VARCHAR,
    raum VARCHAR,
    dozent VARCHAR REFRENCES Dozent(kuerzel)
);

CREATE TABLE Dozent(
    vorname VARCHAR,
    name VARCHAR,
    kuerzel VARCHAR(5) PRIMARY KEY,
    fakultaet VARCHAR,
    zimmernummer VARCHAR
);

INSERT INTO Dozent VALUES('Mark', 'Hastenteufel', 'HTM', 'N', 'S111');
INSERT INTO Dozent VALUES('Martin', 'Damm', 'DAM', 'N', 'S111');
INSERT INTO Dozent VALUES('Peter', 'Barth', 'BTH', 'N', 'S119');
INSERT INTO Dozent VALUES('Jens-Matthias', 'Bohli', 'BJM', 'N', 'S110');
INSERT INTO Dozent VALUES('Eric', 'Heim', 'NULL', 'N', 'NULL');

INSERT INTO Vorlesung VALUES('6111', 'Datenbanken', 'S113', 'HTM');
INSERT INTO Vorlesung VALUES('6091', 'Objektorientierte Programmierung', 'S117', 'BTH');
INSERT INTO Vorlesung VALUES('6081', 'Automatentheorie', 'S113', 'xxx');
INSERT INTO Vorlesung VALUES('6101', 'Webarchitekturen', 'S117', 'DAM');

SELECT * FROM Dozent;
SELECT * FROM Vorlesung;

DROP TABLE Dozent;
DROP TABLE Vorlesung;
DROP TABLE studierende;