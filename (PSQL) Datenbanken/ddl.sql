-- Auch die Eingaben ausgeben
\set ECHO all

-- CREATE Beispiel
CREATE TABLE stud(
       vorname   VARCHAR(80),
       nachname	 VARCHAR(80),
       matnr	 INT);
\dt
\d stud
DROP TABLE stud; -- Wir räumen wieder auf

-- Wertebereiche
CREATE TABLE wertebereiche(
       a     INT,       b     INTEGER,       c     INT4,         -- 4 Byte
       d     SMALLINT,	e     INT2,                              -- 2 Byte
       e2    INT8,      -- geht auch grösser, nicht mehr Standard
       f     FLOAT,	g     FLOAT(1),      h     FLOAT(15),    -- double default
       i     DECIMAL(100,2),		     j	   NUMERIC(8,4), -- Fixpunktarithm.
       k     CHARACTER(10),		     l	   CHAR(10),	 -- String fester Länge
       m     CHARACTER VARYING(10),	     n	   VARCHAR(10),	 -- String maximaler Länge
       o     BIT(10),			     p	   BIT VARYING(10), -- Bit-Folgen
       q     DATE,     r      TIME,          s     TIMESTAMP,    -- Temporale Typen
       t     BOOLEAN,
       ende  INT);
\d wertebereiche
INSERT INTO wertebereiche VALUES
    (1, 1000, 2147483647, -- < 2**31
     1000, 32767,         -- < 2**15
     2147483648,          
	 10.123456789123456789,  10.123456789123456789, 10.123456789123456789,
	 1234567890123.123,	1234.12341, -- letzte Nachkommaziffer weg
	 'Hallo', 'Hallo zusa', -- längere Einträge Fehler
                            -- wird immer mit max Zeichen ausgegeben 
	 'Hallo', 'Hallo zusa', -- längere Einträge Fehler, gestaucht
     '0101010101', '111',
     '1.2.03', '11:12', CURRENT_TIMESTAMP,
     TRUE, 
     0);
SELECT * FROM wertebereiche;
DROP TABLE wertebereiche;

-- DOMAIN mit DEFAULT-Werten
CREATE DOMAIN fakultaet VARCHAR(20) DEFAULT 'Informationstechnik';
CREATE TABLE t(name varchar(80), fakult fakultaet);
INSERT INTO t VALUES('Hugo'); -- default Wert 'Informationstechnik'
INSERT INTO t VALUES('Herbert', 'E-Technik');
SELECT * FROM t;
DROP TABLE t;
DROP DOMAIN fakultaet;

-- DOMAIN mit "NOT NULL"-Constraint
CREATE DOMAIN fakultaet VARCHAR(20) NOT NULL;
CREATE TABLE t(name VARCHAR(80), fakult fakultaet);
INSERT INTO t VALUES('Hugo');  -- klappt nicht 
INSERT INTO t VALUES('Herbert', 'E-Technik');
SELECT * FROM t;
DROP TABLE t;
DROP DOMAIN fakultaet;

-- DOMAIN mit verschiedenen "CHECK"-Constraints
CREATE DOMAIN betrag AS NUMERIC(10,2) CHECK (VALUE > 0.00);
CREATE DOMAIN fakultaet VARCHAR(80) 
	CHECK (VALUE IN ('Informatik', 'E-Technik', 'Gestaltung'));
CREATE DOMAIN semester INT CHECK (VALUE BETWEEN 1 AND 12);
DROP DOMAIN fakultaet;
DROP DOMAIN betrag;
DROP DOMAIN semester;


-- DOMAIN mit numerischen "CHECK"-Constraints und passende Tabelle
CREATE DOMAIN betrag NUMERIC(10,2) CHECK (VALUE > 0.00);
CREATE TABLE p(preis betrag);
INSERT INTO p VALUES(9.98); 
INSERT INTO p VALUES(-2.98); -- klappt nicht
SELECT * FROM p;
DROP TABLE p;

-- CREATE TABLE mit numerischen "CHECK"-Constraints
CREATE TABLE p(preis NUMERIC(10,2) CHECK (preis > 0.00));
INSERT INTO p VALUES(9.98); 
INSERT INTO p VALUES(-2.98); -- klappt nicht
SELECT * FROM p;
DROP TABLE p;


-- CREATE TABLE mit Mengenauswahl "CHECK"-Constraints
CREATE TABLE t(name    VARCHAR(80), 
               fakult VARCHAR(80) CHECK (fakult IN ('Informatik', 'E-Technik', 'Gestaltung')));
INSERT INTO t VALUES('Hugo', 'Informatik'); 
INSERT INTO t VALUES('Herbert', 'E-Technik');
INSERT INTO t VALUES('Hilde', 'Germanistik');  -- klappt nicht
SELECT * FROM t;
DROP TABLE t;

-- CREATE TABLE mit BETWEEN-Constraint
CREATE TABLE s(sem INT CHECK (sem BETWEEN 1 AND 12));
INSERT INTO s VALUES (4); 
INSERT INTO s VALUES (18); -- klappt nicht
SELECT * FROM s;
DROP TABLE s;

-- "NOT NULL"-Constraint in CREATE TABLE
CREATE TABLE t(name VARCHAR(80), fakult VARCHAR(80) NOT NULL);
INSERT INTO t VALUES('Hugo');  -- klappt nicht
INSERT INTO t VALUES('Herbert', 'E-Technik');
SELECT * FROM t;
DROP TABLE t;

-- Integritätsbedingung für Tupel
CREATE TABLE k(
       produktpreis INT,
       servicepreis INT,
       CHECK (produktpreis + servicepreis < 100));
INSERT INTO k VALUES (60, 30);
INSERT INTO k VALUES (30, 60);
INSERT INTO k VALUES (60, 60); -- klappt nicht
SELECT * FROM k;
DROP TABLE k;

-- PRIMARY KEY und FOREIGN KEY
CREATE TABLE fakultaet(
       nummer INT,
       name   VARCHAR(80),
       PRIMARY KEY (nummer) -- implicit NOT NULL und UNIQUE
);
CREATE TABLE studierende(
       vorname VARCHAR(80),
       name VARCHAR(80),
       matnr INT PRIMARY KEY, -- kann in dieselbe Zeile geschrieben werden
       fakult INT,
       FOREIGN KEY (fakult) REFERENCES fakultaet (nummer)
);
INSERT INTO fakultaet VALUES (6, 'Informatik');
INSERT INTO fakultaet VALUES (5, 'Gestaltung');
INSERT INTO fakultaet VALUES (6, 'Ingenieursinformatik'); -- klappt nicht

INSERT INTO studierende VALUES ('Susi', 'Sinnlos', 4711, 6);
INSERT INTO studierende VALUES ('Rudi', 'Ratlos',  0815, 4); -- klappt nicht
DROP TABLE studierende;
DROP TABLE fakultaet;

-- ALTER TABLE
CREATE TABLE fakultaet(
       nummer int PRIMARY KEY);
INSERT INTO fakultaet VALUES (5);
SELECT * FROM fakultaet;
ALTER TABLE fakultaet ADD bezeichnung VARCHAR(80);
SELECT * FROM fakultaet;
INSERT INTO fakultaet VALUES (6,'Informatik');
SELECT * FROM fakultaet;
DROP TABLE fakultaet;