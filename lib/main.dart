import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:securezone/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 201, 28, 28),
  ),
  textTheme: GoogleFonts.dmSansTextTheme(),
);


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}

