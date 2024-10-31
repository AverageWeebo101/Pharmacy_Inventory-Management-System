CREATE TABLE Pharmacy (
    pharmacy_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255),
    business_permit_number VARCHAR(20) NOT NULL UNIQUE,
    business_permit_date_issued DATE NOT NULL,
    full_address TEXT NOT NULL,
    email VARCHAR(255),
    contact_number VARCHAR(15),
    owner_pharmacist_id VARCHAR(10),  
    pharmacy_unique_authorization_code CHAR(10) UNIQUE NOT NULL
);

CREATE INDEX idx_pharmacy_authorization_code ON Pharmacy (pharmacy_unique_authorization_code);


CREATE TRIGGER after_pharmacy_delete
AFTER DELETE ON Pharmacy
FOR EACH ROW
INSERT INTO Decommissioned_Authorization_Codes (auth_code)
VALUES (OLD.pharmacy_unique_authorization_code);
