from app import app
from flask import (
    flash, redirect, render_template, request, url_for
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
    print(form)

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
    records = []
    if function:
        show = True
        
        if function == '1':
            names = ['Typ', 'Produkt', 'Ilość', 'Cena']
            records= myselect("SELECT * from Mag;")

        if function == '2':
            names = ['ID', 'Typ części']
            records= myselect("SELECT * FROM TypCzesci;")

        if function == '3':
            names = ['ID', 'Imię', 'Nazwisko', 'Stanowisko', 'Średni czas realizacji (dni)']
            records= myselect("SELECT * FROM czasZamowienia;")    

        if function == '4':
            names = ['ID', 'Imię', 'Nazwisko', 'Stanowisko']
            records= myselect("SELECT * from dostepniMonterzy;")

        if function == '5':
            names = ['ID']
            records= myselect("SELECT * from nieprzypisaneZamowienia;")

    return render_template('data.html', records=records, names=names, show=show)