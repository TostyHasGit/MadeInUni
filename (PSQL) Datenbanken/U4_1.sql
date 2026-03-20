--DROP TABLE Status;
--DROP TABLE Zustand;
--DROP TABLE Buerger;
--DROP TABLE CoronaTest;
--DROP TABLE Kontakt;
--DROP TABLE Bundesland;

CREATE TABLE Status(
    stat VARCHAR(80) PRIMARY KEY
);
INSERT INTO Status VALUES('Warte auf Ergebnis');
INSERT INTO Status VALUES('positiv');
INSERT INTO Status VALUES('negativ');

CREATE TABLE Zustand(
    zus VARCHAR(80) PRIMARY KEY
);
INSERT INTO Zustand VALUES('Keine Symptome');
INSERT INTO Zustand VALUES('Schwache Symptome');
INSERT INTO Zustand VALUES('Kritischer Zustand');


CREATE TABLE Buerger(
    id VARCHAR(80) PRIMARY KEY,
    name VARCHAR(80),
    vorname VARCHAR(80),
    gdatum VARCHAR(80),
    tnummer VARCHAR(80),
    email VARCHAR(80),
    strasse VARCHAR(80),
    plz INT,
    ort VARCHAR(80),
    bland VARCHAR(80),
    zustand VARCHAR(80) REFERENCES Zustand(zus)
);

CREATE TABLE CoronaTest(
    datum VARCHAR(80),
    ort VARCHAR(80),
    status VARCHAR(80) REFERENCES Status(stat)
);

CREATE TABLE Kontakt(
    buergerA VARCHAR(80) REFERENCES Buerger(id) NULL,
    buergerB VARCHAR(80) REFERENCES Buerger(id) NULL,
    ort VARCHAR(80),
    datum VARCHAR(80)
);


CREATE TABLE Bundesland(
    einwohner VARCHAR(80),
    hauptstadt VARCHAR(80),
    ministerpraesident VARCHAR(80),
    gesundheitsminister VARCHAR(80)
);

SELECT * FROM Buerger;
SELECT * FROM CoronaTest;
SELECT * FROM Kontakt;
SELECT * FROM Bundesland;