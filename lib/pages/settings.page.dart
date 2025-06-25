import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController urlController = TextEditingController();
  String? baseUrl;

  @override
  void initState() {
    super.initState();
    // Load the previously saved URL if any
    baseUrl = 'http://192.168.60.132';  // Default value
    urlController.text = baseUrl!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'Enter Server Base URL (without port)',
                hintText: 'e.g., http://192.168.60.132',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  baseUrl = urlController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1565C0), // Blue background
                foregroundColor: Colors.white, // White text color
              ),
              child: Text("Save URL"),
            ),
          ],
        ),
      ),
    );
  }
}
