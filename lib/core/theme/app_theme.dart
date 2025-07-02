import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF0D47A1);
  static const Color primaryDark = Color(0xFF002171);
  static const Color accent = Color(0xFFF57F17);
  static const Color background = Color(0xFFF5F5F5);
  static const Color onBackground = Color(0xFF212121);

  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
      surface: background,
      onSurface: onBackground,
      error: Colors.redAccent,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        color: onBackground,
      ),
      titleLarge: TextStyle(
        fontSize: 36.0,
        fontStyle: FontStyle.italic,
        color: onBackground,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Hind',
        color: onBackground,
      ),
    ),
  );
}
