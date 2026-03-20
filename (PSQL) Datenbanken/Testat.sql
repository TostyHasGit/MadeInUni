CREATE DOMAIN Zustand varchar(80)
    CHECK(VALUE IN ('startet', 'landet'));

CREATE DOMAIN Klasse varchar(80)
    CHECK(VALUE IN ('Economy', 'Business', 'First'));

CREATE DOMAIN Buchstaben varchar(1)
    CHECK(VALUE IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'));

CREATE TABLE Person(
    persNr INT PRIMARY KEY,
    name varchar(80),
    vorname varchar(80)
);
INSERT INTO Person VALUES(1, 'Meier', 'Peter');
INSERT INTO Person VALUES(2, 'Meier', 'Lena');


CREATE TABLE Buchung(
    person INT REFERENCES Person(persNr),
    buchung_ID INT PRIMARY KEY,
    datum DATE,
    preis INT
);
INSERT INTO Buchung VALUES(1, 1, '01.04.24', 2000);

CREATE TABLE Ticket(
    buchung INT REFERENCES Buchung(buchung_ID),
    person INT REFERENCES Person(persNr),
    t_ID INT PRIMARY KEY,
    klasse Klasse,
    reihe INT CHECK(reihe BETWEEN 0 AND 100),
    platz Buchstaben
);
INSERT INTO Ticket VALUES(1, 1, 1, 'Business', 10, 'A');
INSERT INTO Ticket VALUES(1, 2, 2, 'Business', 10, 'B');

CREATE TABLE Flughafen(
    code varchar(80) PRIMARY KEY,
    stadt varchar(80),
    name varchar(80)
);
INSERT INTO Flughafen VALUES('FRA', 'Frankfurt', 'FRA AIRPORT');
INSERT INTO Flughafen VALUES('MIA', 'MIAMI', 'MIA AIRPORT');

CREATE TABLE Flug(
    nr varchar(80),
    abflugszeit TIME,
    flugdauer INT,
    PRIMARY KEY (nr, abflugszeit),
    zustand Zustand
);
INSERT INTO Flug VALUES('LH123', '09:00', 10, 'startet');


CREATE TABLE Flugzeug(
    flugzeug_ID INT PRIMARY KEY,
    model varchar(80),
    reichweite INT,
    plätze INT
);
INSERT INTO Flugzeug VALUES(1, '737', 12000, 400);

-- Ticket x Flug
CREATE TABLE Abflug(
    ticket INT REFERENCES Ticket(t_ID),
    flug_nr varchar(80),
    flug_abflugszeit TIME,
    abflugsdatum DATE,
    FOREIGN KEY (flug_nr, flug_abflugszeit) REFERENCES Flug(nr, abflugszeit)
);
INSERT INTO Abflug VALUES(1, 'LH123', '9:00', '01.05.24');

-- Flug x Flugzeug
CREATE TABLE Fliegen(
    flugzeug INT REFERENCES Flugzeug(flugzeug_ID),
    flug_nr varchar(80),
    flug_abflugszeit TIME,
    abflugsdatum DATE,
    FOREIGN KEY (flug_nr, flug_abflugszeit) REFERENCES Flug(nr, abflugszeit)
);

SELECT * FROM Person;
SELECT * FROM Buchung;
SELECT * FROM Ticket;
SELECT * FROM Flughafen;
SELECT * FROM Flug;
SELECT * FROM Flugzeug;
SELECT * FROM Abflug;
SELECT * FROM Fliegen;

DROP TABLE Fliegen;
DROP TABLE Abflug;
DROP TABLE Flugzeug;
DROP TABLE Flug;
DROP TABLE Flughafen;
DROP TABLE Ticket;
DROP TABLE Buchung;
DROP TABLE Person;
DROP DOMAIN Zustand;
DROP DOMAIN Klasse;
DROP DOMAIN Buchstaben;