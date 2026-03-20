-- aufräumen
drop table KundeSchaut;
drop table Watchlist;
drop table Kunde;
drop table FilmGenre;
drop table Genre;
drop table SpieltIn;
drop table Film;
drop table beteiligte;
drop domain bewertung;


create table Kunde (
    KdId int primary key,
    Name varchar(80),
    Vorname varchar(80)
);

create table Beteiligte (
    PersID int primary key,
    Name varchar(80),
    Vorname varchar(80)
);

create table Film (
    FilmID int primary key ,
    Titel varchar(80),
    Spieldauer int,
    Jahr int,
    Regisseur int references Beteiligte(PersID)
);


create table SpieltIn (
    FilmID int references Film(FilmID),
    Schauspieler int references Beteiligte(PersID)
);

create Table Genre(
    Bezeichnung varchar(80) primary key
);

create table FilmGenre(
    Genre varchar(80) references Genre(Bezeichnung),
    FilmID int references Film(FilmID)
);

create domain bewertung as int check (value in (1,2,3,4,5));

create table KundeSchaut (
    Kunde int references Kunde(KdId),
    Film int references Film(FilmID),
    Bewertung bewertung,
    Datum date
);

create table Watchlist (
    Kunde int references Kunde(KdId),
    Film int references Film(FilmID)
);

insert into Beteiligte values
    (1001, 'Hamilton', 'Guy'),
    (1002, 'Connery', 'Sean'),
    (1003, 'Froebe','Gerd'),
    (1004, 'Cameron','James'),
    (1005, 'Schwarzenegger','Arnold'),
    (1006, 'Hamilton','Linda'),
    (1007, 'Tarantino','Quentin'),
    (1008, 'Travolta','John'),
    (1009, 'Jackson','Samuel L.'),
    (1010, 'Lucas','George'),
    (1011, 'McGregor','Ewan'),
    (1012, 'Portman', 'Natalie');


insert into genre values  ('Action'),
                          ('Krimi'),
                          ('SciFi'),
                          ('Thriller'),
                          ('Drama'),
                          ('Fantasy'),
                          ('Comedy');

-- (FilmID, Titel, Spieldauer, Jahr, Regisseur)
insert into Film values (1, 'James Bond 007 Goldfinger', 109, 1964, 1001),
    (2,'Terminator 1', 107, 1984, 1004),
    (3,'Pulp Fiction', 154, 1994, 1007),
    (4,'Star Wars: Episode 1',136,1999,1010),
    (5,'Star Wars: Episode 2',142,2002,1010);


-- (FilmID, Schauspieler)
insert into SpieltIn values (1,1002),
                            (1,1003),
                            (2,1005),
                            (2,1006),
                            (3,1007),
                            (3,1008),
                            (3,1009),
                            (4,1011),
                            (4,1012),
                            (5,1011),
                            (5,1012);


insert into FilmGenre values ('Action',1),
                              ('Krimi',1),
                              ('SciFi',2),
                              ('Thriller',2),
                              ('Drama',3),
                              ('SciFi',4),
                              ('Action',4),
                              ('SciFi',5),
                              ('Action',5);


insert into Kunde values (4711,'Mueller','Thomas'),
                        (4712,'Lustig','Peter'),
                        (4713,'Helga','Maier'),
                        (4714,'Mueller','Lisl'),
                        (4715,'Engel','Thomas');


-- (KdId, Film, Bewertung, Datum)
insert into KundeSchaut values (4711,1,4,'2019-12-30'),
                            (4711,3,5,'2020-07-10'),
                            (4712,2,2,'2021-01-01'),
                            (4712,4,5,'2021-01-02'),
                            (4712,5,5,'2021-01-03'),
                            (4713,4,4,'2020-08-08'),
                            (4714,2,3,'2019-11-11'),
                            (4715,4,5,'2020-12-27'),
                            (4715,5,5,'2020-12-28');

-- (kdId, FilmId)
insert into Watchlist values (4711,1),
                            (4711,2),
                            (4711,3),
                            (4711,4),
                            (4711,5),
                            (4712,3),
                            (4712,2),
                            (4713,3),
                            (4714,4),
                            (4714,3),
                            (4715,5);




--1. Zur Vorbereitung auf einen Filmabend brauchen wir eine Liste mit allen Filmtiteln
--sowie dem Erscheinungsjahr der Filme.
SELECT Titel, Jahr FROM Film;

--2. Da es schon recht spät am Abend ist, wollen wir jetzt eine Liste mit allen Filmtiteln,
--deren Spieldauer nicht länger als 2 Stunden (120 min) beträgt.
SELECT Titel, Spieldauer FROM Film WHERE Spieldauer < 120;

--3. Lassen Sie sich nun eine Liste mit Filmtitel und den Namen der Regisseure
--ausgeben.
SELECT F.Titel, B.Name, B.Vorname FROM Film F JOIN Beteiligte B ON F.Regisseur = B.PersID;

--4. Wie viele Filme gibt es vom Regisseur "George Lucas"?
SELECT count(*) AS Anzahl FROM Film F JOIN Beteiligte B ON F.Regisseur = B.PersID WHERE B.name = 'Lucas';

--5. Wir wollen eine Liste mit den Namen aller Schauspielern und der Anzahl der Filme
--in denen Sie mitgespielt haben. Annahme: der Name der Schauspieler ist
--eindeutig.
SELECT B.PersID, B.name, count(F.*) FROM Beteiligte B JOIN SpieltIn F ON B.PersID = F.Schauspieler GROUP BY B.PersID, B.name;

--6. Wir wollen für alle verfügbaren Filmtitel die durchschnittliche Bewertung sehen.
--Die Liste soll nach durchschnittlicher Bewertung absteigend sortiert sein.
SELECT F.Titel, avg(KS.Bewertung) AS Durchschnitt FROM Film F JOIN KundeSchaut KS ON F.FilmID = KS.Film GROUP BY F.Titel ORDER BY Durchschnitt DESC;

--7. Jetzt wollen wir eine Liste mit den Filmtiteln, deren durchschnittliche Bewertung
-->4.5 ist.
SELECT F.Titel, avg(KS.Bewertung) AS Durchschnitt FROM Film F JOIN KundeSchaut KS ON F.FilmID = KS.Film GROUP BY F.Titel HAVING avg(KS.Bewertung) > 4.5 ORDER BY Durchschnitt DESC;

--8. Welche Schauspieler spielen in den Filmen mit, die der Kunde "Thomas Mueller"
--bereits angeschaut hat?
SELECT B.PersID, B.name, B.vorname
FROM Film F JOIN SpieltIn SI ON F.FilmID = SI.FilmID JOIN Beteiligte B ON SI.Schauspieler = B.PersID JOIN KundeSchaut KS ON F.FilmID = KS.Film JOIN Kunde K ON KS.Kunde = K.KdId
WHERE K.name = 'Mueller' AND K.vorname = 'Thomas';

--9. Peter Lustig hat einige Filme auf seiner Watchlist. Einige davon hat er aber schon
--gesehen und noch nicht von seiner Watchlist gelöscht. Welche Filme stehen auf
--der Watchlist von Peter Lustig, welche er noch nicht gesehen hat?


--10. Welcher Film (FilmID oder Filmtitel) wurde von den Kunden am häufigsten
--angeschaut?
