from app import app
from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)

from app.form import *
from app.functions import *

@app.route('/')
def index():
    return render_template('index.html')

#creating form to add row into the table "form_name"
@app.route('/add/<form_name>', methods=["GET", "POST"])
def add(form_name):
    Forms = Forms_tuple()

    if form_name == 'none':
        return redirect(url_for('select_form', function='add'))
    
    #to be implemented
    form = Forms[form_name]

    handling_forms(form,form_name)
    if form.is_submitted():
        insert(form_name,form)
        flash('Dodanie powiodło się!')
        return redirect(url_for('index'))

    return render_template('form.html', form = form)

#printing table "form_name"
@app.route('/select/<form_name>', methods=["GET", "POST"])
def select(form_name):
    Forms = Forms_tuple()

    if form_name == 'none':
        return redirect(url_for('select_form', function='select'))
    
    form = Forms[form_name]
    records = select_all(form_name)

    return render_template('select.html', form = form, records= records)
    
#selecting table to add/select        
@app.route('/select_form/<function>', methods=["GET", "POST"])
def select_form(function):
    form = select_table()
    Forms= Forms_tuple()
    x = [key for key,value in Forms.items()]
    form.nazwa.choices = x
    if form.is_submitted():
        result = request.form['nazwa']
        return redirect(url_for(function, form_name=result))
    return render_template('form.html', form = form)

@app.route('/data', methods=["GET", "POST"])  
@app.route('/data/<function>', methods=["GET", "POST"])
def data(function=0):
    names = []
    show = False
    records =[]
    if function:
        show = True
        
        if function == '1':
            names = ['id_film','tytuł','reżyser','rok produkcji','wersja językowa', 'napisy', 'typ seansu', 'czas trwania', 'opis']
            records= myselect("SELECT * FROM Film")

        if function == '2':
            names = ['id_typ_biletu', 'typ biletu']
            records= myselect("SELECT * FROM TypBiletu")

        if function == '3':
            names = ['id_osoba_rezerwująca', 'imię', 'nazwisko', 'email', 'miejscowość', 'powiat', 'gmina', 'adres', 'PESEL', 'kod pocztowy', 'poczta']
            records= myselect("SELECT o.idosobarezerwujaca, o.imie, o.nazwisko, o.email, m.nazwa AS miejscowosc, m.powiat, m.gmina, o.adres, o.pesel, o.kodpocztowy, o.poczta  FROM osobarezerwujaca o JOIN miejscowosc m ON o.miejscowosc_idmiejscowosc=m.idmiejscowosc;")    
        
        if function == '4':
            names = ['tytuł', 'wersja językowa', 'napisy', 'typ seansu', 'czas trwania', 'data początku', 'data końca', 'godzina']
            records= myselect("SELECT f.tytulfilmu, f.wersjajezykowa, f.napisy, f.typseansu, f.czastrwania, r.datapoczatku, r.datakonca, r.godzina FROM repertuar r JOIN Film f ON r.film_idfilm=f.idfilm")
        
        if function == '5':
            names = ['id_rezerwacje', 'tytuł', 'godzina', 'data rezerwacji', 'cena', 'potwierdzenie']
            records= myselect("FROM rezerwacje rez JOIN repertuar r JOIN film f ON r.film_idfilm=f.idfilm ON rez.repertuar_idrepertuar=r.idrepertuar")
    
        if function == '6':
            names = ['id_sprzedaz', 'dataSprzedazy', 'cena']
            records= myselect("SELECT idsprzedaz, datasprzedazy, cena FROM sprzedaz")

    return render_template('data.html', records=records, names=names, show=show)