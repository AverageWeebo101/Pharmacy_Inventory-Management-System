import 'package:flutter/material.dart';
import 'package:cse7l_finalproject/databases/tables/initialize_pharmacy_database.dart';

class PharmacySignUpPage extends StatefulWidget {
  @override
  _PharmacySignUpPageState createState() => _PharmacySignUpPageState();
}

class _PharmacySignUpPageState extends State<PharmacySignUpPage> {
  final _nameController = TextEditingController();
  final _businessPermitNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();
  bool _agreedToTerms = false;
  String? _generatedAuthCode;

  Future<void> _registerPharmacy() async {
    if (_agreedToTerms) {
      // Initialize database helper
      final dbHelper = PharmacyDatabaseHelper.instance;
      final pharmacyId = DateTime.now().millisecondsSinceEpoch.toString();
      final db = await dbHelper.createPharmacyDatabase(pharmacyId);

      // Generate a unique authorization code
      _generatedAuthCode = await dbHelper.generateUniqueAuthorizationCode(db);

      // Insert pharmacy data into the new database
      await db.insert('Pharmacy', {
        'pharmacy_id': pharmacyId,
        'name': _nameController.text,
        'business_permit_number': _businessPermitNumberController.text,
        'business_permit_date_issued': DateTime.now().toString(),
        'full_address': _addressController.text,
        'email': _emailController.text,
        'contact_number': _contactNumberController.text,
        'pharmacy_unique_authorization_code': _generatedAuthCode,
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pharmacy registered successfully!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please agree to the Terms of Service.')));
    }
  }

  void _showTermsOfService() {
    Navigator.pushNamed(context, '/tos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register New Pharmacy')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      constraints.maxWidth < 600 ? constraints.maxWidth : 600,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                          controller: _nameController,
                          decoration:
                              InputDecoration(labelText: 'Pharmacy Name')),
                      TextField(
                          controller: _businessPermitNumberController,
                          decoration: InputDecoration(
                              labelText: 'Business Permit Number')),
                      TextField(
                          controller: _addressController,
                          decoration:
                              InputDecoration(labelText: 'Full Address')),
                      TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email')),
                      TextField(
                          controller: _contactNumberController,
                          decoration:
                              InputDecoration(labelText: 'Contact Number')),
                      CheckboxListTile(
                        title: Row(
                          children: [
                            Text('I agree to the '),
                            GestureDetector(
                              onTap: _showTermsOfService,
                              child: Text('Terms of Service',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                        value: _agreedToTerms,
                        onChanged: (value) {
                          setState(() => _agreedToTerms = value ?? false);
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _registerPharmacy,
                        child: Text('Register Pharmacy'),
                      ),
                      if (_generatedAuthCode != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child:
                              Text('Authorization Code: $_generatedAuthCode'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
