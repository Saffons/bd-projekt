from flask_wtf import FlaskForm
from wtforms import (
    StringField,
    SubmitField,
    BooleanField,
    IntegerField,
    DateField,
    SelectField,
)
from wtforms.validators import InputRequired

class Stanowisko(FlaskForm):
    #idStanowisko = SelectField("idStanowisko",coerce=int, validators=[InputRequired()])
    opis = StringField("Opis stanowiska", validators=[InputRequired()])
    zarobki = IntegerField("Zarobki", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class TypCzesci(FlaskForm): 
    #idTypCzesci = SelectField("idTypCzesci",coerce=int, validators=[InputRequired()])
    typCzesci = StringField("typCzesci", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class Uzytkownik(FlaskForm):
    email = StringField("email", validators=[InputRequired()])
    isAdmin = BooleanField("isAdmin", validators=[InputRequired()])
    haslo = StringField("haslo", validators=[InputRequired()])
    submit = SubmitField("Dodaj")


class Klient(FlaskForm):
    #idKlient = SelectField("idKlient",coerce=int, validators=[InputRequired()])
    imie = StringField("imie klienta", validators=[InputRequired()])
    nazwisko = StringField("nazwisko klienta", validators=[InputRequired()])
    adres = StringField("adres", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class Dostawca(FlaskForm):
    #idDostawca = SelectField("idDostawca",coerce=int, validators=[InputRequired()])
    nazwaFirmy = StringField("nazwa dostawcy", validators=[InputRequired()])
    siedziba = StringField("siedziba", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class Czesc(FlaskForm):
    #idCzesc = SelectField("idCzesc",coerce=int, validators=[InputRequired()])
    TypCzesci_idTypCzesci = SelectField("id typu czesci", coerce=int, validators=[InputRequired()])
    nazwa = StringField("nazwa czesci", validators=[InputRequired()])
    cena = IntegerField("cena czesci", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class Zamowienie(FlaskForm):
    #idZamowienie = SelectField("idZamowienie", coerce=int, validators=[InputRequired()])
    Klient_idKlient = SelectField("id klienta", coerce=int, validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class Pracownik(FlaskForm):
    #idPracownik = SelectField("idPracownik",coerce=int, validators=[InputRequired()])
    Stanowisko_idStanowisko = SelectField("id stanowiska", coerce=int, validators=[InputRequired()])
    imie = StringField("imie pracownika", validators=[InputRequired()])
    nazwisko = StringField("nazwisko pracownika", validators=[InputRequired()])
    adres = StringField("adres pracownika", validators=[InputRequired()])
    telefon = SelectField("telefon do pracownika",coerce=int, validators=[InputRequired()])
    mail = StringField("e-mail pracownika", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class ZuzyteCzesci(FlaskForm):
    Zamowienie_idZamowienie = SelectField("id zamowienie", coerce=int, validators=[InputRequired()])
    Czesc_idCzesc = SelectField("id czesci", coerce=int, validators=[InputRequired()])
    Zamowienie_Klient_idKlient = SelectField("id klienta", coerce=int, validators=[InputRequired()])
    ilosc = IntegerField("ilosc czesci", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class Zlozenie(FlaskForm):
    #idZlozenie = SelectField("id zlozenie", coerce=int, validators=[InputRequired()])
    #Pracownik_Stanowisko_idStanowisko = SelectField("id stanowiska pracownika", coerce=int, validators=[InputRequired()])
    Pracownik_idPracownik = SelectField("id pracownika", coerce=int, validators=[InputRequired()])
    #Zamowienie_Klient_idKlient = SelectField("id zamawiajacego", coerce=int, validators=[InputRequired()])
    Zamowienie_idZamowienie = SelectField("id zamowienia", coerce=int, validators=[InputRequired()])
    dataZlozenia = DateField("data zlozenia (rrrr-mm-dd)", validators=[InputRequired()])
    cenaZlozenia = IntegerField("cena zlozenia", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class DostawaCzesci(FlaskForm):
    Czesc_idCzesc = SelectField("id czesci", coerce=int, validators=[InputRequired()])
    Dostawca_idDostawca = SelectField("id dostawcy", coerce=int, validators=[InputRequired()])
    ilosc = SelectField("ilosc czesci", coerce=int, validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class select_table(FlaskForm):
    nazwa = SelectField("nazwa tabeli",coerce=str)
    submit = SubmitField("wybierz")