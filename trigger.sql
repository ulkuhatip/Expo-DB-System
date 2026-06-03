DROP TRIGGER IF EXISTS tg_konusmaci_zaman_cakismasi;

DELIMITER //

CREATE TRIGGER tg_konusmaci_zaman_cakismasi 
BEFORE INSERT ON oturumlar 
FOR EACH ROW 
BEGIN
    DECLARE v_cakisma_sayisi INT;
    
    -- Ayni konusmacinin, ayni saatler arasina denk gelen baska bir oturumu var mi bakiyoruz
    SELECT COUNT(*) INTO v_cakisma_sayisi
    FROM oturumlar
    WHERE konusmaci_id = NEW.konusmaci_id
      AND (
            (NEW.baslangic_saati >= baslangic_saati AND NEW.baslangic_saati < bitis_saati) OR
            (NEW.bitis_saati > baslangic_saati AND NEW.bitis_saati <= bitis_saati) OR
            (NEW.baslangic_saati <= baslangic_saati AND NEW.bitis_saati >= bitis_saati)
          );
          
    -- Eger cakisan bir oturum bulunduysa kayit islemini durduruyoruz
    IF v_cakisma_sayisi > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'HATA: Konusmacinin bu saat diliminde baska bir oturumu bulunmaktadir!';
    END IF;
END//

DELIMITER ;


DROP TRIGGER IF EXISTS tg_salon_kontenjan_kontrol;

DELIMITER //

CREATE TRIGGER tg_salon_kontenjan_kontrol 
BEFORE INSERT ON kayitlar 
FOR EACH ROW 
BEGIN
    DECLARE v_salon_kapasite INT;
    DECLARE v_mevcut_kayit_sayisi INT;
    
    -- 1. Ilgili oturumun yapilacagi salonun toplam kapasitesini aliyoruz
    SELECT s.kapasite INTO v_salon_kapasite
    FROM oturumlar o
    INNER JOIN salonlar s ON o.salon_id = s.salon_id
    WHERE o.idoturumlar = NEW.oturum_id;
    
    -- 2. O oturuma su ana kadar yapilmis toplam kayit sayisini buluyoruz
    SELECT COUNT(*) INTO v_mevcut_kayit_sayisi
    FROM kayitlar
    WHERE oturum_id = NEW.oturum_id;
    
    -- 3. Kontenjan dolmussa islemi iptal edip hata mesaji donduruyoruz
    IF v_mevcut_kayit_sayisi >= v_salon_kapasite THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'HATA: Bu oturumun yapilacagi salon tamamen dolmustur! Yeni kayit alinamaz.';
    END IF;
END//

DELIMITER ;