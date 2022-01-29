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
            names = ['id_pracownik','imie','nazwisko','zmiana','stanowisko']
            records= myselect("SELECT p.id_pracownik, p.imie, p.nazwisko, zm.nazwa, za.opis FROM pracownik p JOIN zawod za on p.id_zawod=za.id_zawod JOIN zmiana zm on zm.id_zmiana=p.id_zmiana")

        if function == '2':
            names = ['id_zmiana', 'nazwa', 'liczba pracowników']
            records= myselect("SELECT z.id_zmiana, z.nazwa, COUNT(p.id_pracownik) as c FROM zmiana z JOIN pracownik p on z.id_zmiana=p.id_zmiana GROUP BY z.id_zmiana ORDER BY z.id_zmiana")

        if function == '3':
            names = ['nazwa bloku', 'numer celi']
            #execute_command("CREATE OR REPLACE VIEW view1 AS SELECT c.id_cela as id_cela, c.numer as numer, b.id_blok as id_blok, b.nazwa as nazwa FROM cela c JOIN blok b on b.id_blok=c.id_blok")
            records= myselect("SELECT nazwa, numer FROM view1")    
        
        if function == '4':
            names = ['praca', 'imie wieźnia', 'nazwisko']
            #execute_command("CREATE OR REPLACE VIEW view2 AS SELECT p.id_praca as id_praca, p.opis as opis, w.id_wiezien as id_wiezien,w.imie as imie, w.nazwisko as nazwisko FROM wiezien w JOIN praca_wieznia pw on w.id_wiezien=pw.id_wiezien JOIN praca p on pw.id_praca=p.id_praca")
            records= myselect("SELECT opis, imie, nazwisko FROM view2 ORDER BY opis")
        
        if function == '5':
            names = ['wyrok', 'imie wieźnia', 'nazwisko']
            #execute_command("CREATE OR REPLACE VIEW view3 AS SELECT w.id_wyrok as id_wyrok, w.nazwa as nazwa, wi.id_wiezien as id_wiezien, wi.imie as imie, wi.nazwisko as nazwisko FROM wyrok w JOIN wyrok_wieznia ww on w.id_wyrok=ww.id_wyrok JOIN wiezien wi on ww.id_wiezien=wi.id_wiezien")
            records= myselect("SELECT nazwa, imie, nazwisko FROM view3 ORDER BY nazwa")
    
        if function == '6':
            names = ['data', 'imie wizytatora', 'nazwisko wizytatora','imie wieznia', 'nazwisko wieznia']
            records= myselect("SELECT data, imie, nazwisko, wiezien_imie, wiezien_nazwisko FROM view4 ORDER BY data")

    return render_template('data.html', records=records, names=names, show=show)