-- Es fehlt nur noch Projekt mit seinen Verknüpfungen :)



DROP TABLE Beziehungen;
DROP TABLE Leiten;
DROP TABLE Angestellter;
DROP TABLE Standort;
DROP TABLE Abteilung;
DROP TABLE Sex;

CREATE TABLE Sex(
    sex VARCHAR(80) PRIMARY KEY
);
INSERT INTO Sex VALUES('männlich'), ('weiblich'), ('diverse');

CREATE TABLE Abteilung(
    nr INT PRIMARY KEY,
    bezeichnung VARCHAR(80)
);

CREATE TABLE Standort(
    ort VARCHAR(80),
    abteilung INT REFERENCES Abteilung(nr) 
);

CREATE TABLE Angestellter(
    id INT PRIMARY KEY,
    name VARCHAR(80),
    adresse VARCHAR(80),
    gebi VARCHAR(80),
    geschlecht VARCHAR(80) REFERENCES Sex(sex)
);

CREATE TABLE Leiten(
    leiter INT REFERENCES Angestellter(id) PRIMARY KEY,
    abteilung INT REFERENCES Abteilung(nr),
    datum VARCHAR(80)
);

CREATE TABLE Beziehungen(
    master INT REFERENCES Angestellter(id),
    slave INT REFERENCES Angestellter(id)
);

SELECT * FROM Sex;
SELECT * FROM Abteilung;
SELECT * FROM Standort;
SELECT * FROM Angestellter;
SELECT * FROM Leiten;
SELECT * FROM Beziehungen;