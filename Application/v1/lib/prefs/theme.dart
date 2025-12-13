import 'package:flutter/material.dart';

/// --------------------------------------------------------------
/// BASE COLORS
/// --------------------------------------------------------------
const String kEnglishPrimaryFont = 'AFSobremesa';
const String kEnglishSecondaryFont = 'AFNeueBerlin';
const String kArabicPrimaryFont = 'Zain';
const String kArabicSecondaryFont = 'Almarai';

const Color kPrimary = Color(0xFF7A960F); // Kiwi Green
const Color kPrimaryLight = Color(0xFFA8C51A);
const Color kPrimaryDark = Color(0xFF5E700B);

const Color kSecondary = Color(0xFF464C26); // Khaki Green
const Color kSecondaryLight = Color(0xFF6E7540);
const Color kSecondaryDark = Color(0xFF2E3218);

const Color kCream = Color(0xFFEFE8BC); // Cream
const Color kCreamLight = Color(0xFFF7F3D7);
const Color kCreamDark = Color(0xFFD1CB9F);

/// Non-pure white/black
const Color kSoftWhite = Color(0xFF9F9F9F);
const Color kSoftBlack = Color(0xFF111111);

/// --------------------------------------------------------------
/// LIGHT THEME
/// --------------------------------------------------------------
ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: kPrimary,
      onPrimary: kSoftWhite,
      secondary: kSecondary,
      onSecondary: kSoftWhite,
      error: Colors.red.shade700,
      onError: kSoftWhite,
      surface: kCreamLight,
      onSurface: kSoftBlack,
      tertiary: kSecondaryLight,
    ),

    primaryColor: kPrimary,
    scaffoldBackgroundColor: kCreamLight,

    appBarTheme: AppBarTheme(
      backgroundColor: kPrimary,
      foregroundColor: kSoftWhite,
      elevation: 1,
    ),

    iconTheme: IconThemeData(color: kSecondaryDark),

    textTheme: TextTheme(
      displayLarge: TextStyle(color: kSoftBlack, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: kSoftBlack),
      bodyMedium: TextStyle(color: kSoftBlack.withValues(alpha: 0.85)),
      labelLarge: TextStyle(color: kPrimaryDark, fontWeight: FontWeight.w600),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: kSoftWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kSecondary,
      foregroundColor: kSoftWhite,
    ),
  );
}

/// --------------------------------------------------------------
/// DARK THEME
/// --------------------------------------------------------------
ThemeData buildDarkTheme() {
  final Color darkBackground = Color.lerp(kSoftBlack, kSecondaryDark, 0.2)!;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: kPrimaryLight,
      onPrimary: kSoftBlack,
      secondary: kSecondaryLight,
      onSecondary: kSoftBlack,
      error: Colors.red.shade400,
      onError: kSoftBlack,
      surface: darkBackground,
      onSurface: kSoftWhite,
      tertiary: kSecondary,
    ),

    primaryColor: kPrimaryLight,
    scaffoldBackgroundColor: darkBackground,

    appBarTheme: AppBarTheme(
      backgroundColor: kPrimaryDark,
      foregroundColor: kSoftWhite,
      elevation: 2,
    ),

    iconTheme: IconThemeData(color: kCreamDark),

    textTheme: TextTheme(
      displayLarge: TextStyle(color: kSoftWhite, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: kSoftWhite),
      bodyMedium: TextStyle(color: kSoftWhite.withValues(alpha: 0.9)),
      labelLarge: TextStyle(color: kPrimaryLight, fontWeight: FontWeight.w600),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryLight,
        foregroundColor: kSoftBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kSecondaryLight,
      foregroundColor: kSoftBlack,
    ),
  );
}
