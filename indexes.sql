-- ============================================================================
-- FUAR VE KONFERANS ORGANİZASYON OTOMASYONU
-- INDEX YAPILARI - Performans Optimizasyonu
-- ============================================================================

-- INDEX 1: Etkinlik tarihi aralığında arama yapılırken performans optimizasyonu
-- Kullanım Senaryosu: "Belirli tarihler arasındaki etkinlikleri listele" sorguları
CREATE INDEX idx_etkinlik_tarih_araligi 
ON etkinlikler(baslangic_tarihi, bitis_tarihi);

-- INDEX 2: Oturum saat aralığı ve salon bazlı sorgular için performans optimizasyonu
-- Kullanım Senaryosu: "Belirli bir salonda, belirli saat aralığındaki oturumları bul"
CREATE INDEX idx_oturum_salon_saat 
ON oturumlar(salon_id, baslangic_saati, bitis_saati);

-- INDEX 3: Katılımcı kayıt tarihi bazlı raporlama için optimizasyon
-- Kullanım Senaryosu: "Son 1 aydaki kayıtları listele" gibi zaman bazlı sorgular
CREATE INDEX idx_kayit_tarihi 
ON kayitlar(kayit_tarihi);

-- INDEX 4: Etkinlik türüne göre filtreleme için performans artışı
-- Kullanım Senaryosu: "Belirli bir türdeki tüm etkinlikleri listele"
CREATE INDEX idx_etkinlik_tur 
ON etkinlikler(tur_id);

-- INDEX 5: Katılımcı e-posta arama için hızlı lookup
-- Kullanım Senaryosu: "E-posta ile katılımcı bul" (Login, arama vb.)
CREATE INDEX idx_katilimci_eposta
ON katilimcilar(eposta);

-- INDEX 6: Kayıt - katılımcı FK araması optimizasyonu
-- Kullanım Senaryosu: "Belirli bir katılımcının tüm kayıtlarını bul"
CREATE INDEX idx_kayit_katilimci_oturum
ON kayitlar(katilimci_id, oturum_id);

-- INDEX 7: Oturum - etkinlik FK araması
-- Kullanım Senaryosu: "Belirli etkinliğin tüm oturumlarını bul"
CREATE INDEX idx_oturum_etkinlik
ON oturumlar(etkinlik_id);

-- INDEX 8: Oturum - konuşmacı FK araması
-- Kullanım Senaryosu: "Konuşmacının tüm oturumlarını bul"
CREATE INDEX idx_oturum_konusmaci
ON oturumlar(konusmaci_id);


-- ============================================================================
-- INDEX PERFORMANS TEST SORGULAARI (EXPLAIN ile)
-- ============================================================================

-- TEST 1: Belirli tarih aralığında etkinlikleri ara (INDEX: idx_etkinlik_tarih_araligi)
EXPLAIN SELECT * FROM etkinlikler 
WHERE baslangic_tarihi >= '2026-06-01' 
  AND bitis_tarihi <= '2026-06-30';

-- TEST 2: Belirli salonda belirli saatlerde oturumları ara (INDEX: idx_oturum_salon_saat)
EXPLAIN SELECT * FROM oturumlar 
WHERE salon_id = 1 
  AND baslangic_saati >= '2026-06-01 10:00:00'
  AND bitis_saati <= '2026-06-01 18:00:00';

-- TEST 3: Son ayın kayıtlarını liste (INDEX: idx_kayit_tarihi)
EXPLAIN SELECT * FROM kayitlar 
WHERE kayit_tarihi >= DATE_SUB(NOW(), INTERVAL 30 DAY);

-- TEST 4: Etkinlik türüne göre etkinlikleri filtrele (INDEX: idx_etkinlik_tur)
EXPLAIN SELECT * FROM etkinlikler 
WHERE tur_id = 1 
ORDER BY baslangic_tarihi DESC;

-- TEST 5: E-posta ile katılımcı ara (INDEX: idx_katilimci_eposta)
EXPLAIN SELECT * FROM katilimcilar 
WHERE eposta = 'caneraras@gmail.com';

-- TEST 6: Belirli katılımcının kayıtlarını ara (INDEX: idx_kayit_katilimci_oturum)
EXPLAIN SELECT k.*, ky.kayit_tarihi, o.konu FROM kayitlar ky
INNER JOIN katilimcilar k ON ky.katilimci_id = k.katilimci_id
INNER JOIN oturumlar o ON ky.oturum_id = o.idoturumlar
WHERE ky.katilimci_id = 1;

