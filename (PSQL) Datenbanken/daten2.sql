-- Zeigen der Eingabezeile (nicht gebraucht, disabled)
-- \set ECHO all 
-- Sicherstellen, dass die Tabellen noch nicht existieren
DROP TABLE veranstaltung;
DROP TABLE dozent;


-- Erstellen der Tabelle dozent
CREATE TABLE dozent (
	vorname VARCHAR(80), 
	name VARCHAR(80),
	kuerzel CHAR(3),
	fakult VARCHAR(80),
    gebaeude CHAR(1),
	zimmernummer INT,
	PRIMARY KEY (kuerzel)
);
-- Eintragen der Werte
INSERT INTO dozent VALUES ('K', 'Ackermann', 'ack', 'Informationstechnik', 'S', 216); 
INSERT INTO dozent VALUES ('Peter', 'Barth', 'bth', 'Informationstechnik', 'S', 119);
INSERT INTO dozent VALUES ('T.', 'Beuermann', 'beu', 'Informationstechnik', 'S', 018);
INSERT INTO dozent VALUES ('Jens', 'Bohli', 'bjm', 'Informationstechnik', 'S', 110);
INSERT INTO dozent VALUES ('M.', 'Bohn', 'bnm', 'Informationstechnik', 'S', 019);
INSERT INTO dozent VALUES ('Martin', 'Damm', 'dam', 'Informationstechnik', 'S', 111);
INSERT INTO dozent VALUES ('T.', 'Einsiedel', 'ein', 'Informationstechnik', 'S', 315);
INSERT INTO dozent VALUES ('S.', 'Feldes', 'fes', 'Informationstechnik', 'S', 320);
INSERT INTO dozent VALUES ('J.', 'Giehl', 'gie', 'Informationstechnik', 'S', 217);
INSERT INTO dozent VALUES ('S.', 'Heger', 'hes', 'Informationstechnik', 'S', 311);
INSERT INTO dozent VALUES ('L.', 'Kapulepa', 'kbl', 'Informationstechnik', 'S', 010);
INSERT INTO dozent VALUES ('K.', 'Beck', 'bec', 'E-Technik', 'H', 107);
INSERT INTO dozent VALUES ('Oe.', 'Koca', 'koz', 'Informationstechnik', 'S', 206);
INSERT INTO dozent VALUES ('Eckhart', 'Koerner', 'koe', 'Informationstechnik', 'S', 110);
INSERT INTO dozent VALUES ('U.', 'Martin', 'mar', 'Informationstechnik', 'S', 321);
INSERT INTO dozent VALUES ('P.', 'Nguyen', 'ngu', 'Informationstechnik', 'S', 310);
INSERT INTO dozent VALUES ('W.', 'Poppendieck', 'pop', 'Informationstechnik', 'S', 216);
INSERT INTO dozent VALUES ('E.', 'Eich', 'eic', 'Informationstechnik', 'S', 119);
INSERT INTO dozent VALUES ('K.H.', 'Steglich', 'skh', 'Informationstechnik', 'S', 320);
INSERT INTO dozent VALUES ('H.', 'Suhr', 'sur', 'Informationstechnik', 'S', 006);
INSERT INTO dozent VALUES ('B.', 'Vettermann', 'veb', 'Informationstechnik', 'S', 217);
INSERT INTO dozent VALUES ('M.', 'Hastenteufel', 'htm', 'Informationstechnik', 'S', 111);
INSERT INTO dozent VALUES ('B.', 'Voigt', 'voi', 'Informationstechnik', 'S', 106);
INSERT INTO dozent VALUES ('R.', 'Willenberg', 'wib', 'Informationstechnik', 'S', 010);
INSERT INTO dozent VALUES ('B.', 'Wirnitzer', 'wir', 'Informationstechnik', 'S', 321);
INSERT INTO dozent VALUES ('D.', 'Trebbels', 'tre', 'E-Technik', 'U', 009);
INSERT INTO dozent VALUES ('I.', 'Wolf', 'woi', 'Informatik', 'A', 007);
INSERT INTO dozent VALUES ('M.', 'Gumbel', 'gum', 'Informatik', 'A', 007);


