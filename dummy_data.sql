-- ============================================================================
-- FUAR VE KONFERANS ORGANİZASYON OTOMASYONU
-- GÜNCELLENMİŞ KESİN DUMMY DATA (TEST VERİLERİ) SETİ
-- ============================================================================

-- Önce eski test verilerini temizleyelim (Tabloları sıfırlayalım)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE kayitlar;
TRUNCATE TABLE oturumlar;
TRUNCATE TABLE katilimcilar;
TRUNCATE TABLE konusmacılar;
TRUNCATE TABLE etkinlikler;
TRUNCATE TABLE etkinlik_turleri;
TRUNCATE TABLE salonlar;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. SALONLAR TABLOSU (10 Kayıt)
INSERT INTO salonlar (salon_id, salon_adi, kapasite) VALUES
(1, 'Mimar Sinan Salonu', 500),
(2, 'Atatürk Konferans Salonu', 300),
(3, 'Gazi Amfisi', 150),
(4, 'Mavi Salon', 100),
(5, 'Kırmızı Salon', 80),
(6, 'Yeşil Oda', 50),
(7, 'Kocaeli VIP Salon', 40),
(8, 'Bilişim Lab-1', 60),
(9, 'Mühendislik Amfisi', 200),
(10, 'Teknopark Konferans Odası', 75);

-- 2. ETKİNLİK TÜRLERİ TABLOSU (10 Kayıt)
INSERT INTO etkinlik_turleri (idetkinlik_turleri, tur_adi) VALUES
(1, 'Uluslararası Kongre'),
(2, 'Yazılım Zirvesi'),
(3, 'Akademik Sempozyum'),
(4, 'Kariyer Günleri'),
(5, 'Teknoloji Fuarı'),
(6, 'Girişimcilik Paneli'),
(7, 'Bilişim Çalıştayı'),
(8, 'Yapay Zeka Semineri'),
(9, 'Siber Güvenlik Kampı'),
(10, 'Blockchain Zirvesi');

-- 3. ETKİNLİKLER TABLOSU (10 Kayıt)
INSERT INTO etkinlikler (idetkinlikler, etkinlik_adi, baslangic_tarihi, bitis_tarihi, tur_id) VALUES
(1, 'Uluslararası Bilişim Fuarı', '2026-06-01', '2026-06-05', 5),
(2, 'Kocaeli Yazılım Günleri', '2026-06-10', '2026-06-12', 2),
(3, 'Yapay Zeka ve Sağlık Zirvesi', '2026-06-15', '2026-06-17', 8),
(4, 'KOÜ Kariyer Şenliği', '2026-06-20', '2026-06-22', 4),
(5, 'Siber Savunma Kongresi', '2026-07-01', '2026-07-03', 9),
(6, 'Girişimcilik ve İnovasyon', '2026-07-05', '2026-07-06', 6),
(7, 'Big Data Sempozyumu', '2026-07-10', '2026-07-12', 3),
(8, 'Bulut Bilişim Günleri', '2026-07-15', '2026-07-16', 7),
(9, 'Web3 & Blockchain Zirvesi', '2026-07-20', '2026-07-22', 10),
(10, 'Endüstri 4.0 Kongresi', '2026-08-01', '2026-08-03', 1);

-- 4. KONUŞMACILAR TABLOSU (10 Kayıt - Şemanızda telefon olmadığı için kaldırıldı!)
INSERT INTO konusmacılar (konusmaci_id, ad_soyad, uzmanlık_alanı, eposta) VALUES
(1, 'Prof. Dr. Ahmet Yılmaz', 'Yapay Zeka ve Derin Öğrenme', 'ahmet.yilmaz@email.com'),
(2, 'Dr. Elif Kaya', 'Büyük Veri Analitiği', 'elif.kaya@email.com'),
(3, 'Caner Demir', 'Mikroservis Mimarisi ve Docker', 'caner.demir@email.com'),
(4, 'Zeynep Çelik', 'Siber Güvenlik ve Sızma Testleri', 'zeynep.celik@email.com'),
(5, 'Murat Şahin', 'Blockchain ve Akıllı Sözleşmeler', 'murat.sahin@email.com'),
(6, 'Dr. Aslı Arslan', 'Medikal Yapay Zeka ve Görüntü İşleme', 'asli.arslan@email.com'),
(7, 'Mehmet Öz', 'Cloud Computing ve AWS', 'mehmet.oz@email.com'),
(8, 'Selin Öztürk', 'UI/UX Tasarım İlkeleri', 'selin.ozturk@email.com'),
(9, 'Gökhan Doğan', 'Veritabanı Normalizasyonu ve SQL Optimization', 'gokhan.dogan@email.com'),
(10, 'Ece Yıldırım', 'Agile ve Scrum Proje Yönetimi', 'ece.yildirim@email.com');

