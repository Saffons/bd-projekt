DROP TABLE IF EXISTS Stanowisko CASCADE;
CREATE TABLE Stanowisko (
  idStanowisko SERIAL NOT NULL,
  opis VARCHAR NOT NULL,
  zarobki NUMERIC NOT NULL,
  PRIMARY KEY(idStanowisko)
);

INSERT INTO Stanowisko(opis, zarobki) VALUES ('prezes', 10000);
INSERT INTO Stanowisko(opis, zarobki) VALUES ('monter', 5000);
INSERT INTO Stanowisko(opis, zarobki) VALUES ('magazynier', 4000);
INSERT INTO Stanowisko(opis, zarobki) VALUES ('sprzatacz', 3000);
INSERT INTO Stanowisko(opis, zarobki) VALUES ('starszy monter', 6200);


DROP TABLE IF EXISTS TypCzesci CASCADE;
CREATE TABLE TypCzesci (
  idTypCzesci SERIAL NOT NULL,
  typCzesci VARCHAR NOT NULL,
  PRIMARY KEY(idTypCzesci)
);

INSERT INTO TypCzesci(typCzesci) VALUES ('Procesor');
INSERT INTO TypCzesci(typCzesci) VALUES ('Karta graficzna');
INSERT INTO TypCzesci(typCzesci) VALUES ('Plyta główna');
INSERT INTO TypCzesci(typCzesci) VALUES ('Dysk HDD');
INSERT INTO TypCzesci(typCzesci) VALUES ('Dysk SSD');
INSERT INTO TypCzesci(typCzesci) VALUES ('Zasilacz');
INSERT INTO TypCzesci(typCzesci) VALUES ('Pamiec RAM');


DROP TABLE IF EXISTS Uzytkownik CASCADE;
CREATE TABLE Uzytkownik (
  email VARCHAR NOT NULL,
  isAdmin BOOL NOT NULL,
  haslo VARCHAR NOT NULL,
  PRIMARY KEY(email)
);

INSERT INTO Uzytkownik(email, isAdmin, haslo) VALUES ('mariusz@gmail.com', true, 'haslo');
INSERT INTO Uzytkownik(email, isAdmin, haslo) VALUES ('pracownik@gmail.com', false, 'haslo');
INSERT INTO Uzytkownik(email, isAdmin, haslo) VALUES ('prezes@gmail.com', true, 'haslo');


DROP TABLE IF EXISTS Klient CASCADE;
CREATE TABLE Klient (
  idKlient SERIAL NOT NULL,
  imie VARCHAR NOT NULL,
  nazwisko VARCHAR NOT NULL,
  adres VARCHAR,
  PRIMARY KEY(idKlient)
);

INSERT INTO Klient(imie, nazwisko, adres) VALUES ('Adam', 'Kliencki', 'Jarzynowa 29, Krakow');
INSERT INTO Klient(imie, nazwisko, adres) VALUES ('Ela', 'Klient', 'Pomidorowa 92, Krakow');
INSERT INTO Klient(imie, nazwisko, adres) VALUES ('Jan', 'Nowak', 'Rosolska 16, Nowy Sacz');

DROP TABLE IF EXISTS Dostawca CASCADE;
CREATE TABLE Dostawca (
  idDostawca SERIAL NOT NULL,
  nazwaFirmy VARCHAR NOT NULL,
  siedziba VARCHAR,
  PRIMARY KEY(idDostawca)
);

INSERT INTO Dostawca(nazwaFirmy, siedziba) VALUES ('x-kom', 'Siedzibowa 12, Warszawa');
INSERT INTO Dostawca(nazwaFirmy, siedziba) VALUES ('Morele', 'Komputerowa 1a, Krakow');
INSERT INTO Dostawca(nazwaFirmy, siedziba) VALUES ('Komputronik', 'Wierzbowa 82, Olsztyn');

DROP TABLE IF EXISTS Czesc CASCADE;
CREATE TABLE Czesc (
  idCzesc SERIAL NOT NULL,
  TypCzesci_idTypCzesci INTEGER NOT NULL,
  nazwa VARCHAR,
  cena NUMERIC,
  PRIMARY KEY(idCzesc),
  FOREIGN KEY(TypCzesci_idTypCzesci)
  REFERENCES TypCzesci(idTypCzesci)
);

INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (1, 'AMD Ryzen 5 3600', 799);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (1, 'AMD Ryzen 5 5600X', 1399);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (1, 'Intel Core i9 11900K', 1999);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (2, 'AMD Radeon 6700XT', 3999);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (2, 'AMD Radeon 5700', 2399);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (2, 'NVidia GeForce RTX 3080', 5599);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (2, 'NVidia GeForce RTX 2060', 2149);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (3, 'ASUS Prime X570-P', 699);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (3, 'Gigabyte X570 Aorus Elite', 1299);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (3, 'MSI Z390-A PRO', 619);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (4, 'Seagate Barracuda 1TB', 199);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (4, 'WD Blue 1TB', 189);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (5, 'ADATA XPG SX8200 Pro 1TB', 499);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (5, 'Crucial P1 1TB', 429);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (6, 'Corsair CV 550W', 249);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (6, 'be quiet! Pure Power 11 600W', 399);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (7, 'HyperX 2x8GB 3200MHz Fury', 389);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (7, 'Corsair Vengeance 2x8GB 3000MHz', 319);
INSERT INTO Czesc(TypCzesci_idTypCzesci, nazwa, cena) VALUES (7, 'G-Skill Ripjaws V 2x16GB 3600MHz', 849);



-- CREATE INDEX typCzesci ON Czesc (TypCzesci_idTypCzesci);
CREATE INDEX IFK_Rel_03 ON Czesc (TypCzesci_idTypCzesci);

DROP TABLE IF EXISTS Zamowienie CASCADE;
CREATE TABLE Zamowienie (
  idZamowienie SERIAL NOT NULL,
  Klient_idKlient INTEGER NOT NULL,
  PRIMARY KEY(idZamowienie, Klient_idKlient),
  FOREIGN KEY(Klient_idKlient)
  REFERENCES Klient(idKlient)
);

INSERT INTO Zamowienie(Klient_idKlient) VALUES (1);
INSERT INTO Zamowienie(Klient_idKlient) VALUES (3);

CREATE INDEX Zamowienie_FKIndex1 ON Zamowienie (Klient_idKlient);
CREATE INDEX IFK_Rel_08 ON Zamowienie (Klient_idKlient);

DROP TABLE IF EXISTS Pracownik CASCADE;
CREATE TABLE Pracownik (
  idPracownik SERIAL NOT NULL,
  Stanowisko_idStanowisko INTEGER NOT NULL,
  imie VARCHAR,
  nazwisko VARCHAR,
  adres VARCHAR,
  telefon INTEGER,
  mail VARCHAR,
  PRIMARY KEY(idPracownik, Stanowisko_idStanowisko),
  FOREIGN KEY(Stanowisko_idStanowisko)
  REFERENCES Stanowisko(idStanowisko)
);

INSERT INTO Pracownik(Stanowisko_idStanowisko, imie, nazwisko, adres, telefon, mail) VALUES (1, 'Pawel', 'Prezesowski', 'Podwawelska 72, Krakow', 997, 'prezesowski@gmail.com');
INSERT INTO Pracownik(Stanowisko_idStanowisko, imie, nazwisko, adres, telefon, mail) VALUES (2, 'Jan', 'Monterski', 'Podwawelska 22, Krakow', 998, 'monterski@gmail.com');
INSERT INTO Pracownik(Stanowisko_idStanowisko, imie, nazwisko, adres, telefon, mail) VALUES (3, 'Joanna', 'Magazynska', 'Polska 28, Zamosc', 999, 'magazynska@gmail.com');
INSERT INTO Pracownik(Stanowisko_idStanowisko, imie, nazwisko, adres, telefon, mail) VALUES (5, 'Wladyslaw', 'Staromonterski', 'Kolejowa 2, Wloszczowa', 997, 'staromonterski@gmail.com');

CREATE INDEX idStanowisko ON Pracownik (Stanowisko_idStanowisko);
CREATE INDEX IFK_Rel_06 ON Pracownik (Stanowisko_idStanowisko);

