import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTheme {

  static ThemeData light = ThemeData(

    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),

    textTheme: GoogleFonts.interTextTheme(),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,

      indicatorColor: AppColors.primary.withOpacity(0.12),

      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,

      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}