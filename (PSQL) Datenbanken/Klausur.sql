-- Tabellen löschen, falls sie existieren
DROP TABLE IF EXISTS ProjektMitarbeiter CASCADE;
DROP TABLE IF EXISTS Mitarbeiter CASCADE;
DROP TABLE IF EXISTS Projekt CASCADE;
DROP TABLE IF EXISTS Abteilung CASCADE;

-- Tabellen erstellen
CREATE TABLE Abteilung (
	AbtNr INT PRIMARY KEY,
	Abteilungsname VARCHAR(80)
);

CREATE TABLE Projekt (
	ProjektID INT PRIMARY KEY,
	Name VARCHAR(80)
);

CREATE TABLE Mitarbeiter (
	MaNr INT PRIMARY KEY,
	Name VARCHAR(80),
	Gehalt INT,
	Abteilung INT REFERENCES Abteilung(AbtNr)
);

CREATE TABLE ProjektMitarbeiter (
	ProjektID INT REFERENCES Projekt(ProjektID),
	MaNr INT REFERENCES Mitarbeiter(MaNr),
	PRIMARY KEY (ProjektID, MaNr)
);

-- Daten einfügen
-- Abteilung
INSERT INTO Abteilung VALUES (1, 'Rechnungswesen');
INSERT INTO Abteilung VALUES (2, 'Entwicklung');
INSERT INTO Abteilung VALUES (3, 'Vertrieb');

-- Projekt
INSERT INTO Projekt VALUES (1, 'Moonshot');
INSERT INTO Projekt VALUES (2, 'Projekt Beta');
INSERT INTO Projekt VALUES (3, 'Projekt Gamma');

-- Mitarbeiter
INSERT INTO Mitarbeiter VALUES (1, 'Max Mustermann', 50000, 1);
INSERT INTO Mitarbeiter VALUES (2, 'Erika Musterfrau', 55000, 2);
INSERT INTO Mitarbeiter VALUES (3, 'Hans Huber', 60000, 2);
INSERT INTO Mitarbeiter VALUES (4, 'Julia Sommer', 45000, 3);
INSERT INTO Mitarbeiter VALUES (0815, 'Tom Winter', 47000, 3);

-- ProjektMitarbeiter
INSERT INTO ProjektMitarbeiter VALUES (1, 1);
INSERT INTO ProjektMitarbeiter VALUES (1, 2);
INSERT INTO ProjektMitarbeiter VALUES (2, 2);
INSERT INTO ProjektMitarbeiter VALUES (1, 3);
INSERT INTO ProjektMitarbeiter VALUES (3, 4);
INSERT INTO ProjektMitarbeiter VALUES (3, 0815);


SELECT P.Name FROM Projekt P, ProjektMitarbeiter PM, Mitarbeiter M WHERE M.MaNr = PM.MaNr AND PM.ProjektID = P.ProjektID AND M.MaNr = 0815;

-- Eine Liste mit allen Projektnamen, in denen die Abteilung "Entwicklung" involviert ist.
SELECT P.Name FROM Projekt P, ProjektMitarbeiter PM, Mitarbeiter M, Abteilung A WHERE P.ProjektID = PM.ProjektID AND PM.MaNr = M.MaNr AND M.Abteilung = A.AbtNr AND A.Abteilungsname = 'Entwicklung';

-- Alle Namen der Abteilungen mit mehr als 10 Mitarbeiter
SELECT ProjektID FROM ProjektMitarbeiter GROUP BY ProjektMitarbeiter.ProjektID HAVING count(MaNr) > 10;

-- Alle Abteilungsnamen und das Durchschnittsgehalt der Mitarbeiter dieser Abteilung
SELECT M.Abteilung, avg(M.Gehalt) FROM Mitarbeiter M GROUP BY M.Abteilung;

-- Den Namen des Projekts mit den meisten Mitarbeitern
SELECT P.Name, count(PM.MaNr) FROM Projekt P JOIN ProjektMitarbeiter PM ON P.ProjektID = PM.ProjektID GROUP BY P.Name ORDER BY count(PM.MaNr) DESC LIMIT 1;

-- Vorheriger Wert
SELECT M.*, P.Name FROM Mitarbeiter M, Projekt P, ProjektMitarbeiter PM WHERE M.MaNr = PM.MaNr AND PM.ProjektID = P.ProjektID GROUP BY P.Name, M.MaNr;

-- Geben Sie allen Mitarbeitern, die im Projekt "Moonshot" arbeiten eine Gehaltserhöhungvon 10%
UPDATE Mitarbeiter M SET Gehalt = M.Gehalt + M.Gehalt/10 FROM Projekt P, ProjektMitarbeiter PM, Mitarbeiter, Abteilung A WHERE P.ProjektID = PM.ProjektID AND PM.MaNr = M.MaNr AND M.Abteilung = A.AbtNr AND P.Name = 'Moonshot';

-- Ausgabe für das Update
SELECT M.*, P.Name FROM Mitarbeiter M, Projekt P, ProjektMitarbeiter PM WHERE M.MaNr = PM.MaNr AND PM.ProjektID = P.ProjektID ORDER BY P.Name;
