import 'package:flutter/material.dart';
import 'app/screens/auth/login.dart';
import 'app/screens/auth/pharmacy_signup.dart';
import 'app/screens/home/pharmacy_home.dart';
import 'app/theme/app_theme.dart';
import 'app/screens/auth/signup_choice_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmacy Inventory Management App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup_choice': (context) => SignUpChoicePage(),
        //'/signup': (context) => SignUpPage(),
        //'/home': (context) => PharmacyHome(),
      },
    );
  }
}
