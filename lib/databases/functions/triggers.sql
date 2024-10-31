
CREATE TRIGGER before_pharmacist_update
BEFORE UPDATE ON Pharmacist
FOR EACH ROW
SET NEW.last_edited_date = CURRENT_TIMESTAMP;


DELIMITER //
CREATE FUNCTION CheckPermitExpiration()
RETURNS TRIGGER
BEGIN
    DECLARE days_to_expire INT;
    SET days_to_expire = DATEDIFF(STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-01-20'), '%Y-%m-%d'), CURDATE());
    IF days_to_expire <= 90 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = CONCAT('Warning: Business permit will expire in ', days_to_expire, ' days.');
    END IF;
    RETURN NEW;
END;
//
DELIMITER ;
