import 'package:flutter/material.dart';
import 'package:dwm_bot/pages/chabot.page.dart';
import 'package:dwm_bot/pages/login.page.dart';
import 'package:dwm_bot/pages/settings.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => LoginPage(),
        "/bot": (context) => ChabotPage(),
        "/settings": (context) => SettingsPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
    );
  }
}
