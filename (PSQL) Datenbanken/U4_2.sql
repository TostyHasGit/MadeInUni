DROP TABLE BuchThemen;
DROP TABLE Publikation;
DROP TABLE Themen;
DROP TABLE Autoren;


CREATE TABLE Autoren (
    id INT SERIAL PRIMARY KEY,
    name VARCHAR(80),
    vorname VARCHAR(80)
);
INSERT INTO Autoren VALUES(1, 'Patricia', 'Ressler');
INSERT INTO Autoren VALUES(2, 'Antonio', 'Vendra');
INSERT INTO Autoren VALUES(3, 'Ionela', 'Moldovan');

CREATE TABLE Themen(
    thema VARCHAR(80) PRIMARY KEY
);
INSERT INTO Themen VALUES('Pokemon');
INSERT INTO Themen VALUES('Games');
INSERT INTO Themen VALUES('Waifus');

CREATE TABLE Publikation(
    titel VARCHAR(80) PRIMARY KEY,
    autor INT REFERENCES Autoren(id),
    datum VARCHAR(80)
);
INSERT INTO Publikation VALUES('Pokemon in Ihren natürlichem Lebensraum', 2, '14.07.1998');
INSERT INTO Publikation VALUES('Trainer Toni und sein unglaubliche Aufstieg zu Pokemonmeister',
 2, '12.08.2000');
INSERT INTO Publikation VALUES('HOT POKE-WAIFU IONELA', 3, '06.01.2002');

CREATE TABLE BuchThemen(
    buchTitel VARCHAR(80) REFERENCES Publikation(titel),
    buchThema VARCHAR(80) REFERENCES Themen(thema)
);
INSERT INTO BuchThemen VALUES('Pokemon in Ihren natürlichem Lebensraum',
 'Pokemon'), ('Pokemon in Ihren natürlichem Lebensraum', 'Games');
INSERT INTO BuchThemen VALUES('Trainer Toni und sein unglaubliche Aufstieg zu Pokemonmeister',
 'Pokemon'), ('Trainer Toni und sein unglaubliche Aufstieg zu Pokemonmeister',
 'Games');
INSERT INTO BuchThemen VALUES('HOT POKE-WAIFU IONELA',
 'Pokemon'), ('HOT POKE-WAIFU IONELA', 'Waifus');

SELECT * FROM Autoren;
SELECT * FROM Publikation;
SELECT * FROM Themen;
SELECT * FROM BuchThemen;