-- 5. OTURUMLAR TABLOSU (10 Kayıt)
INSERT INTO oturumlar (idoturumlar, konu, baslangic_saati, bitis_saati, salon_id, etkinlik_id, konusmaci_id) VALUES
(1, 'Görüntü İşleme ile Felç Tespiti', '2026-06-15 10:00:00', '2026-06-15 12:00:00', 1, 3, 6),
(2, 'Spring Boot ile Mikroservis Geliştirme', '2026-06-10 13:00:00', '2026-06-10 15:00:00', 2, 2, 3),
(3, 'SQL Server Performans İpuçları', '2026-06-02 09:30:00', '2026-06-02 11:30:00', 3, 1, 9),
(4, 'Sağlıkta Yapay Zeka ve MedGemma', '2026-06-16 14:00:00', '2026-06-16 16:00:00', 1, 3, 1),
(5, 'Siber Tehdit İstihbaratı Eğitimi', '2026-07-01 11:00:00', '2026-07-01 13:00:00', 4, 5, 4),
(6, 'Ethereum Ağında Akıllı Sözleşme Yazımı', '2026-07-21 15:00:00', '2026-07-21 17:00:00', 5, 9, 5),
(7, 'Docker ve Kubernetes Temelleri', '2026-06-11 10:00:00', '2026-06-11 12:00:00', 2, 2, 3),
(8, 'Hadoop ve Spark ile Büyük Veri Yönetimi', '2026-07-11 13:30:00', '2026-07-11 15:30:00', 9, 7, 2),
(9, 'Büyük Şirketlerde Teknik Mülakat Süreçleri', '2026-06-21 11:00:00', '2026-06-21 12:30:00', 10, 4, 10),
(10, 'Kurumsal Şirketlerde AWS Kullanımı', '2026-07-15 14:00:00', '2026-07-15 16:00:00', 8, 8, 7);

-- 6. KATILIMCILAR TABLOSU (10 Kayıt - Şemanızda telefon var, aynen kalıyor!)
INSERT INTO katilimcilar (katilimci_id, ad_soyad, eposta, telefon) VALUES
(1, 'Ali Yılmaz', 'ali.yilmaz@student.com', '0533 123 4567'),
(2, 'Ayşe Kaya', 'ayse.kaya@email.com', '0544 234 5678'),
(3, 'Fatma Demir', 'fatma.demir@email.com', '0505 345 6789'),
(4, 'Mustafa Çelik', 'mustafa.celik@student.com', '0555 456 7890'),
(5, 'Emre Şahin', 'emre.sahin@email.com', '0532 567 8901'),
(6, 'İrem Arslan', 'irem.arslan@email.com', '0541 678 9012'),
(7, 'Burak Öz', 'burak.oz@student.com', '0506 789 0123'),
(8, 'Gamze Öztürk', 'gamze.ozturk@email.com', '0535 890 1234'),
(9, 'Deniz Doğan', 'deniz.dogan@email.com', '0542 901 2345'),
(10, 'Merve Yıldırım', 'merve.yildirim@student.com', '0537 012 3456');

-- 7. KAYITLAR TABLOSU (10 Kayıt)
INSERT INTO kayitlar (idkayitlar, katilimci_id, oturum_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 5, 3),
(6, 6, 4),
(7, 7, 4),
(8, 8, 5),
(9, 9, 7),
(10, 10, 9);