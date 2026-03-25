# Expo-DB-System

**Kurum:** Kocaeli Üniversitesi  
**Bölüm:** Bilişim Sistemleri Mühendisliği  
**Ders:** TBL331 Veritabanı Yönetim Sistemleri (2025-2026 Bahar)  
**Grup No:99** 241307043 Meryem Özübek-231307028 Ülkü Hatip

---

## 📝 Problem Tanımı
Büyük ölçekli fuar ve konferans organizasyonlarında; katılımcı takibi, stand doluluk oranları, oturum çakışmaları ve biletleme süreçlerinin manuel yönetilmesi veri tutarsızlığına yol açmaktadır. Bu proje, etkinlik süreçlerini normalize edilmiş bir veritabanı yapısıyla optimize etmeyi, karmaşık sorguları View ve Procedure yapılarıyla basitleştirmeyi amaçlar.

## 🛠️ Yazılım Mimarisi ve Geliştirme Ortamı
- **Veritabanı:** PostgreSQL / MS SQL Server (Hangisini seçtiyseniz yazın)
- **Arayüz:** C# Desktop / Python Desktop (Eğer yapacaksanız belirtin)
- **Modelleme:** LucidChart / draw.io (ER Diyagramı için)

## 📊 Veritabanı Tasarımı (ER Diyagramı)
[Buraya ER Diyagramı görselinizi ekleyin]
*Sistem, 5N (Normalizasyon) kurallarına uygun olarak tasarlanmış minimum 5 ana tablodan oluşmaktadır.*

## ⚙️ Teknik Özellikler & İş Mantığı
Proje kapsamında aşağıdaki SQL objeleri aktif olarak kullanılmıştır:

* **Stored Procedures:** Yeni katılımcı kaydı ve bilet satış işlemleri için atomik yapılar.
* **Triggers:** Stand kapasitesi dolduğunda yeni kaydı engelleyen veya bilet iptalinde log tutan tetikleyiciler.
* **Views:** Popüler oturumlar ve doluluk oranlarını gösteren yönetici raporları.
* **Indexes:** Katılımcı TC/Email ve Etkinlik tarihlerinde hızlı arama için optimize edilmiş indeksler.

## 🚀 Projenin Kurulumu
1. `scripts/grupno_sql_betikleri.txt` dosyasındaki SQL komutlarını veritabanı yönetim sisteminizde çalıştırın.
2. Dummy dataların yüklendiğinden emin olun (Her tabloda min. 10 veri).
3. [Varsa uygulama kodunuzu çalıştırın].

## 📑 Yapılan Araştırmalar ve Akış Şeması
Geliştirme sürecinde özellikle Normalizasyon (1NF - 5NF) süreçleri ve SQL kısıtlayıcıları (Check, Unique) üzerinde durulmuştur. Algoritma akış şeması `docs/` klasöründe yer almaktadır.

## 🔗 Referanslar
1. Silberschatz, A., Korth, H. F., & Sudarshan, S. (2019). Database System Concepts.
2. [Diğer web kaynakları veya kütüphaneler]
