-- ============================================================================
-- FUAR VE KONFERANS ORGANİZASYON OTOMASYONU
-- VIEW YAPILARI - Raporlama Görünümleri
-- ============================================================================

-- VIEW 1: Detaylı Etkinlik Programı Raporu
-- Amaç: Hangi oturumun hangi etkinlik, salon ve konuşmacı ile ilişkili olduğunu
--       tek bir yerden görmek için kapsamlı rapor görünümü
DROP VIEW IF EXISTS vw_detayli_etkinlik_programi;

CREATE VIEW vw_detayli_etkinlik_programi AS
SELECT 
    o.idoturumlar AS oturum_id,
    o.konu AS oturum_konusu,
    o.baslangic_saati,
    o.bitis_saati,
    e.idetkinlikler AS etkinlik_id,
    e.etkinlik_adi,
    e.baslangic_tarihi AS etkinlik_baslangic,
    e.bitis_tarihi AS etkinlik_bitis,
    et.tur_adi AS etkinlik_turu,
    s.salon_id,
    s.salon_adi,
    s.kapasite AS salon_kapasitesi,
    k.konusmaci_id,
    k.ad_soyad AS konusmaci_adi,
    k.uzmanlik_alani,
    k.eposta AS konusmaci_eposta
FROM oturumlar o
INNER JOIN etkinlikler e ON o.etkinlik_id = e.idetkinlikler
INNER JOIN etkinlik_turleri et ON e.tur_id = et.idetkinlik_turleri
INNER JOIN salonlar s ON o.salon_id = s.salon_id
INNER JOIN konusmacilar k ON o.konusmaci_id = k.konusmaci_id
ORDER BY e.baslangic_tarihi, o.baslangic_saati;


-- VIEW 2: Oturum Doluluk Analizi Raporu
-- Amaç: Her oturum için salon kapasitesi ve mevcut kayıt sayısını karşılaştırarak
--       doluluk oranını analiz etmek
DROP VIEW IF EXISTS vw_oturum_doluluk_analizi;

CREATE VIEW vw_oturum_doluluk_analizi AS
SELECT 
    o.idoturumlar AS oturum_id,
    o.konu AS oturum_konusu,
    o.baslangic_saati,
    o.bitis_saati,
    e.etkinlik_adi,
    s.salon_id,
    s.salon_adi,
    s.kapasite AS salon_kapasitesi,
    COUNT(ky.idkayitlar) AS kayitli_katilimci_sayisi,
    (s.kapasite - COUNT(ky.idkayitlar)) AS kalan_kontenjan,
    ROUND((COUNT(ky.idkayitlar) / s.kapasite * 100), 2) AS doluluk_orani_yuzde
FROM oturumlar o
INNER JOIN etkinlikler e ON o.etkinlik_id = e.idetkinlikler
INNER JOIN salonlar s ON o.salon_id = s.salon_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
GROUP BY 
    o.idoturumlar, o.konu, o.baslangic_saati, o.bitis_saati,
    e.etkinlik_adi, s.salon_id, s.salon_adi, s.kapasite
ORDER BY doluluk_orani_yuzde DESC;


-- VIEW 3: Popüler Oturumlar (Yüksek Katılım)
-- Amaç: En çok katılımcının kayıt olduğu oturumları görüntüle
DROP VIEW IF EXISTS vw_populer_oturumlar;

CREATE VIEW vw_populer_oturumlar AS
SELECT 
    o.idoturumlar,
    o.konu,
    e.etkinlik_adi,
    k.ad_soyad AS konusmaci_adi,
    COUNT(ky.idkayitlar) AS katilimci_sayisi,
    s.kapasite,
    ROUND((COUNT(ky.idkayitlar) / s.kapasite * 100), 2) AS doluluk_yuzde
FROM oturumlar o
INNER JOIN etkinlikler e ON o.etkinlik_id = e.idetkinlikler
INNER JOIN konusmacilar k ON o.konusmaci_id = k.konusmaci_id
INNER JOIN salonlar s ON o.salon_id = s.salon_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
GROUP BY o.idoturumlar, o.konu, e.etkinlik_adi, k.ad_soyad, s.kapasite
HAVING COUNT(ky.idkayitlar) > 0
ORDER BY katilimci_sayisi DESC;


