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