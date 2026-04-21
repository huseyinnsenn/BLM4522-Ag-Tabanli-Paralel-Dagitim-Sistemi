-- Sadece okuma yapabilecek yeni bir rol (stajyer) oluşturulması
CREATE ROLE stajyer_raporcu WITH LOGIN PASSWORD 'GuvenliSifre2026!';
GRANT CONNECT ON DATABASE testdb TO stajyer_raporcu;
GRANT USAGE ON SCHEMA public TO stajyer_raporcu;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO stajyer_raporcu;

-- NOT: Test etmek için stajyer hesabıyla bağlanıp aşağıdaki komutu çalıştırdık
-- DELETE FROM customer;