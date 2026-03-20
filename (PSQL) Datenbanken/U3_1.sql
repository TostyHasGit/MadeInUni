CREATE TABLE studierende(
    vorname varchar,
    name varchar,
    matnr INT
);

INSERT INTO studierende VALUES('Susi', 'Sinnlos', 4711);
INSERT INTO studierende VALUES('Rudi', 'Ratlos', 0815);
INSERT INTO studierende VALUES('Kathi', 'Schauß', 2911);
INSERT INTO studierende VALUES('Toni', 'Vendra', 1208);

SELECT * FROM studierende;

DROP TABLE studierende