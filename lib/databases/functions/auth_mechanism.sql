
CREATE FUNCTION IsDecommissioned(auth_code CHAR(10))
RETURNS BOOLEAN
BEGIN
    RETURN EXISTS (SELECT 1 FROM Decommissioned_Authorization_Codes WHERE auth_code = auth_code);
END;
