import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF075E54),
          hintColor: Color(0xFF128C7E),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}
