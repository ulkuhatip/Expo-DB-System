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