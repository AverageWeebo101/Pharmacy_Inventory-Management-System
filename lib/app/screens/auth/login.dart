import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _pharmacyIdController = TextEditingController();
  final _pharmacistIdController = TextEditingController();
  final _authCodeController = TextEditingController();
  String _errorMessage = '';
  int _loginAttempts = 0;

  void _validateAndLogin() {
    setState(() {
      _errorMessage = '';
    });

    if (_pharmacyIdController.text.isEmpty ||
        _pharmacistIdController.text.isEmpty ||
        _authCodeController.text.isEmpty) {
      setState(() {
        _errorMessage = 'All fields must be filled.';
      });
      return;
    }

    if (_pharmacyIdController.text != 'validPharmacyId' ||
        _pharmacistIdController.text != 'validPharmacistId' ||
        _authCodeController.text != 'validAuthCode') {
      setState(() {
        _errorMessage =
            'Pharmacy ID, Pharmacist ID, or Authorization Code is incorrect.';
        _loginAttempts++;
      });
    } else {
      Navigator.pushNamed(context, '/home');
    }
  }

  void _navigateToSignUp() {
    Navigator.pushNamed(context, '/signup_choice');
  }

  void _navigateToCustomerService() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CustomerServicePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    TextField(
                      controller: _pharmacyIdController,
                      decoration: InputDecoration(
                        labelText: 'Pharmacy ID',
                        errorText: _pharmacyIdController.text.isEmpty
                            ? 'Field cannot be empty'
                            : null,
                      ),
                    ),
                    TextField(
                      controller: _pharmacistIdController,
                      decoration: InputDecoration(
                        labelText: 'Pharmacist ID',
                        errorText: _pharmacistIdController.text.isEmpty
                            ? 'Field cannot be empty'
                            : null,
                      ),
                    ),
                    TextField(
                      controller: _authCodeController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Authorization Code',
                        errorText: _authCodeController.text.isEmpty
                            ? 'Field cannot be empty'
                            : null,
                      ),
                    ),
                    if (_errorMessage.isNotEmpty) ...[
                      SizedBox(height: 10),
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                    if (_loginAttempts >= 3) ...[
                      SizedBox(height: 10),
                      InkWell(
                        onTap: _navigateToCustomerService,
                        child: Text(
                          'Contact your owner or Customer Service',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _validateAndLogin,
                      child: Text('Login'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Haven't signed up to our amazing application? Sign up now for free!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: _navigateToSignUp,
                      child: Text('Sign Up Now!'),
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

class CustomerServicePage extends StatelessWidget {
  final String developerEmail = "placeholderdeveloper@gmail.com";
  final String developerPhone = "+63 1234567890";

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$text copied to clipboard'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Service'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text(developerEmail),
              trailing: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () => _copyToClipboard(context, developerEmail),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(developerPhone),
              trailing: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () => _copyToClipboard(context, developerPhone),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
