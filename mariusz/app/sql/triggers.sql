CREATE OR REPLACE FUNCTION INSERT_Zam() 
RETURNS TRIGGER AS '
BEGIN
    IF TG_OP = ''INSERT'' THEN
        NEW.dataZamowienia := current_timestamp;
    END IF;
  RETURN NEW;
END;
' LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS INSERT_Zamowienie on Zamowienie;
CREATE TRIGGER INSERT_Zamowienie BEFORE INSERT ON Zamowienie
FOR EACH ROW EXECUTE PROCEDURE INSERT_Zam();

------------------------------------------------

CREATE OR REPLACE FUNCTION Insert_Mag() 
RETURNS TRIGGER
LANGUAGE plpgsql
AS '
DECLARE
	x int := NEW.ilosc;
BEGIN
		IF (NEW.Czesc_idCzesc NOT IN (select czesc_idczesc from Magazyn)) THEN
    		INSERT INTO Magazyn(Czesc_idCzesc, M_ilosc) VALUES (NEW.Czesc_idCzesc, NEW.ilosc) ;
		ELSE
			UPDATE Magazyn SET M_ilosc= M_ilosc+x  WHERE czesc_idczesc=NEW.Czesc_idczesc ;
		END IF;
	RETURN NEW;
END;
';


DROP TRIGGER insertM ON dostawaczesci;
CREATE TRIGGER insertM AFTER INSERT ON dostawaczesci
	FOR EACH ROW EXECUTE PROCEDURE Insert_Mag();  

------------------------------------------------

CREATE OR REPLACE FUNCTION ALTER_Mag() 
RETURNS TRIGGER
LANGUAGE plpgsql
AS '
DECLARE
	x int := NEW.ilosc;
	y int := (SELECT M_ilosc from Magazyn WHERE Czesc_idczesc=NEW.Czesc_idczesc);
BEGIN
	IF (y != x) THEN
		UPDATE Magazyn SET M_ilosc= M_ilosc-x WHERE Czesc_idczesc=NEW.Czesc_idczesc ;
	ELSE
		DELETE FROM Magazyn WHERE Czesc_idczesc=NEW.Czesc_idczesc;
	END IF;
RETURN NEW;

END;
';

DROP TRIGGER alterm ON zuzyteczesci;
CREATE TRIGGER alterM AFTER INSERT ON zuzyteczesci
    FOR EACH ROW EXECUTE PROCEDURE ALTER_Mag();  
