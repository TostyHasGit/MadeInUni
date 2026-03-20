CREATE DOMAIN Posi VARCHAR(80)
    CHECK (VALUE IN ('Tor', 'Abwehr', 'Mittelfeld', 'Sturm'));

CREATE DOMAIN Betreuer_bez varchar(80)
    CHECK (VALUE IN('Trainer', 'Arzt', 'Co-Trainer', 'Zeugwart', 'Sonstiges'));

CREATE TABLE Land(
    name varchar(80) primary KEY
);
INSERT INTO Land VALUES('Deutschland');
INSERT INTO Land VALUES('Portugal');

CREATE TABLE Team(
    id SERIAL PRIMARY KEY,
    teamname varchar(80),
    siege INT CHECK(siege>=0),
    land varchar(80) REFERENCES Land(name)
);
INSERT INTO Team VALUES(1, 'Nationalmanschaft', 0, 'Deutschland');
INSERT INTO Team VALUES(2, 'Selecao', 0, 'Portugal');

CREATE TABLE Spiele(
    id INT PRIMARY KEY,
    stadion varchar(80),
    datum DATE,
    toreHeim INT CHECK(toreHeim>=0),
    toreAuswarts INT CHECK(toreAuswarts>=0),
    heimManschaft INT REFERENCES Team(id),
    auswartsManschaft INT CHECK(auswartsManschaft != heimManschaft) REFERENCES Team(id)
);
INSERT INTO Spiele VALUES(1, 'Wembley-Stadion', '5.07.2018', 1, 1, 1, 2);

CREATE TABLE Person(
    name varchar(80) PRIMARY KEY,
    gebDatum DATE NULL,
    team INT REFERENCES Team(id)
);
INSERT INTO Person VALUES('Thomas Müller', NULL, 1);
INSERT INTO Person VALUES('Jogi Löw', NULL, 1);
INSERT INTO Person VALUES('Christiano Ronaldo', NULL, 2);

CREATE TABLE Spieler(
    id SERIAL PRIMARY KEY,
    spieler_name varchar(80) REFERENCES Person(name),
    position Posi
);
INSERT INTO Spieler VALUES(1, 'Thomas Müller', 'Sturm');
INSERT INTO Spieler VALUES(2, 'Christiano Ronaldo', 'Sturm');


CREATE TABLE Tore(
    minute INT CHECK(minute BETWEEN 0 AND 90),
    spielid INT REFERENCES Spiele(id),
    spielerid INT REFERENCES Spieler(id)
);
INSERT INTO Tore VALUES(9, 1, 1);
INSERT INTO Tore VALUES(60, 1, 2);

CREATE TABLE Betreuer(
    name varchar(80) REFERENCES Person(name) PRIMARY KEY
);
INSERT INTO Betreuer VALUES('Jogi Löw');

CREATE TABLE Funktion(
    bet_name varchar(80) REFERENCES Betreuer(name),
    funktion Betreuer_bez
);
INSERT INTO Funktion VALUES('Jogi Löw', 'Trainer');
INSERT INTO Funktion VALUES('Jogi Löw', 'Sonstiges');



SELECT * FROM Land;
SELECT * FROM Team;
SELECT * FROM Spiele;
SELECT * FROM Person;
SELECT * FROM Tore;
SELECT * FROM Spieler;
SELECT * FROM Funktion;
SELECT * FROM Betreuer;

DROP TABLE Betreuer CASCADE;
DROP TABLE Funktion;
DROP TABLE Tore;
DROP TABLE Spieler CASCADE;
DROP TABLE Person;
DROP TABLE Spiele CASCADE;
DROP TABLE Team;
DROP TABLE Land;
DROP DOMAIN Betreuer_bez;
DROP DOMAIN Posi;