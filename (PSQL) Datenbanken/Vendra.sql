--\set echo all

create table xPerson (
    vorname varchar(80),
    name varchar(80),
    PersNr int primary key
);

create table xBuchung (
    BID int primary key,
    Datum date,
    Preis numeric(9,2),
    bucher int references xPerson(PersNr)
);

create table xTicket (
    TID int primary key,
    Klasse varchar(80) check (Klasse in ('Economy','Business','First')),
    Reihe int check(Reihe >=0 and Reihe <=100),
    Platz varchar(1) check (Platz in('A','B','C','D','E','F','H','I')),
    person int references xPerson(PersNr),
    buchung int references xBuchung(BID)
);
----

create table xFlughafen (
    Code varchar(3) primary key,
    Stadt varchar(80),
    Name varchar(80)
);

create table xFlug (
    Nr varchar(10),
    Abflugzeit time,
    Flugdauer float,
    startet varchar(3) references xFlughafen(Code),
    landet varchar(3) references xFlughafen(Code),
    primary key (Nr)
);

---
create table xFlugzeug (
    FID int primary key,
    Baujahr int,
    Model varchar(80),
    Reichweite int,
    Plaetze int
);

--- jetzt die N:M
create table xTicketFlug(
    ticket int references xTicket(TID),
    flugnr varchar(10) references xFlug(Nr),
    datum date
);

create table xFlugFlugzeug (
    flugnr varchar(10) references xFlug(Nr),
    flugzeug int references xFlugzeug(FID),
    datum date
);

-- Personen
insert into xPerson values ('Peter','Kroesus',1);
insert into xPerson values ('Lena','Meier',2);
insert into xPerson values ('Thomas','Mueller',3);
insert into xPerson values ('Maxi','Baier',4);
insert into xPerson values ('Flo','Wirtz',5);
insert into xPerson values ('Lara','Flugangst',6);
insert into xPerson values ('Klara','Bahnfahrer',7);

--Buchungen
insert into xBuchung values (11,'1.4.2024',2000,1);
insert into xBuchung values (22,'1.1.2024',500,3); -- Thomas Müller
insert into xBuchung values (33,'1.1.2024',500,4); -- Maxi Baier
insert into xBuchung values (44,'1.1.2024',500,4); -- Maxi Baier
insert into xBuchung values (55,'1.2.2024',700,5); -- Flo Wirtz


-- Tickets
insert into xTicket values (111,'Business',10,'A',1,11);
insert into xTicket values (222,'Business',10,'B',2,11);
insert into xTicket values (333,'Business',20,'A',3,22);-- Thomas Müller
insert into xTicket values (444,'First',1,'A',4,33);-- Maxi Baier
insert into xTicket values (555,'First',1,'A',4,44);-- Maxi Baier
insert into xTicket values (666,'Economy',100,'A',5,55);-- Flo Wirtz


--- Flughafen
insert into xFlughafen values ('FRA','Frankfurt','FRAPORT');
insert into xFlughafen values ('MIA','Miami','Miami International Airport');
insert into xFlughafen values ('MAD','Madrid','Madrid-Bajaras');
insert into xFlughafen values ('CDG','Paris',NULL);
insert into xFlughafen values ('JFK','New York','John F. Kennedy Airport');


-- Flug
insert into xFlug values ('LH123','9:00',10,'FRA','MIA');
insert into xFlug values ('LH124','12:00',11,'MIA','FRA');
insert into xFlug values ('LH2000','9:00',1.5,'FRA','MAD');
insert into xFlug values ('LH2001','15:00',1.5,'MAD','FRA');
insert into xFlug values ('LH3000','9:00',1,'FRA','CDG');
insert into xFlug values ('LH3001','12:00',1,'CDG','FRA');

--- Flugzeuge
insert into xflugzeug values (1, 2020, '787',12000,400);
insert into xflugzeug values (2, 2022, 'A340',12300,400);
insert into xflugzeug values (3, 2022, '737',2500,180);
insert into xflugzeug values (4, 2022, '737-8',3300,180);
insert into xflugzeug values (5, 2015, 'A380',12800,500);
insert into xflugzeug values (6, 2018, '787',11000,500);
insert into xflugzeug values (7, 2018, '787',11000,500);
insert into xflugzeug values (8, 2021, '737-8',3500,180);


