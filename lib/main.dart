import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      useMaterial3: true,
      theme: _buildMaterial3Theme(),
      home: const JutcHomePage(),
    );
  }

  ThemeData _buildMaterial3Theme() {
    // Material Design 3 Color Palette - Dark Mode
    const Color primaryGreen = Color(0xFF1B7D3A);
    const Color secondaryYellow = Color(0xFFFFD43B);
    const Color tertiaryBlue = Color(0xFF2196F3);
    const Color surfaceDark = Color(0xFF0B1220);
    const Color backgroundDark = Color(0xFF070C15);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Roboto',

      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: primaryGreen,
        onPrimary: Colors.white,
        primaryContainer: const Color(0xFF2E9B52),
        onPrimaryContainer: Colors.white,
        secondary: secondaryYellow,
        onSecondary: Colors.black87,
        secondaryContainer: const Color(0xFFFFF4A3),
        onSecondaryContainer: Colors.black87,
        tertiary: tertiaryBlue,
        onTertiary: Colors.white,
        tertiaryContainer: const Color(0xFF64B5F6),
        onTertiaryContainer: Colors.white,
        error: const Color(0xFFCF6679),
        errorContainer: const Color(0xFF9B000A),
        onError: Colors.white,
        onErrorContainer: Colors.white,
        background: backgroundDark,
        onBackground: Colors.white,
        surface: surfaceDark,
        onSurface: Colors.white,
        surfaceVariant: const Color(0xFF1A2333),
        onSurfaceVariant: const Color(0xFFBBC7DB),
        outline: const Color(0xFF667085),
        outlineVariant: const Color(0xFF3A4656),
        scrim: Colors.black,
        inverseSurface: const Color(0xFFF5F5F5),
        inverseOnSurface: Colors.black,
        inversePrimary: const Color(0xFF1B7D3A),
      ),

      // Scaffold background
      scaffoldBackgroundColor: backgroundDark,

      // AppBar styling
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark,
        elevation: 0,
        centerTitle: false,
      ),

      // Card styling
      cardTheme: CardTheme(
        color: surfaceDark,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Colors.white12,
            width: 1,
          ),
        ),
      ),

      // Button styling
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          side: const BorderSide(color: primaryGreen, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryGreen,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Input field styling
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white12, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white12, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        hintStyle: const TextStyle(color: Colors.white38),
        prefixIconColor: Colors.white54,
        suffixIconColor: Colors.white54,
      ),

      // Text styling
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displaySmall: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headlineSmall: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        titleSmall: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white87,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white70,
        ),
        bodySmall: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white60,
        ),
      ),

      // Icon styling
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
