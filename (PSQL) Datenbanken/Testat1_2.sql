CREATE TABLE Kunde(
    name varchar(80),
    v_name varchar(80),
    m_Nr INT PRIMARY KEY
);

CREATE TABLE Beteiligte(
    name varchar(80),
    v_name varchar(80),
    b_ID INT PRIMARY KEY
);

CREATE TABLE Qualität(
    beschreibung varchar(80) PRIMARY KEY
);

CREATE TABLE Staffel(
    s_ID INT PRIMARY KEY,
    nummer INT,
    name varchar(80)
);

CREATE TABLE QualixStaffel(
    beschreibung varchar(80) REFERENCES Qualität(beschreibung),
    s_ID INT REFERENCES Staffel(s_ID) UNIQUE,
    preis FLOAT CHECK (preis > 0)
);

CREATE TABLE Serienfolge(
    ser_ID INT PRIMARY KEY,
    Nummer INT,
    staffel INT REFERENCES Staffel(s_ID)
);

CREATE TABLE Film(
    f_ID INT PRIMARY KEY
);

CREATE DOMAIN Genre varchar(80)
    CHECK (VALUE IN('HD', 'UHD', '16Bit'));


CREATE TABLE Video(
    v_ID INT PRIMARY KEY,
    titel varchar(80),
    genre Genre,
    spieldauer INT,
    film INT REFERENCES Film(f_ID) NULL,
    sFolge INT REFERENCES Serienfolge(ser_ID) NULL
);

CREATE TABLE Spielt_in(
    video INT REFERENCES Video(v_ID),
    beteiligte INT REFERENCES Beteiligte(b_ID)
);

CREATE TABLE Schauen(
    kunde INT REFERENCES Kunde(m_Nr),
    bewertung INT CHECK(bewertung BETWEEN 0 AND 5),
    datum DATE,
    video INT REFERENCES Video(v_ID)
);

CREATE TABLE Watchlist(
    kunde INT REFERENCES Kunde(m_Nr),
    video INT REFERENCES Video(v_ID)
);

CREATE TABLE VidxQua(
    preis FLOAT CHECK(preis > 0),
    video INT REFERENCES Video(v_ID),
    qualität varchar(80) REFERENCES Qualität(beschreibung)
);

SELECT * FROM Kunde;
SELECT * FROM Beteiligte;
SELECT * FROM Qualität;
SELECT * FROM Staffel;
SELECT * FROM QualixStaffel;
SELECT * FROM Serienfolge;
SELECT * FROM Film;
SELECT * FROM Video;
SELECT * FROM Spielt_in;
SELECT * FROM Schauen;
SELECT * FROM Watchlist;
SELECT * FROM VidxQua;

DROP TABLE VidxQua;
DROP TABLE Watchlist;
DROP TABLE Schauen;
DROP TABLE Spielt_in;
DROP TABLE Video;
DROP DOMAIN Genre;
DROP TABLE Film;
DROP TABLE Serienfolge;
DROP TABLE QualixStaffel;
DROP TABLE Staffel;
DROP TABLE Qualität;
DROP TABLE Beteiligte;
DROP TABLE Kunde;