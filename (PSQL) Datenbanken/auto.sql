CREATE TABle Automodell (
    ANr INT PRIMARY KEY,
    Hersteller VARCHAR(80),
    Modell VARCHAR(80),
    Typ VARCHAR(80)
);

CREATE TABLE Auto (
    ANr INT REFERENCES Automodell(ANr),
    Fahrer VARCHAR(80)
);

INSERT INTO Automodell VALUES (11,'BMW','320d','Kombi'),
            (13,'Daihatsu','Cuore','Cabriolet'),
            (15,'Mercedes','1120d','LKW'),
            (17,'Opel','B-Kadett','Coupe'),
            (19,'Skoda','Octavia','Kombi'),
            (21,'VW','Kaefer','Cabriolet'),
            (23,'Opel','Admiral','Limousine');
INSERT INTO Auto VALUES 
    (11,'Rudi'),
    (13,'Susi'),
    (17,'Rudi'),
    (23,'Susi');

SELECT Fahrer FROM Auto;
SELECT * FROM Auto WHERE Fahrer = 'Susi';
SELECT Hersteller FROM Automodell WHERE Typ = 'Kombi';
SELECT ANr FROM Auto NATURAL JOIN Automodell;
ALTER TABLE Automodell
RENAME COLUMN ANr TO BNr;
--?????--
SELECT DISTINCT ANr FROM Auto NATURAL JOIN Automodell;

ALTER TABLE Automodell
RENAME COLUMN BNr TO ANr;
SELECT Hersteller FROM Automodell;
SELECT Modell FROM Automodell WHERE Hersteller = 'Opel';
--?????--
SELECT DISTINCT Hersteller FROM Auto NATURAL JOIN Automodell;
SELECT Typ FROM Auto NATURAL JOIN Automodell WHERE Fahrer = 'Rudi';


DROP TABLE Auto;
DROP TABLE Automodell;