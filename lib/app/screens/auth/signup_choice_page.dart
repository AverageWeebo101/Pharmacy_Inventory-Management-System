import 'package:flutter/material.dart';
import 'pharmacy_search_page.dart';

class SignUpChoicePage extends StatelessWidget {
  void _navigateToNewPharmacy(BuildContext context) {
    Navigator.pushNamed(context, '/newPharmacy'); // Placeholder route
  }

  void _navigateToExistingPharmacy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PharmacySearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Options'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      constraints.maxWidth < 600 ? constraints.maxWidth : 600,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        'assets/logo.png',
                        width: constraints.maxWidth * 0.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Are you signing up to add a new pharmacy or register as an employee of an existing pharmacy?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _navigateToNewPharmacy(context),
                      child: Text('Add New Pharmacy'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _navigateToExistingPharmacy(context),
                      child: Text('Register as Employee for Existing Pharmacy'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
