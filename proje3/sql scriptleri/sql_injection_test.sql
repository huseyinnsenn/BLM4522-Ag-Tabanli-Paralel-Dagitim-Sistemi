-- GÜVENSİZ FONKSİYON (Injection'a açık)
CREATE OR REPLACE FUNCTION guvensiz_arama(aranan_isim TEXT) 
RETURNS TABLE(first_name VARCHAR, last_name VARCHAR) AS $$
BEGIN
    RETURN QUERY EXECUTE 'SELECT first_name, last_name FROM customer WHERE first_name = ''' || aranan_isim || '''';
END;
$$ LANGUAGE plpgsql;

-- GÜVENLİ FONKSİYON (Parametrik - Injection'a kapalı)
CREATE OR REPLACE FUNCTION guvenli_arama(aranan_isim TEXT) 
RETURNS TABLE(first_name VARCHAR, last_name VARCHAR) AS $$
BEGIN
    RETURN QUERY EXECUTE 'SELECT first_name, last_name FROM customer WHERE first_name = $1' USING aranan_isim;
END;
$$ LANGUAGE plpgsql;

-- SQL Injection Saldırı Testleri
-- 1. Saldırı: Tüm veriyi sızdırır
SELECT * FROM guvensiz_arama('Jared'' OR ''1''=''1'::text);

-- 2. Koruma: Zararlı metni sıradan bir string olarak algılar, veri sızdırmaz
SELECT * FROM guvenli_arama('Jared'' OR ''1''=''1'::text);