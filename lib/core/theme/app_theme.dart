// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final base = ThemeData(useMaterial3: true);

    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.nunitoTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textPrimary,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
        ),
        headlineSmall: GoogleFonts.playfairDisplay(
          fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.playfairDisplay(
          fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.nunito(
          fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.nunito(
          fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: 14, color: AppColors.textSecond,
        ),
        labelLarge: GoogleFonts.nunito(
          fontSize: 14, fontWeight: FontWeight.w700,
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.dark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w700),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(color: AppColors.accent, width: 1.5),
          textStyle: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: GoogleFonts.nunito(color: AppColors.textMuted),
        hintStyle: GoogleFonts.nunito(color: AppColors.textMuted),
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.cardBorder),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700),
        unselectedLabelStyle: GoogleFonts.nunito(fontSize: 12),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.accentLight,
        selectedColor: AppColors.primary,
        labelStyle: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.accent),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.cardBorder,
        thickness: 1,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.dark,
      ),
    );
  }
}
