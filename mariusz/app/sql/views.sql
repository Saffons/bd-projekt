CREATE OR replace VIEW dostepniMonterzy AS
SELECT 
  DISTINCT p.idpracownik, 
  p.imie, 
  p.nazwisko, 
  s.opis 
FROM 
  pracownik p, 
  stanowisko s, 
  zlozenie z 
WHERE 
  s.idStanowisko = p.stanowisko_idstanowisko 
  AND s.idstanowisko IN (2, 5) 
  AND (
    (
      z.pracownik_idpracownik = p.idpracownik 
      AND CURRENT_TIMESTAMP >= ALL (
        SELECT 
          z.datazakonczenia 
        FROM 
          zlozenie z 
        WHERE 
          z.pracownik_idpracownik = p.idpracownik
      )
    ) 
    OR (
      p.idpracownik NOT IN (
        SELECT 
          pracownik_idpracownik 
        FROM 
          zlozenie z
      )
    )
  );

---------------------

CREATE 
OR replace VIEW nieprzypisaneZamowienia AS 
SELECT 
  distinct za.idzamowienie 
FROM 
  zamowienie za, 
  zlozenie zl 
WHERE 
  za.idzamowienie NOT IN (
    SELECT 
      zamowienie_idzamowienie 
    FROM 
      zlozenie
  );

---------------------
CREATE 
OR replace VIEW czasZamowienia AS 
SELECT 
  p.idpracownik AS ID, 
  p.imie, 
  p.nazwisko, 
  s.opis, 
  AVG (
    zl.datazakonczenia - zam.datazamowienia
  ) AS sredni_czas 
FROM 
  pracownik p, 
  stanowisko s, 
  zlozenie zl, 
  zamowienie zam 
WHERE 
  p.stanowisko_idstanowisko IN (2, 5) 
  AND p.stanowisko_idstanowisko = s.idstanowisko 
  AND zl.pracownik_idpracownik = p.idpracownik 
  AND zl.datazakonczenia IS NOT NULL 
GROUP BY 
  p.idpracownik, 
  p.imie, 
  s.opis 
ORDER BY 
  p.idpracownik;

--------------------------------------

CREATE OR REPLACE VIEW mag AS
  SELECT ma.Czesc_idCzesc, cz.nazwa , ma.M_ilosc FROM magazyn ma, czesc cz WHERE cz.idCzesc = ma.Czesc_idCzesc;

--------------------------------------

CREATE OR REPLACE VIEW mag_view AS
SELECT t.typczesci, cz.nazwa , ma.M_ilosc, cz.cena FROM magazyn ma, czesc cz, typczesci t WHERE cz.idCzesc = ma.Czesc_idCzesc AND t.idtypczesci=cz.typczesci_idtypczesci;
