import os
import urllib.parse as up
import psycopg2
from app.form import *

DB_URL = "postgres://kuxlvvxm:rtkBrOqu57r2iYqEwkbWMJ6-okvNCYOU@abul.db.elephantsql.com:5432/kuxlvvxm"

def execute_command(what):
    try:
        conn = psycopg2.connect(DB_URL)
        with conn:
            with conn.cursor() as cursor:
                cursor.execute(f"{what};")
    except (Exception, psycopg2.Error) as error:
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        conn.close()
        print("conn closed")



def myselect(what):
    try:
        conn = psycopg2.connect(DB_URL)
        with conn:
            with conn.cursor() as cursor:
                cursor.execute(f"{what};")
                records = cursor.fetchall()
        return records
    except (Exception, psycopg2.Error) as error:
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        conn.close()
        print("conn closed")

def select_all(table):
    try:
        conn = psycopg2.connect(DB_URL)
        with conn:
            with conn.cursor() as cursor:
                cursor.execute(f"SELECT * from {table};")
                records = cursor.fetchall()
        return records
    except (Exception, psycopg2.Error) as error:
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        conn.close()
        print("conn closed")
        
def is_filled(data):
   if data == None:
      return False
   if data == '':
      return False
   if data == []:
      return False
   if data == 0:
      return False
   return True

def insert(table, form):
    names = []
    values = []
    for field in form:
        if is_filled(field.data) and field.name not in ["submit","csrf_token"]:
            names.append(field.name)
            values.append("'" + str(field.data) + "'")
    names = ",".join(names)
    values = ",".join(values)
    #print(names)
    #print(values)
    try:
        conn = psycopg2.connect(DB_URL)
        with conn:
            with conn.cursor() as cursor:
                cursor.execute(f"INSERT INTO {table}({names}) VALUES ({values});")
    except (Exception, psycopg2.Error) as error:
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        conn.close()
        print("conn closed")

def Forms_tuple():
    Forms = {
        "Stanowisko":Stanowisko(),
        "TypCzesci":TypCzesci(),
        "Uzytkownik":Uzytkownik(),
        "Klient":Klient(),
        "Dostawca":Dostawca(),
        "Czesc":Czesc(),
        "Pracownik":Pracownik(),
        "ZuzyteCzesci":ZuzyteCzesci(),
        "Zlozenie":Zlozenie(),
        "DostawaCzesci":DostawaCzesci()
    }
    return Forms

def handling_forms(form, form_name):
    if form_name == "Czesc":
        tmp = select_all("TypCzesci")
        form.TypCzesci_idTypCzesci.choices= [(row[0],f"id: {row[0]} ; {row[1]}") for row in tmp]

    if form_name == "wyrok_wieznia":
        tmp = select_all("wyrok")
        form.id_wyrok.choices= [(row[0],f"id: {row[0]} ; nazwa: {row[1]}") for row in tmp]
        tmp = select_all("wiezien")
        form.id_wiezien.choices= [(row[0],f"id: {row[0]} ; imie: {row[1]}; nazwisko: {row[2]}") for row in tmp]

    if form_name == "wiezien":
        tmp = select_all("cela")
        form.id_cela.choices= [(row[0],f"id: {row[0]} ; id bloku:{row[1]}; numer: {row[2]}") for row in tmp]

    if form_name == "praca_wieznia":
        tmp = select_all("wiezien")
        form.id_wiezien.choices= [(row[0],f"id: {row[0]} ; imie: {row[1]}; nazwisko: {row[2]}") for row in tmp]
        tmp = select_all("praca")
        form.id_praca.choices= [(row[0],f"id: {row[0]} ; opis: {row[1]}") for row in tmp]
    
    if form_name == "cela":
        tmp = select_all("blok")
        form.id_blok.choices= [(row[0],f"id: {row[0]} ; id bloku: {row[1]}") for row in tmp]

    if form_name == "pomieszczenie":
        tmp = select_all("blok")
        form.id_blok.choices= [(row[0],f"id: {row[0]} ; nazwa bloku: {row[1]}") for row in tmp]
    
    if form_name == "pracownik":
        tmp = select_all("zawod")
        form.id_zawod.choices= [(row[0],f"id: {row[0]} ; opis: {row[1]}") for row in tmp]
        tmp = select_all("zmiana")
        form.id_zmiana.choices= [(row[0],f"id: {row[0]} ; nazwa: {row[1]}") for row in tmp]
        tmp = select_all("pomieszczenie")
        form.id_pomieszczenie.choices = [(0,'brak')]+[(row[0],f"id: {row[0]} ; id bloku: {row[1]}; numer: {row[2]}") for row in tmp]