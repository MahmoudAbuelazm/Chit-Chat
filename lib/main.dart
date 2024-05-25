import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          fontFamily: GoogleFonts.openSans().fontFamily,
          useMaterial3: false,
          primaryColor: const Color(0xFF075E54),
          hintColor:  Color(0xFF128C7E),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}