-- TEST 7: Belirli etkinliğin oturumlarını ara (INDEX: idx_oturum_etkinlik)
EXPLAIN SELECT * FROM oturumlar 
WHERE etkinlik_id = 1 
ORDER BY baslangic_saati;

-- TEST 8: Konuşmacının oturumlarını ara (INDEX: idx_oturum_konusmaci)
EXPLAIN SELECT o.*, k.ad_soyad FROM oturumlar o
INNER JOIN konusmacilar k ON o.konusmaci_id = k.konusmaci_id
WHERE o.konusmaci_id = 10;


-- ============================================================================
-- COMPLEX QUERY PERFORMANCE TESTS (Index Birlikte Çalışması)
-- ============================================================================

-- TEST 9: Join Performansı - Salon Doluluk Raporu (Birden Fazla Index Kullanımı)
EXPLAIN SELECT 
    s.salon_adi,
    COUNT(DISTINCT o.idoturumlar) AS oturum_sayisi,
    COUNT(ky.idkayitlar) AS kayitli_katilimci_sayisi,
    ROUND((COUNT(ky.idkayitlar) / s.kapasite * 100), 2) AS doluluk_yuzde
FROM salonlar s
LEFT JOIN oturumlar o ON s.salon_id = o.salon_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
GROUP BY s.salon_id, s.salon_adi, s.kapasite
HAVING COUNT(ky.idkayitlar) > 0
ORDER BY doluluk_yuzde DESC;

-- TEST 10: Date Range + FK Join (Etkinlik Döneminde Oturumlar)
EXPLAIN SELECT 
    e.etkinlik_adi,
    o.konu,
    o.baslangic_saati,
    COUNT(ky.idkayitlar) AS katilimci_sayisi
FROM etkinlikler e
INNER JOIN oturumlar o ON e.idetkinlikler = o.etkinlik_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
WHERE e.baslangic_tarihi >= '2026-06-01'
  AND e.bitis_tarihi <= '2026-06-30'
GROUP BY e.idetkinlikler, o.idoturumlar
ORDER BY e.baslangic_tarihi, o.baslangic_saati;


-- ============================================================================
-- ACTUAL QUERIES (Test Sonuçları)
-- ============================================================================

-- QUERY 1: Haziran Ayında En Popüler Oturumlar
SELECT 
    e.etkinlik_adi,
    o.konu,
    s.salon_adi,
    k.ad_soyad AS konusmaci,
    COUNT(ky.idkayitlar) AS katilimci,
    s.kapasite,
    ROUND((COUNT(ky.idkayitlar) / s.kapasite * 100), 2) AS doluluk_yuzde
FROM etkinlikler e
INNER JOIN oturumlar o ON e.idetkinlikler = o.etkinlik_id
INNER JOIN salonlar s ON o.salon_id = s.salon_id
INNER JOIN konusmacilar k ON o.konusmaci_id = k.konusmaci_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
WHERE MONTH(e.baslangic_tarihi) = 6
GROUP BY o.idoturumlar
ORDER BY katilimci DESC;

-- QUERY 2: Salon Kullanım Verimlilik Raporu
SELECT 
    s.salon_adi,
    s.kapasite,
    COUNT(DISTINCT o.idoturumlar) AS oturum_sayisi,
    COUNT(DISTINCT ky.idkayitlar) AS toplam_katilimci,
    ROUND((COUNT(DISTINCT ky.idkayitlar) / (s.kapasite * COUNT(DISTINCT o.idoturumlar)) * 100), 2) AS ort_doluluk
FROM salonlar s
LEFT JOIN oturumlar o ON s.salon_id = o.salon_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
GROUP BY s.salon_id
ORDER BY ort_doluluk DESC;

-- QUERY 3: Konuşmacı Performans Karşılaştırması
SELECT 
    k.ad_soyad,
    k.uzmanlik_alani,
    COUNT(DISTINCT o.idoturumlar) AS oturum_sayisi,
    COUNT(DISTINCT ky.idkayitlar) AS toplam_katilimci,
    MAX(COUNT(ky.idkayitlar)) OVER (PARTITION BY k.konusmaci_id) AS en_yuksek_katilim
FROM konusmacilar k
LEFT JOIN oturumlar o ON k.konusmaci_id = o.konusmaci_id
LEFT JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
GROUP BY k.konusmaci_id
ORDER BY toplam_katilimci DESC;