import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomColors {
  static const Color darkGreen = Color(0xFF02513D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGreen = Color(0xFFE6F4E2);
  static const Color teal = Color(0xFF008A66);
  static const Color darkGreenDuplicate = Color(0xFF02513D);
  static const Color lightTeal = Color(0xFF98CFD7);
  static const Color grey = Color(0xFF959595);
  static const Color mediumGreen = Color(0xFF74A38F);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color fieldGrey = Color(0xFFE3E4E5);
}

class MainTheme {
  static Color primary = CustomColors.darkGreen;
  static Color background = CustomColors.white;

  static ThemeData lightTheme = ThemeData.light().copyWith(
    bottomAppBarTheme: BottomAppBarTheme(
      color: primary,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme,
    ).copyWith(
      titleLarge: GoogleFonts.poppins(
        color: background,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}