--- TicketFlug
insert into xTicketFlug values (111,'LH123','1.6.2024');
insert into xTicketFlug values (222,'LH123','1.6.2024');
insert into xTicketFlug values (333,'LH2000','1.6.2024');
insert into xTicketFlug values (444,'LH2000','15.6.2024');
insert into xTicketFlug values (555,'LH2001','1.7.2024');
insert into xTicketFlug values (666,'LH3000','1.6.2024');


--FlugFlugzeuge
insert into xFlugFlugzeug values ('LH123',1,'1.6.2024');
insert into xFlugFlugzeug values ('LH2000',3,'1.6.2024');
insert into xFlugFlugzeug values ('LH2000',4,'15.6.2024');
insert into xFlugFlugzeug values ('LH2001',4,'1.7.2024');
insert into xFlugFlugzeug values ('LH3000',3,'1.6.2024');


-- 1: Liste aller Namen von Flughaefen
SELECT name FROM xFlughafen;


-- 2: Liste von Stadtnamen und Codes der Flughaefen, von denen der Name des Flughafens nicht bekannt ist
SELECT Code, Stadt FROM xFlughafen WHERE name is NULL;


-- 3: Die Namen der Personen, welche Buchungen mit einem Preis groesser als 1000 Euro getaetigt haben.
SELECT P.vorname, P.name FROM xPerson P JOIN xBuchung B ON P.PersNr = B.bucher WHERE B.Preis > 1000;


-- 4: Alle Buchungen sowie Vor- und Nachnamen der Ticketinhaber die zur jeweiligen Buchung gehoeren
SELECT T.buchung, P.vorname, P.name FROM xPerson P JOIN xBuchung B ON P.PersNr = B.bucher JOIN xTicket T ON P.PersNr = T.person;


-- 5: Wir brauchen eine Liste der Namen von Personen ohne Flugticket
SELECT P.* FROM xPerson P WHERE P.PersNr NOT IN (SELECT T.person FROM xTicket T);


-- 6: Liste aller Flugnummern und die Stadtnamen in denen sie starten und landen
SELECT FH.Stadt, F.Nr FROM xFlug F, xFlughafen FH WHERE FH.Code = F.startet OR FH.Code = F.landet;


-- 7: Liste von Namen der Ticketinhaber, das Abflugdatum und das Reiseziel (Name der Stadt in der der Flug landet)
SELECT P.vorname, P.name, TF.datum AS Abflugdatum, FH.stadt AS Reiseziel FROM xPerson P JOIN xTicket T ON P.PersNr = T.person JOIN xTicketFlug TF ON T.TID = TF.ticket JOIN xFlug F ON TF.flugnr = F.Nr JOIN xFlughafen FH ON F.landet = FH.Code;


-- 8: Falls ein Flugzeug ausfaellt, gibt es Backup-Flugzeuge. Ein Backup-Flugzeug kann sein wenn es eine
-- Reichweite +/- 500km wie das ausgefallene Flugzeug aufweisst. 
-- Erstellen Sie eine Liste der Flugzeuge und den moeglichen Backupflugzegen 


-- 9: Liste mit Flugzeugmodellen und die Anzahl der Fluege, die mit einem Flugzeug dieses Models durchgefuehrt werden
-- Hinweis: das Flugzeugmodel entspricht dem Attribut Model in der Tabelle xFlugzeug



-- 10: Mit welchem Flugzeugmodel (Model, nicht konkretes Flugzeug) werden die meisten Fluege durchgefuehrt
SELECT FZ.Model, count(FZ.Model) FROM xFlugzeug FZ JOIN xFlugFlugzeug FF ON FZ.FID = FF.flugzeug GROUP BY FZ.Model ORDER BY count(FZ.Model) DESC;




-- DROP
DROP table xTicketFlug;
Drop table xFlugFlugzeug;
DROP table xTicket;
DROP table xBuchung;
DROP table xPerson;
DROP table xFlug;
DROP table xFlughafen;
DROP table xFlugzeug;
