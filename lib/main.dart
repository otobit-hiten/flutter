import 'package:flutter/material.dart';
import 'package:flutter_login/Ui/LoginScreen.dart';
import 'Ui/FirstPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const FirstPage();
  }
}
