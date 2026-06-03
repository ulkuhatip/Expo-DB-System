DROP PROCEDURE IF EXISTS sp_en_populer_konusmacilar;

DELIMITER //

CREATE PROCEDURE sp_en_populer_konusmacilar(
    IN p_limit_sayisi INT
)
BEGIN
    SELECT 
        k.konusmaci_id,
        k.ad_soyad AS konusmaci_adi,
        COUNT(ky.idkayitlar) AS toplam_dinleyici_sayisi
    FROM konusmacilar k
    INNER JOIN oturumlar o ON k.konusmaci_id = o.konusmaci_id
    INNER JOIN kayitlar ky ON o.idoturumlar = ky.oturum_id
    GROUP BY k.konusmaci_id, k.ad_soyad
    ORDER BY toplam_dinleyici_sayisi DESC
    LIMIT p_limit_sayisi;
END//

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_hizli_katilimci_kayit;

DELIMITER //

CREATE PROCEDURE sp_hizli_katilimci_kayit(
    IN p_ad_soyad VARCHAR(100),
    IN p_eposta VARCHAR(100),
    IN p_telefon VARCHAR(15),
    IN p_oturum_id INT
)
BEGIN
    DECLARE v_katilimci_id INT;
    
    SELECT katilimci_id INTO v_katilimci_id
    FROM katilimcilar
    WHERE eposta = p_eposta;
    
    IF v_katilimci_id IS NULL THEN
        INSERT INTO katilimcilar (ad_soyad, eposta, telefon)
        VALUES (p_ad_soyad, p_eposta, p_telefon);
        SET v_katilimci_id = LAST_INSERT_ID();
    END IF;
    
    INSERT INTO kayitlar (katilimci_id, oturum_id)
    VALUES (v_katilimci_id, p_oturum_id);
END//

DELIMITER ;