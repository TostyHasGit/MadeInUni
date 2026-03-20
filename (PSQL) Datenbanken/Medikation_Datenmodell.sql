-- Tabelle für Patienten
CREATE table Patient (
	PID int PRIMARY KEY,
	name VARCHAR(80),
	vorname VARCHAR(80),
	gebdatum DATE,
	stadt VARCHAR(80),
	anschrift VARCHAR(80)
);

-- Tabelle für Apotheken
CREATE table Apotheke (
	ApoID int PRIMARY KEY,
	name VARCHAR(80),
	stadt VARCHAR(80),
	anschrift VARCHAR(80)
);

-- Tabelle für Ärzte
CREATE table Arzt (
	ArztID int PRIMARY KEY,
	name VARCHAR(80),
	stadt VARCHAR(80),
	anschrift VARCHAR(80)
);

-- Tabelle für Rezepte
CREATE table Rezept (
	RID int PRIMARY KEY,
	datum DATE,
	PID int REFERENCES Patient(PID),
	ArztID int REFERENCES Arzt(ArztID),
	ApoID int REFERENCES Apotheke(ApoID)
);

-- Tabelle für Medikamente
CREATE TABLE Medikament (
	PZN INT PRIMARY KEY,
	name VARCHAR(80)
);

-- Tabelle für alle Wirkstoffe
CREATE TABLE Wirkstoff (
	WID INT PRIMARY KEY,
	name VARCHAR(80)
);

-- Welche Wirkstoffe sind in welchen Medikamenten enthalten?
CREATE TABLE MedikamentWirkstoff (
	PZN INT REFERENCES Medikament(PZN),
	WID INT REFERENCES Wirkstoff(WID)
	
);

-- Tabelle mit allen Wechselwirkungen
CREATE TABLE WechselWirkung (
	wirkstoff1 INT References Wirkstoff(WID),
	wirkstoff2 INT References Wirkstoff(WID),
	beschreibung VARCHAR(200)
);

-- Tabelle mit allen Medikationen, das entspricht dem Medikationsplan
CREATE Table Medikation (
	MedID INT PRIMARY KEY,
	rezept INT REFERENCES Rezept(RID),		
	medikament INT REFERENCES Medikament(PZN),		
	morgens int NOT NULL,
	mittags int NOT NULL,
	abends int NOT NULL
);

-- TESTDATEN

-- Patienten
INSERT INTO Patient VALUES  (1, 'Maier','Heinrich','1970-01-12','Heidelberg','Schroederstrasse 23') , 
                            (2, 'Mueller','Petra','1975-04-04','Mannheim','C3 4') , 
                            (3, 'Ziegler','Anne','1960-12-12','Heidelberg','Brueckenstrasse 4') , 
                            (4, 'Zuber','Marvin','1988-06-12','Heidelberg','Ladenburgerstr 22') , 
                            (5, 'Schmid','Lena','1988-01-01','Mannheim','John-Dree-Strasse 5') ,
                            (6, 'Schmid','Mira','1985-01-09','Karlsruhe','Hauptstrasse 23');

-- Ärzte
INSERT INTO Arzt VALUES     (1, 'Ziegler','Heidelberg','Moenchhofstrasse 33') , 
                            (2, 'Sahmid','Mannheim','Hauptstrasse 22') , 
                            (3, 'Choud','Heidelberg','Rohrbacherstrasse 77') , 
                            (4, 'Schnipsel','Karlsruhe','Bergallee 5') ,
                            (5, 'Nagel','Mannheim','Q2 2') ;

-- Apotheken
INSERT INTO Apotheke VALUES (1, 'Gesundheit','Heidelberg','Schroederstrasse 3') , 
                            (2, 'Hatschi','Mannheim','Hauptstrasse 119') , 
                            (3, 'Gute Besserung','Heidelberg','Bergstrasse 77') , 
                            (4, 'Gute Besserung','Karlsruhe','Untere Strasse 22') ;


