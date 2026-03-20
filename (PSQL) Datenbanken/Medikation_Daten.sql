-- TESTDATEN

-- Patienten
INSERT INTO Patient VALUES  (1, 'Maier','Heinrich','1970-01-12','Heidelberg','Schroederstrasse 23') , 
                            (2, 'Mueller','Petra','1975-04-04','Mannheim','C3 4') , 
                            (3, 'Ziegler','Anne','1960-12-12','Heidelberg','Brueckenstrasse 4') , 
                            (4, 'Zuber','Marvin','1988-06-12','Heidelberg','Ladenburgerstr 22') , 
                            (5, 'Schmid','Lena','1988-01-01','Mannheim','John-Dree-Strasse 5') ,
                            (6, 'Schmid','Mira','1985-01-09','Karlsruhe','Hauptstrasse 23');

-- Ärzte
INSERT INTO Arzt VALUES     (1, 'Ziegler','Heidelberg','Moenchhofstrasse 33') , 
                            (2, 'Sahmid','Mannheim','Hauptstrasse 22') , 
                            (3, 'Choud','Heidelberg','Rohrbacherstrasse 77') , 
                            (4, 'Schnipsel','Karlsruhe','Bergallee 5') ,
                            (5, 'Nagel','Mannheim','Q2 2') ;

-- Apotheken
INSERT INTO Apotheke VALUES (1, 'Gesundheit','Heidelberg','Schroederstrasse 3') , 
                            (2, 'Hatschi','Mannheim','Hauptstrasse 119') , 
                            (3, 'Gute Besserung','Heidelberg','Bergstrasse 77') , 
                            (4, 'Gute Besserung','Karlsruhe','Untere Strasse 22') ;


-- Rezepte
INSERT INTO REZEPT VALUES   (1, '2020-03-01', 1,1,1),
                            (2, '2020-03-01', 1,3,1),
                            (3, '2020-03-03', 1,2,2),
                            (4, '2020-03-11', 2,2,2),
                            (5, '2020-03-01', 5,4,3),
                            (6, '2020-03-20', 2,2,2), -- Petra Ziegler war zweimal beim gleichen Arzt und in der gleichen Apotheke
                            (7, '2020-03-20', 4,1,1),
                            (8, '2020-03-20', 3,1,3);

-- Wirkstoff und Medikamente
INSERT INTO Wirkstoff VALUES    (1, 'Ibuprofen');
INSERT INTO Medikament VALUES   (1001,'Aktren'),
                                (1002,'Dolormin');
INSERT INTO MedikamentWirkstoff VALUES (1001,1),
                                       (1002,1);

INSERT INTO Wirkstoff VALUES    (2, 'Digoxin');
INSERT INTO Medikament VALUES   (2001,'Digacin'),
                                (2002,'Lanicor');
INSERT INTO MedikamentWirkstoff VALUES (2001,2),
                                       (2002,2);


INSERT INTO Wirkstoff VALUES    (3, 'Salbutamol');
INSERT INTO Medikament VALUES   (3001,'Apsolol'),
                                (3002,'Salbubronch');
INSERT INTO MedikamentWirkstoff VALUES (3001,3),
                                       (3002,3);


INSERT INTO Wirkstoff VALUES    (4, 'Diuretika');

INSERT INTO Wirkstoff VALUES    (5, 'Oxytocin');
INSERT INTO Medikament VALUES   (5001, 'Carbetocin'),
                                (5002, 'Pabal');
INSERT INTO MedikamentWirkstoff VALUES (5001,5),
                                       (5002,5);


INSERT INTO Wirkstoff VALUES    (6, 'Procarbazin');
INSERT INTO Medikament VALUES   (6001, 'Natulan');
INSERT INTO MedikamentWirkstoff VALUES (6001,6);


INSERT INTO Wirkstoff VALUES    (7,'Johanniskraut');
INSERT INTO Medikament VALUES   (7001, 'Laif 900 Balance');
INSERT INTO MedikamentWirkstoff VALUES (7001,7);

-- Wechselwirkungen
INSERT INTO WechselWirkung VALUES (2, 1, 'Serumspiegel kann sich erhöhen'); -- 'Digoxin' und 'Ibuprofen'
INSERT INTO WechselWirkung VALUES (3, 4, 'Risiko einer Hypokaliämie'); -- 'Salbutamol' und 'Diuretika',
INSERT INTO WechselWirkung VALUES (3, 6, 'Hypertonie'); -- 'Salbutamol'und 'Procarbazin',
INSERT INTO WechselWirkung VALUES (3, 5, 'veränderte Herz-Kreislauf-Regulation'); -- 'Salbutamol','Oxytocin'

-- Medikationen
INSERT INTO Medikation VALUES   (1, 1, 3001, 2, 2, 2), -- MedID, rezeptID, PZN, morgens, mittags, abends
                                (2, 1, 6001, 1, 1, 1),
                                (3, 2, 3002, 2, 2, 2),
                                (4, 3, 7001, 2, 0, 2),
                                (5, 4, 5002, 0, 0, 2),
                                (6, 5, 1002, 1, 1, 1),
                                (7, 6, 3001, 2, 2, 2),
                                (8, 7, 2001, 1, 0, 1),
                                (9, 8, 2002, 2, 2, 2);