-- VIEW 4: Boş Oturumlar (Kayıt Olmayan)
-- Amaç: Hiç katılımcı olmayan oturumları belirle ve pazarlama kampanyası başlat
DROP VIEW IF EXISTS vw_bos_oturumlar;

CREATE VIEW vw_bos_oturumlar AS
SELECT 
    o.idoturumlar,
    o.konu,
    o.baslangic_saati,
    o.bitis_saati,
    e.etkinlik_adi,
    et.tur_adi,
    k.ad_soyad AS konusmaci,
    s.salon_adi,
    s.kapasite
FROM oturumlar o
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
INNER JOIN etkinlikler e ON o.etkinlik_id = e.idetkinlikler
INNER JOIN etkinlik_turleri et ON e.tur_id = et.idetkinlik_turleri
INNER JOIN konusmacilar k ON o.konusmaci_id = k.konusmaci_id
INNER JOIN salonlar s ON o.salon_id = s.salon_id
WHERE ky.idkayitlar IS NULL
ORDER BY o.baslangic_saati;


-- VIEW 5: Konuşmacı Başarı Raporu
-- Amaç: Konuşmacıların oturum sayısı ve toplam katılımcı rakamlarını göster
DROP VIEW IF EXISTS vw_konusmaci_basarisi;

CREATE VIEW vw_konusmaci_basarisi AS
SELECT 
    k.konusmaci_id,
    k.ad_soyad,
    k.uzmanlik_alani,
    COUNT(DISTINCT o.idoturumlar) AS oturum_sayisi,
    COUNT(ky.idkayitlar) AS toplam_katilimci,
    ROUND(AVG(COUNT(ky.idkayitlar)), 2) AS ort_katilimci_oturum_basina
FROM konusmacilar k
LEFT JOIN oturumlar o ON k.konusmaci_id = o.konusmaci_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
GROUP BY k.konusmaci_id, k.ad_soyad, k.uzmanlik_alani
ORDER BY toplam_katilimci DESC;


-- ============================================================================
-- VIEW TEST SORGULAARI
-- ============================================================================

-- TEST 1: Detaylı Etkinlik Programı Görüntüle
SELECT * FROM vw_detayli_etkinlik_programi 
LIMIT 5;

-- TEST 2: Oturum Doluluk Analizi - En Dolu Oturumlar
SELECT * FROM vw_oturum_doluluk_analizi 
WHERE doluluk_orani_yuzde >= 50
ORDER BY doluluk_orani_yuzde DESC;

-- TEST 3: Popüler Oturumlar (Kayıt Olmuş Katılımcılar)
SELECT * FROM vw_populer_oturumlar 
LIMIT 10;

-- TEST 4: Boş Oturumlar (Pazarlama Hedefi)
SELECT * FROM vw_bos_oturumlar;

-- TEST 5: Konuşmacı Başarı Raporu - Top 5
SELECT TOP 5 * FROM vw_konusmaci_basarisi 
ORDER BY toplam_katilimci DESC;

-- TEST 6: Belirli Etkinlik Türüne Ait Oturum Bilgileri
SELECT 
    CONCAT('Toplam İçerik: ', COUNT(DISTINCT idoturumlar)) AS etkinlik_ozeti,
    CONCAT('Toplam Konuşmacı: ', COUNT(DISTINCT konusmaci_id)) AS konusmaci_bilgisi
FROM vw_detayli_etkinlik_programi
WHERE etkinlik_turu = 'Konferans';

-- TEST 7: Salon Kullanım İstatistikleri
SELECT 
    salon_adi,
    COUNT(idoturumlar) AS oturum_sayisi,
    SUM(kayitli_katilimci_sayisi) AS toplam_katilimci
FROM vw_oturum_doluluk_analizi
GROUP BY salon_adi
ORDER BY toplam_katilimci DESC;