-- Rezepte
INSERT INTO REZEPT VALUES   (1, '2020-03-01', 1,1,1),
                            (2, '2020-03-01', 1,3,1),
                            (3, '2020-03-03', 1,2,2),
                            (4, '2020-03-11', 2,2,2),
                            (5, '2020-03-01', 5,4,3),
                            (6, '2020-03-20', 2,2,2), -- Petra Ziegler war zweimal beim gleichen Arzt und in der gleichen Apotheke
                            (7, '2020-03-20', 4,1,1),
                            (8, '2020-03-20', 3,1,3);

-- Wirkstoff und Medikamente
INSERT INTO Wirkstoff VALUES    (1, 'Ibuprofen');
INSERT INTO Medikament VALUES   (1001,'Aktren'),
                                (1002,'Dolormin');
INSERT INTO MedikamentWirkstoff VALUES (1001,1),
                                       (1002,1);

INSERT INTO Wirkstoff VALUES    (2, 'Digoxin');
INSERT INTO Medikament VALUES   (2001,'Digacin'),
                                (2002,'Lanicor');
INSERT INTO MedikamentWirkstoff VALUES (2001,2),
                                       (2002,2);


INSERT INTO Wirkstoff VALUES    (3, 'Salbutamol');
INSERT INTO Medikament VALUES   (3001,'Apsolol'),
                                (3002,'Salbubronch');
INSERT INTO MedikamentWirkstoff VALUES (3001,3),
                                       (3002,3);


INSERT INTO Wirkstoff VALUES    (4, 'Diuretika');

INSERT INTO Wirkstoff VALUES    (5, 'Oxytocin');
INSERT INTO Medikament VALUES   (5001, 'Carbetocin'),
                                (5002, 'Pabal');
INSERT INTO MedikamentWirkstoff VALUES (5001,5),
                                       (5002,5);


INSERT INTO Wirkstoff VALUES    (6, 'Procarbazin');
INSERT INTO Medikament VALUES   (6001, 'Natulan');
INSERT INTO MedikamentWirkstoff VALUES (6001,6);


INSERT INTO Wirkstoff VALUES    (7,'Johanniskraut');
INSERT INTO Medikament VALUES   (7001, 'Laif 900 Balance');
INSERT INTO MedikamentWirkstoff VALUES (7001,7);

-- Wechselwirkungen
INSERT INTO WechselWirkung VALUES (2, 1, 'Serumspiegel kann sich erhöhen'); -- 'Digoxin' und 'Ibuprofen'
INSERT INTO WechselWirkung VALUES (2, 3, 'Random Stuff'); -- 'Digoxin' und 'Salbutamol'
INSERT INTO WechselWirkung VALUES (3, 4, 'Risiko einer Hypokaliämie'); -- 'Salbutamol' und 'Diuretika',
INSERT INTO WechselWirkung VALUES (3, 6, 'Hypertonie'); -- 'Salbutamol'und 'Procarbazin',
INSERT INTO WechselWirkung VALUES (3, 5, 'veränderte Herz-Kreislauf-Regulation'); -- 'Salbutamol','Oxytocin'

-- Medikationen
INSERT INTO Medikation VALUES   (1, 1, 3001, 2, 2, 2), -- MedID, rezeptID, PZN, morgens, mittags, abends
                                (2, 1, 6001, 1, 1, 1),
                                (3, 2, 3002, 2, 2, 2),
                                (4, 3, 7001, 2, 0, 2),
                                (5, 4, 5002, 0, 0, 2),
                                (6, 5, 1002, 1, 1, 1),
                                (7, 6, 3001, 2, 2, 2),
                                (8, 7, 2001, 1, 0, 1),
                                (9, 8, 2002, 2, 2, 2);



--1. Geben Sie eine Liste aller Patienten aus.
SELECT * FROM Patient;

