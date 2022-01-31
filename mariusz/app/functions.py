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
    try:
        conn = psycopg2.connect(DB_URL)
        with conn:
            with conn.cursor() as cursor:
                cursor.execute(f"INSERT INTO {table}({names}) VALUES ({values});")
    except (Exception, psycopg2.Error) as error:
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        conn.close()

def Forms_tuple():
    Forms = {
        "Stanowisko":Stanowisko(),
        "TypCzesci":TypCzesci(),
        "Klient":Klient(),
        "Dostawca":Dostawca(),
        "Czesc":Czesc(),
        "Zamowienie":Zamowienie(),
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

    if form_name == "Zamowienie":
        tmp = select_all("Klient")
        form.Klient_idKlient.choices= [(row[0],f"id: {row[0]} ; {row[1]}") for row in tmp]

    if form_name == "Pracownik":
        tmp = select_all("Stanowisko")
        form.Stanowisko_idStanowisko.choices = [(row[0],f"id: {row[0]} ; {row[1]}") for row in tmp]

    if form_name == "ZuzyteCzesci":
        tmp = select_all("Zamowienie")
        form.Zamowienie_idZamowienie.choices= [(row[0],f"id: {row[0]}") for row in tmp]
        tmp = select_all("Czesc")
        form.Czesc_idCzesc.choices= [(row[0],f"id: {row[0]} ; nazwa: {row[2]}") for row in tmp]

    if form_name == "Zlozenie":
        tmp = select_all("dostepniMonterzy")
        form.Pracownik_idPracownik.choices = [(row[0],f"id: {row[0]} ; stopien montera: {row[2]}") for row in tmp]
        tmp = select_all("nieprzypisaneZamowienia")
        form.Zamowienie_idZamowienie.choices = [(row[0],f"id: {row[0]}") for row in tmp]

    if form_name == "DostawaCzesci":
        tmp = select_all("Czesc")
        form.Czesc_idCzesc.choices= [(row[0],f"id: {row[0]} ; {row[2]}") for row in tmp]
        tmp = select_all("Dostawca")
        form.Dostawca_idDostawca.choices= [(row[0],f"id: {row[0]} ; nazwa: {row[1]}") for row in tmp]