-- Erstellen der Tabelle veranstaltung
CREATE TABLE veranstaltung (
	nummer INT, 
	titel VARCHAR(80),
    gebaeude CHAR(1),
	raum INT,
	dozent CHAR(3),
	semester INT,
	PRIMARY KEY (nummer),
    FOREIGN KEY (dozent) REFERENCES dozent (kuerzel)
);

-- Eintragen der Werte
INSERT INTO veranstaltung VALUES (1001, 'Mathematik 1', 'G', 013, 'pop', 1);
INSERT INTO veranstaltung VALUES (1011, 'Physik 1', 'A', 305, 'woi', 1);
INSERT INTO veranstaltung VALUES (1021, 'Praktische Informatik', 'H', 307, 'hes', 1);
INSERT INTO veranstaltung VALUES (1031, 'Digitaltechnik 1', 'G', 013, 'wib', 1);
INSERT INTO veranstaltung VALUES (1041, 'Elektrotechnik 1', 'A', 305, 'skh', 1);
INSERT INTO veranstaltung VALUES (2021, 'Objektorientierte Programmierung', 'L', 209, 'bjm', 2);
INSERT INTO veranstaltung VALUES (2022, 'Rechnerarchitektur', 'H', 607, 'veb', 1);
INSERT INTO veranstaltung VALUES (2031, 'Elektronische Schaltungen', 'H', 806, 'koz', 2);
INSERT INTO veranstaltung VALUES (2041, 'Wechselstromtechnik', 'H', 806, 'skh', 2);
INSERT INTO veranstaltung VALUES (1002, 'Mathematik 2', 'H', 806, 'sur', 2);
INSERT INTO veranstaltung VALUES (3011, 'Computer Netzwerke 1', 'S', 213, 'koe', 3);
INSERT INTO veranstaltung VALUES (3021, 'Digital und Microcomputertechnik', 'S', 220, 'ack', 3);
INSERT INTO veranstaltung VALUES (3031, 'Signale und Systeme', 'L', 113, 'mar', 3);
INSERT INTO veranstaltung VALUES (3041, 'Software Engineering', 'L', 209, 'htm', 3);
INSERT INTO veranstaltung VALUES (1003, 'Mathematik 3', 'S', 212, 'sur', 3);
INSERT INTO veranstaltung VALUES (4011, 'Computer Netzwerke 2', 'S', 221, 'koe', 4);
INSERT INTO veranstaltung VALUES (4021, 'Digitale Regelungstechnik', 'S', 212, 'skh', 4);
INSERT INTO veranstaltung VALUES (4031, 'Digitale Signalverarbeitung', 'S', 322, 'wir', 4);
INSERT INTO veranstaltung VALUES (4041, 'Embedded Systems', 'S', 212, 'kbl', 4);
INSERT INTO veranstaltung VALUES (4051, 'Betriebssysteme', 'L', 207, 'bjm', 4);
INSERT INTO veranstaltung VALUES (7011, 'Datenbanksysteme', 'S', 221, 'htm', 7);
INSERT INTO veranstaltung VALUES (7021, 'Webarchitekturen im Internet', 'S', 211, 'dam', 7);

-- Wir zeigen die komplette Tabelle an
--SELECT * FROM veranstaltung;
-- Wir zeigen die komplette Tabelle an
--SELECT * FROM dozent;  


-- zum aufräumen
-- DROP TABLE veranstaltung;
-- DROP TABLE dozent;

--a) Wer hält eine Veranstaltung in einem Raum mit einer Raumnummer, die größer ist als die
--Zimmernummer seines Büros?
SELECT d.name FROM Veranstaltung v, dozent d WHERE v.dozent = d.kuerzel AND raum > zimmernummer;


--b) Was sind die Namen von Dozenten, die Veranstaltungen halten, die sich in der
--Veranstaltungsnummer nur um 1 voneinander unterscheiden?


--c) Gehen Sie davon aus, dass alle Dozenten einer Fakultät alle Veranstaltungen halten können, die
--andere Dozenten derselben Fakultät schon gehalten haben. Was sind alle Möglichkeiten
--(Dozentenname, Veranstaltungsname, Fakultät) eines Veranstaltungsplans?
