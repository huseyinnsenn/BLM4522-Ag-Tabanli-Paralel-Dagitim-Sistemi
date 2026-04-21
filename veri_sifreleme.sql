-- Kriptografi eklentisinin aktif edilmesi
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Hassas veri için binary kolon eklenmesi
ALTER TABLE customer ADD COLUMN gizli_kart_bilgisi BYTEA;

-- Verinin PGP simetrik şifreleme ile yazılması
UPDATE customer 
SET gizli_kart_bilgisi = PGP_SYM_ENCRYPT('4532-1111-2222-3333', 'ProjeIcinGizliAnahtar') 
WHERE customer_id = 1;

-- Şifrelenmiş verinin okunma testi (Bu sorgu anlamsız binary veri döndürür)
SELECT first_name, last_name, gizli_kart_bilgisi 
FROM customer 
WHERE customer_id = 1;

-- Şifrenin uygulama katmanında çözülerek düz metin olarak okunması
SELECT 
    first_name, 
    last_name, 
    PGP_SYM_DECRYPT(gizli_kart_bilgisi, 'ProjeIcinGizliAnahtar') AS cozulen_kart_bilgisi 
FROM customer 
WHERE customer_id = 1;