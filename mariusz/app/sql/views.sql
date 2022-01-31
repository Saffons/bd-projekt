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
OR replace VIEW magazyn AS 
SELECT 
  t.typczesci, 
  cz.nazwa, 
  SUM(d.ilosc)- SUM(DISTINCT z.ilosc) AS ilosc,
  cz.cena 
FROM 
  dostawaczesci d, 
  zuzyteczesci z, 
  czesc cz, 
  zamowienie zam, 
  typczesci t 
WHERE 
  (
    d.czesc_idczesc = z.czesc_idczesc 
    AND cz.idczesc = z.czesc_idczesc 
    AND zam.idzamowienie = z.zamowienie_idzamowienie 
    AND t.idtypczesci = cz.typczesci_idtypczesci
  ) 
GROUP BY 
  t.typczesci, 
  cz.nazwa,
  cz.cena 
ORDER BY 
  t.typczesci;


---------------------
CREATE 
OR replace VIEW magazyn2 AS
SELECT
  t.typczesci, 
  cz.nazwa, 
  SUM(DISTINCT d.ilosc) AS ilosc,
  cz.cena  
FROM 
  dostawaczesci d, zuzyteczesci z, czesc cz, typczesci t 
WHERE
  (
  	d.czesc_idczesc NOT IN (SELECT z.czesc_idczesc FROM zuzyteczesci z)
AND cz.typczesci_idtypczesci = t.idtypczesci
AND cz.idczesc = d.czesc_idczesc
  )
GROUP BY 
  t.typczesci, 
  cz.nazwa,
  cz.cena 
ORDER BY 
  t.typczesci;

---------------------

CREATE 
OR replace VIEW Mag AS 
SELECT 
  * 
FROM 
  magazyn 
UNION 
SELECT 
  * 
FROM 
  magazyn2
ORDER BY 
  typczesci;

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