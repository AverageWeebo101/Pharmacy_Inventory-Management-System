import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PharmacyDatabaseHelper {
  static final PharmacyDatabaseHelper instance =
      PharmacyDatabaseHelper._privateConstructor();

  PharmacyDatabaseHelper._privateConstructor();

  Future<Database> createPharmacyDatabase(String pharmacyId) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pharmacy_$pharmacyId.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
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
        ''');

        await db.execute('''
          CREATE TABLE Pharmacist (
              pharmacist_id VARCHAR(10) PRIMARY KEY,
              pharmacy_id VARCHAR(10),
              owner BOOLEAN DEFAULT FALSE NOT NULL,
              employee_status TEXT,
              license_num VARCHAR(15) UNIQUE NOT NULL,
              first_name VARCHAR(50) NOT NULL,
              last_name VARCHAR(50) NOT NULL,
              birthdate DATE NOT NULL,
              gender TEXT NOT NULL,
              home_address TEXT NOT NULL,
              current_residence TEXT NOT NULL,
              email VARCHAR(255) NOT NULL,
              contact_number VARCHAR(15) NOT NULL,
              created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
              last_edited_date TIMESTAMP DEFAULT 'N/A',
              last_login_date TIMESTAMP DEFAULT 'N/A'
          );
        ''');

        await db.execute('''
          CREATE TABLE Pharmacist_Activity (
              pharmacist_activity_id VARCHAR(10) PRIMARY KEY,
              pharmacist_id VARCHAR(10),
              activity_id INTEGER,
              activity_description TEXT,
              activity_stamp_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
              UNIQUE (pharmacist_id, activity_id)
          );
        ''');
      },
    );
  }

  Future<String> generateUniqueAuthorizationCode(Database db) async {
    final chars = '1234567890';
    Random rnd = Random();
    String authCode;
    List<Map<String, dynamic>> result;

    do {
      authCode =
          List.generate(10, (index) => chars[rnd.nextInt(chars.length)]).join();
      result = await db.query(
        'Pharmacy',
        where: 'pharmacy_unique_authorization_code = ?',
        whereArgs: [authCode],
      );
    } while (result.isNotEmpty);

    return authCode;
  }
}
