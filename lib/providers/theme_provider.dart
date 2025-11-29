import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  // Modern Color Palette
  static const Color _lightPrimary = Color(0xFF6200EE); // Deep Indigo
  static const Color _lightSecondary = Color(0xFF03DAC6); // Teal
  static const Color _lightBackground = Color(0xFFF5F5F5);
  static const Color _lightSurface = Colors.white;

  static const Color _darkPrimary = Color(0xFFBB86FC); // Light Purple
  static const Color _darkSecondary = Color(0xFF03DAC6); // Teal
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);

  ThemeData get currentTheme {
    return _isDarkTheme ? _darkTheme : _lightTheme;
  }

  ThemeData get _lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: _lightPrimary,
        scaffoldBackgroundColor: _lightBackground,
        colorScheme: const ColorScheme.light(
          primary: _lightPrimary,
          secondary: _lightSecondary,
          surface: _lightSurface,
          background: _lightBackground,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: _lightPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _lightPrimary,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        cardTheme: CardTheme(
          color: _lightSurface,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );

  ThemeData get _darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: _darkPrimary,
        scaffoldBackgroundColor: _darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: _darkPrimary,
          secondary: _darkSecondary,
          surface: _darkSurface,
          background: _darkBackground,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: _darkSurface,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _darkPrimary,
            foregroundColor: Colors.black,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        cardTheme: CardTheme(
          color: _darkSurface,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
}
