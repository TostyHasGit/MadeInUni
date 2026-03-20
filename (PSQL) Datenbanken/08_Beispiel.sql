DROP TABLE Kunde, Mitarbeiter, Bestellung, Artikel, Bestellposten CASCADE;

CREATE TABLE Kunde (
    KID INT PRIMARY KEY,
    Name VARCHAR(80),
    Adresse VARCHAR(80)
);

CREATE TABLE Mitarbeiter (
    MID INT PRIMARY KEY,
    Name VARCHAR(80),
    Adresse VARCHAR(80)
);

CREATE TABLE Bestellung (
    BID INT PRIMARY KEY,
    Datum DATE,
    Kunde INT REFERENCES Kunde(KID)
);

CREATE TABLE Artikel(
    AID INT PRIMARY KEY,
    Bezeichnung VARCHAR(80),
    Preis DECIMAL(5,2)
);

CREATE TABLE Bestellposten(
    BID INT REFERENCES Bestellung(BID),
    AID INT REFERENCES Artikel(AID),
    Menge INT
);

INSERT INTO Kunde VALUES (1,'Hastenteufel','Heidelberg'),
                        (2,'Barth','Mannheim'),
                        (3,'Damm','Mannheim'),
                        (4,'Bohli',NULL),
                        (5,'Schmid','Ladenburg');

INSERT INTO Mitarbeiter VALUES (1,'Hastenteufel','Heidelberg'),
                        (2,'Kleinschmidt','Mannheim'),
                        (3,'Damm','Mannheim'),
                        (4,'Meier','Heidelberg'),
                        (5,'Hein','Weinheim');

INSERT INTO Artikel VALUES (1,'Buch Datenbanken',29.99),
                        (2,'Buch Software',39.99),
                        (3,'Buch Web',19.99);

INSERT INTO Bestellung VALUES (1,'01.01.2022',1),
                            (2,'01.01.2023',1),
                            (3,'11.11.2022',2);

INSERT INTO Bestellposten VALUES (1,1,5),
                           (1,2,5),
                           (2,3,1),
                           (3,2,1);

SELECT * FROM Kunde;
SELECT * FROM Artikel;
SELECT * FROM Bestellung;
SELECT * FROM Bestellposten;





