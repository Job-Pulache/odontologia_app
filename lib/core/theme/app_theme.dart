import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1F5AA6),
      primary: const Color(0xFF1F5AA6),
    ),

    textTheme: GoogleFonts.interTextTheme(),

    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}