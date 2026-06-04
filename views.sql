-- ============================================================================
-- FUAR VE KONFERANS ORGANİZASYON OTOMASYONU
-- VIEW YAPILARI - Şemanızla %100 Birebir Eşitlenmiş Kod Seti
-- ============================================================================

-- VIEW 1: Detaylı Etkinlik Programı Raporu
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
    k.uzmanlık_alanı AS uzmanlik_alani, -- Datasetinizdeki gibi Türkçe
    k.eposta AS konusmaci_eposta
FROM oturumlar o
INNER JOIN etkinlikler e ON o.etkinlik_id = e.idetkinlikler
INNER JOIN etkinlik_turleri et ON e.tur_id = et.idetkinlik_turleri
INNER JOIN salonlar s ON o.salon_id = s.salon_id
INNER JOIN konusmacılar k ON o.konusmaci_id = k.konusmaci_id -- Datasetinizdeki gibi 'ı' ile!
ORDER BY e.baslangic_tarihi, o.baslangic_saati;


-- VIEW 2: Oturum Doluluk Analizi Raporu
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
INNER JOIN konusmacılar k ON o.konusmaci_id = k.konusmaci_id -- Datasetinizdeki gibi 'ı' ile!
INNER JOIN salonlar s ON o.salon_id = s.salon_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
GROUP BY o.idoturumlar, o.konu, e.etkinlik_adi, k.ad_soyad, s.kapasite
HAVING COUNT(ky.idkayitlar) > 0
ORDER BY katilimci_sayisi DESC;


-- VIEW 4: Boş Oturumlar (Kayıt Olmayan)
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
INNER JOIN konusmacılar k ON o.konusmaci_id = k.konusmaci_id -- Datasetinizdeki gibi 'ı' ile!
INNER JOIN salonlar s ON o.salon_id = s.salon_id
WHERE ky.idkayitlar IS NULL
ORDER BY o.baslangic_saati;


-- VIEW 5: Konuşmacı Başarı Raporu
DROP VIEW IF EXISTS vw_konusmaci_basarisi;

CREATE VIEW vw_konusmaci_basarisi AS
SELECT 
    k.konusmaci_id,
    k.ad_soyad,
    k.uzmanlık_alanı AS uzmanlik_alani, -- Datasetinizdeki gibi Türkçe
    COUNT(DISTINCT o.idoturumlar) AS oturum_sayisi,
    COUNT(ky.idkayitlar) AS toplam_katilimci,
    ROUND(
        IFNULL(COUNT(ky.idkayitlar) / NULLIF(COUNT(DISTINCT o.idoturumlar), 0), 0), 
        2
    ) AS ort_katilimci_oturum_basina
FROM konusmacılar k -- Datasetinizdeki gibi 'ı' ile!
LEFT JOIN oturumlar o ON k.konusmaci_id = o.konusmaci_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
GROUP BY k.konusmaci_id, k.ad_soyad, k.uzmanlık_alanı
ORDER BY toplam_katilimci DESC;