DROP TABLE IF EXISTS ZuzyteCzesci CASCADE;
CREATE TABLE ZuzyteCzesci (
  Zamowienie_idZamowienie INTEGER NOT NULL,
  Czesc_idCzesc INTEGER NOT NULL,
  Zamowienie_Klient_idKlient INTEGER NOT NULL,
  ilosc INTEGER,
  PRIMARY KEY(Zamowienie_idZamowienie, Czesc_idCzesc, Zamowienie_Klient_idKlient),
  FOREIGN KEY(Zamowienie_idZamowienie, Zamowienie_Klient_idKlient)
    REFERENCES Zamowienie(idZamowienie, Klient_idKlient),
  FOREIGN KEY(Czesc_idCzesc)
    REFERENCES Czesc(idCzesc)
);

CREATE INDEX idZamowienie ON ZuzyteCzesci (Zamowienie_idZamowienie, Zamowienie_Klient_idKlient);
CREATE INDEX idCzesc ON ZuzyteCzesci (Czesc_idCzesc);

CREATE INDEX IFK_Rel_01 ON ZuzyteCzesci (Zamowienie_idZamowienie, Zamowienie_Klient_idKlient);
CREATE INDEX IFK_Rel_02 ON ZuzyteCzesci (Czesc_idCzesc);

DROP TABLE IF EXISTS Zlozenie CASCADE;
CREATE TABLE Zlozenie (
  idZlozenie SERIAL NOT NULL,
  Pracownik_Stanowisko_idStanowisko INTEGER NOT NULL,
  Pracownik_idPracownik INTEGER NOT NULL,
  Zamowienie_Klient_idKlient INTEGER NOT NULL,
  Zamowienie_idZamowienie INTEGER NOT NULL,
  dataZlozenia DATE,
  cenaZlozenia NUMERIC,
PRIMARY KEY(idZlozenie, Pracownik_Stanowisko_idStanowisko, Pracownik_idPracownik, Zamowienie_Klient_idKlient, Zamowienie_idZamowienie)    ,
  FOREIGN KEY(Pracownik_idPracownik, Pracownik_Stanowisko_idStanowisko)
    REFERENCES Pracownik(idPracownik, Stanowisko_idStanowisko),
  FOREIGN KEY(Zamowienie_idZamowienie, Zamowienie_Klient_idKlient)
    REFERENCES Zamowienie(idZamowienie, Klient_idKlient)
);

CREATE INDEX Zlozenie_FKIndex1 ON Zlozenie (Pracownik_idPracownik, Pracownik_Stanowisko_idStanowisko);
CREATE INDEX Zlozenie_FKIndex2 ON Zlozenie (Zamowienie_idZamowienie, Zamowienie_Klient_idKlient);

CREATE INDEX IFK_Rel_07 ON Zlozenie (Pracownik_idPracownik, Pracownik_Stanowisko_idStanowisko);
CREATE INDEX IFK_Rel_09 ON Zlozenie (Zamowienie_idZamowienie, Zamowienie_Klient_idKlient);


DROP TABLE IF EXISTS DostawaCzesci CASCADE;
CREATE TABLE DostawaCzesci (
  Czesc_idCzesc INTEGER NOT NULL,
  Dostawca_idDostawca INTEGER NOT NULL,
  ilosc INTEGER,
PRIMARY KEY(Czesc_idCzesc, Dostawca_idDostawca),
  FOREIGN KEY(Czesc_idCzesc)
    REFERENCES Czesc(idCzesc),
  FOREIGN KEY(Dostawca_idDostawca)
    REFERENCES Dostawca(idDostawca)
);

CREATE INDEX Czesc_has_Dostawca_FKIndex1 ON DostawaCzesci (Czesc_idCzesc);
CREATE INDEX Czesc_has_Dostawca_FKIndex2 ON DostawaCzesci (Dostawca_idDostawca);

CREATE INDEX IFK_Rel_04 ON DostawaCzesci (Czesc_idCzesc);
CREATE INDEX IFK_Rel_05 ON DostawaCzesci (Dostawca_idDostawca);


