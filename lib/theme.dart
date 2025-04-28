import 'package:flutter/material.dart';

class RickMortyTheme {
  static const Color primary = Color(0xFF04D2C8);
  static const Color accent = Color(0xFFF9D300);
  static const Color background = Color(0xFF161B22);
  static const Color inputFill = Color(0xFF2A2F36);
  static const Color textLight = Colors.white;

  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    colorScheme: ColorScheme.dark(primary: primary, secondary: accent),
    scaffoldBackgroundColor: background,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey[400]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: textLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