--2. Geben Sie die Namen aller Apotheken in Mannheim aus.
SELECT name FROM Apotheke WHERE stadt = 'Mannheim';

--3. Geben Sie die Namen aller Ärzte aus, deren Namen mit „S“ beginnt und die ihre
--Praxis in Heidelberg oder Mannheim betreiben.
SELECT name FROM Arzt WHERE name like 'S%' AND (stadt = 'Mannheim' OR stadt = 'Heidelberg');

--4. Erstellen Sie eine Liste aller Rezepte von Patienten aus Mannheim inklusive des Namens
--  des verschreibenden Arztes.
SELECT Rezept.*, Arzt.name FROM Rezept JOIN Patient ON Rezept.PID = Patient.PID JOIN Arzt ON Arzt.ArztID = Rezept.ArztID WHERE Patient.stadt = 'Mannheim';

--5. Wie viele Rezepte wurden von dem Arzt „Ziegler“ verschrieben?
SELECT Arzt.name, count(*) FROM Rezept JOIN Arzt ON Rezept.ArztID = Arzt.ArztID WHERE Arzt.name = 'Ziegler' GROUP BY Arzt.name;

--6. Wir brauchen eine Liste mit allen Ärzten und der Anzahl der von Ihnen ausgestellten
--Rezepten.
SELECT Arzt.name, count(Rezept.*) FROM Rezept JOIN Arzt ON Rezept.ArztID = Arzt.ArztID GROUP BY Arzt.name;

--7. Wir suchen alle Wirkstoffe, die mit mindestens zwei anderen Wirkstoffen in
--Wechselwirkung stehen.
SELECT Wirkstoff.name, count(*) FROM Wirkstoff, WechselWirkung WHERE Wirkstoff.WID = WechselWirkung.wirkstoff1 OR Wirkstoff.WID = WechselWirkung.wirkstoff2 GROUP BY Wirkstoff.name HAVING count(*) > 1;

--8. Die Apotheke „Gesundheit“ braucht eine Liste Ihrer Stammkunden (die patient.pid
--genügt). Stammkunden sind alle Kunden, die schon mindestens zwei Rezepte
--eingelöst haben.
SELECT Patient.*, count(*) FROM Patient JOIN Rezept ON Patient.PID = Rezept.PID JOIN Apotheke ON Rezept.ApoID = Apotheke.ApoID WHERE Apotheke.name = 'Gesundheit' GROUP BY Patient.PID HAVING count(*) > 1;

--9. Wir brauchen eine Liste der Vornamen und Nachnamen aller Patienten und derer
--eingenommenen Medikamente. Benennen Sie die Spalte mit dem Medikament als
--„Medikament“.
SELECT P.vorname, P.name, X.name AS Medikament
FROM Patient P JOIN Rezept R ON P.PID = R.PID JOIN Medikation M ON R.RID = M.rezept JOIN Medikament X ON M.medikament = X.PZN;

--10. Wir brauchen eine Liste der Wirkstoffe, die NICHT mit anderen Wirkstoffen in
--Wechselwirkung stehen.
SELECT * FROM Wirkstoff W WHERE W.WID not in (SELECT Wirkstoff1 FROM WechselWirkung UNION SELECT Wirkstoff2 FROM WechselWirkung);


--Eigen
SELECT A.ApoID, count(R.RID) FROM Rezept R, Apotheke A WHERE R.ApoID = A.ApoID GROUP BY A.ApoID HAVING count(R.RID) > 1;
SELECT DISTINCT W.Name FROM Wirkstoff W, Wechselwirkung K WHERE W.WID = Wirkstoff1 or W.WID = Wirkstoff2;


DROP TABLE Medikation;
DROP TABLE WechselWirkung;
DROP TABLE MedikamentWirkstoff;
DROP TABLE Wirkstoff;
DROP TABLE Medikament;
DROP TABLE Rezept;
DROP TABLE Arzt;
DROP TABLE Apotheke;
DROP TABLE Patient;