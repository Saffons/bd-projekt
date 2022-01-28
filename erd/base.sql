CREATE TABLE Stanowisko (
  idStanowisko SERIAL  NOT NULL ,
  opis VARCHAR    ,
  zarobki NUMERIC      ,
PRIMARY KEY(idStanowisko));




CREATE TABLE TypCzesci (
  idTypCzesci SERIAL  NOT NULL ,
  typCzesci VARCHAR      ,
PRIMARY KEY(idTypCzesci));




CREATE TABLE Uzytkownik (
  email SERIAL  NOT NULL ,
  isAdmin BOOL    ,
  haslo VARCHAR      ,
PRIMARY KEY(email));




CREATE TABLE Klient (
  idKlient SERIAL  NOT NULL ,
  imie VARCHAR    ,
  nazwisko VARCHAR    ,
  adres VARCHAR      ,
PRIMARY KEY(idKlient));




CREATE TABLE Dostawca (
  idDostawca SERIAL  NOT NULL ,
  nazwaFirmy VARCHAR    ,
  siedziba VARCHAR      ,
PRIMARY KEY(idDostawca));




CREATE TABLE Czesc (
  idCzesc SERIAL  NOT NULL ,
  TypCzesci_idTypCzesci INTEGER   NOT NULL ,
  nazwa VARCHAR    ,
  cena NUMERIC      ,
PRIMARY KEY(idCzesc)  ,
  FOREIGN KEY(TypCzesci_idTypCzesci)
    REFERENCES TypCzesci(idTypCzesci));


CREATE INDEX typCzesci ON Czesc (TypCzesci_idTypCzesci);


CREATE INDEX IFK_Rel_03 ON Czesc (TypCzesci_idTypCzesci);


CREATE TABLE Zamowienie (
  idZamowienie SERIAL  NOT NULL ,
  Klient_idKlient INTEGER   NOT NULL   ,
PRIMARY KEY(idZamowienie, Klient_idKlient)  ,
  FOREIGN KEY(Klient_idKlient)
    REFERENCES Klient(idKlient));


CREATE INDEX Zamowienie_FKIndex1 ON Zamowienie (Klient_idKlient);


CREATE INDEX IFK_Rel_08 ON Zamowienie (Klient_idKlient);


CREATE TABLE Pracownik (
  idPracownik SERIAL  NOT NULL ,
  Stanowisko_idStanowisko INTEGER   NOT NULL ,
  imie VARCHAR    ,
  nazwisko VARCHAR    ,
  adres VARCHAR    ,
  telefon INTEGER    ,
  mail VARCHAR      ,
PRIMARY KEY(idPracownik, Stanowisko_idStanowisko)  ,
  FOREIGN KEY(Stanowisko_idStanowisko)
    REFERENCES Stanowisko(idStanowisko));


CREATE INDEX idStanowisko ON Pracownik (Stanowisko_idStanowisko);


CREATE INDEX IFK_Rel_06 ON Pracownik (Stanowisko_idStanowisko);


CREATE TABLE ZuzyteCzesci (
  Zamowienie_idZamowienie INTEGER   NOT NULL ,
  Czesc_idCzesc INTEGER   NOT NULL ,
  Zamowienie_Klient_idKlient INTEGER   NOT NULL ,
  ilosc INTEGER      ,
PRIMARY KEY(Zamowienie_idZamowienie, Czesc_idCzesc, Zamowienie_Klient_idKlient)    ,
  FOREIGN KEY(Zamowienie_idZamowienie, Zamowienie_Klient_idKlient)
    REFERENCES Zamowienie(idZamowienie, Klient_idKlient),
  FOREIGN KEY(Czesc_idCzesc)
    REFERENCES Czesc(idCzesc));


CREATE INDEX idZamowienie ON ZuzyteCzesci (Zamowienie_idZamowienie, Zamowienie_Klient_idKlient);
CREATE INDEX idCzesc ON ZuzyteCzesci (Czesc_idCzesc);


CREATE INDEX IFK_Rel_01 ON ZuzyteCzesci (Zamowienie_idZamowienie, Zamowienie_Klient_idKlient);
CREATE INDEX IFK_Rel_02 ON ZuzyteCzesci (Czesc_idCzesc);


CREATE TABLE Zlozenie (
  idZlozenie SERIAL  NOT NULL ,
  Pracownik_Stanowisko_idStanowisko INTEGER   NOT NULL ,
  Pracownik_idPracownik INTEGER   NOT NULL ,
  Zamowienie_Klient_idKlient INTEGER   NOT NULL ,
  Zamowienie_idZamowienie INTEGER   NOT NULL ,
  dataZlozenia DATE    ,
  cenaZlozenia NUMERIC      ,
PRIMARY KEY(idZlozenie, Pracownik_Stanowisko_idStanowisko, Pracownik_idPracownik, Zamowienie_Klient_idKlient, Zamowienie_idZamowienie)    ,
  FOREIGN KEY(Pracownik_idPracownik, Pracownik_Stanowisko_idStanowisko)
    REFERENCES Pracownik(idPracownik, Stanowisko_idStanowisko),
  FOREIGN KEY(Zamowienie_idZamowienie, Zamowienie_Klient_idKlient)
    REFERENCES Zamowienie(idZamowienie, Klient_idKlient));


CREATE INDEX Zlozenie_FKIndex1 ON Zlozenie (Pracownik_idPracownik, Pracownik_Stanowisko_idStanowisko);
CREATE INDEX Zlozenie_FKIndex2 ON Zlozenie (Zamowienie_idZamowienie, Zamowienie_Klient_idKlient);


CREATE INDEX IFK_Rel_07 ON Zlozenie (Pracownik_idPracownik, Pracownik_Stanowisko_idStanowisko);
CREATE INDEX IFK_Rel_09 ON Zlozenie (Zamowienie_idZamowienie, Zamowienie_Klient_idKlient);


CREATE TABLE DostawaCzesci (
  Czesc_idCzesc INTEGER   NOT NULL ,
  Dostawca_idDostawca INTEGER   NOT NULL ,
  ilosc INTEGER      ,
PRIMARY KEY(Czesc_idCzesc, Dostawca_idDostawca)    ,
  FOREIGN KEY(Czesc_idCzesc)
    REFERENCES Czesc(idCzesc),
  FOREIGN KEY(Dostawca_idDostawca)
    REFERENCES Dostawca(idDostawca));


CREATE INDEX Czesc_has_Dostawca_FKIndex1 ON DostawaCzesci (Czesc_idCzesc);
CREATE INDEX Czesc_has_Dostawca_FKIndex2 ON DostawaCzesci (Dostawca_idDostawca);


CREATE INDEX IFK_Rel_04 ON DostawaCzesci (Czesc_idCzesc);
CREATE INDEX IFK_Rel_05 ON DostawaCzesci (Dostawca_idDostawca);


