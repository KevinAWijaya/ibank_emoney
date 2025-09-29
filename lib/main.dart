import 'package:flutter/material.dart';
import 'package:ibank_emoney/core/theme/theme.dart';
import 'package:ibank_emoney/ui/auth/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme(context),
      home: Scaffold(backgroundColor: Colors.black, body: LoginPage()),
    );
  }
}
