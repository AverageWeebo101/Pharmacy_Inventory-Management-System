import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
