CREATE TABLE Decommissioned_Authorization_Codes (
    auth_code CHAR(10) PRIMARY KEY,
    decommissioned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
