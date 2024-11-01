import 'package:flutter/material.dart';
import 'package:cse7l_finalproject/app/screens/redundant_pages/customer_service_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PharmacySearchPage extends StatefulWidget {
  @override
  _PharmacySearchPageState createState() => _PharmacySearchPageState();
}

class _PharmacySearchPageState extends State<PharmacySearchPage> {
  final _searchController = TextEditingController();
  String _errorMessage = '';
  int _searchAttempts = 0;
  bool _pharmaciesExist = true;

  @override
  void initState() {
    super.initState();
    _checkIfDatabaseIsEmpty();
  }

  Future<void> _checkIfDatabaseIsEmpty() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'pharmacy.db');

    final database = await openDatabase(path);
    final List<Map<String, dynamic>> pharmacies =
        await database.query('Pharmacy');
    await database.close();

    setState(() {
      _pharmaciesExist = pharmacies.isNotEmpty;
      if (!_pharmaciesExist) {
        _errorMessage = 'No registered pharmacies are currently available.';
      }
    });
  }

  Future<void> _searchPharmacy() async {
    setState(() {
      _errorMessage = '';
    });

    if (!_pharmaciesExist) {
      setState(() {
        _errorMessage = 'No registered pharmacies are currently available.';
      });
      return;
    }

    if (_searchController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a pharmacy name or ID.';
      });
      return;
    }

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'pharmacy.db');

    final database = await openDatabase(path);
    final List<Map<String, dynamic>> results = await database.query(
      'Pharmacy',
      where: 'pharmacy_id = ? OR name LIKE ?',
      whereArgs: [_searchController.text, '%${_searchController.text}%'],
    );
    await database.close();

    if (results.isEmpty) {
      setState(() {
        _errorMessage =
            'Pharmacy or Pharmacy ID may be incorrect. Please try again.';
        _searchAttempts++;
      });
    } else {
      Navigator.pushNamed(context as BuildContext, '/employeeSignUp');
    }
  }

  void _navigateToCustomerService() {
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => CustomerServicePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Pharmacy'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
                    if (_pharmaciesExist)
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Enter Name or Pharmacy ID',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: _searchPharmacy,
                          ),
                        ),
                        onSubmitted: (_) => _searchPharmacy(),
                      ),
                    if (_errorMessage.isNotEmpty) ...[
                      SizedBox(height: 10),
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                    if (_searchAttempts >= 3) ...[
                      SizedBox(height: 10),
                      InkWell(
                        onTap: _navigateToCustomerService,
                        child: Text(
                          'Recheck details or contact Customer Service',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
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
