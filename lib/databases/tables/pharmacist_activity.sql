CREATE TABLE Pharmacist_Activity (
    pharmacist_activity_id VARCHAR(10) PRIMARY KEY,
    pharmacist_id VARCHAR(10) REFERENCES Pharmacist(pharmacist_id) ON DELETE CASCADE,
    activity_id INT AUTO_INCREMENT,
    activity_description TEXT,
    activity_stamp_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (pharmacist_id, activity_id)
);
