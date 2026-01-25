import 'package:flutter/material.dart';
import 'jutc_home.dart';

void main() {
  runApp(const JutcSmartRideApp());
}

class JutcSmartRideApp extends StatelessWidget {
  const JutcSmartRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JUTC SmartRide',
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070C15),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1B7D3A),
          secondary: Color(0xFFFFD43B),
          surface: Color(0xFF0B1220),
        ),
      ),
      home: const JutcHomePage(),
    );
  }
}
