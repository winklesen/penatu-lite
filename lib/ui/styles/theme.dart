import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// Theming
class AppTheme {

  static final Color primaryColor = const Color(0xFF699BF7);

  static ThemeData _lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      onPrimary: primaryColor,
    ),
  );

  static ThemeData _darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme:
        ColorScheme.dark(primary: primaryColor, onPrimary: primaryColor),
  );

  static TextTheme _textTheme(bool isDark) {
    TextTheme themeData = isDark ? _darkTheme.textTheme : _lightTheme.textTheme;
    TextTheme textTheme = themeData;

    textTheme = themeData.copyWith(
      // displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.openSans(
          textStyle: textTheme.displayMedium
              ?.copyWith(fontSize: 34, fontWeight: FontWeight.bold)),
      displaySmall: GoogleFonts.openSans(
          textStyle: textTheme.displaySmall
              ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
      headlineMedium: GoogleFonts.roboto(
          textStyle: textTheme.headlineMedium
              ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.bold)),
      headlineSmall: GoogleFonts.roboto(
          textStyle: textTheme.headlineSmall
              ?.copyWith(fontSize: 16.0, fontWeight: FontWeight.bold)),
      titleLarge: GoogleFonts.roboto(
          textStyle: textTheme.titleLarge
              ?.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold)),
      // bodyLarge: TextStyle(fontSize: 16.0),
      bodyMedium: GoogleFonts.roboto(
          textStyle: textTheme.bodyMedium?.copyWith(
        fontSize: 14.0,
      )),
      bodySmall: GoogleFonts.roboto(
          textStyle: textTheme.bodySmall?.copyWith(fontSize: 12.0)),
    );

    return textTheme;
  }

  static getLightTheme() {
    return _lightTheme.copyWith(textTheme: _textTheme(false));
  }

  static getDarkTheme() {
    return _darkTheme.copyWith(textTheme: _textTheme(true));
  }
}

class StatusColor {
  static final Color done = AppTheme.primaryColor;
  static final Color onProgress = const Color(0xFFFED519);
  static final Color pending = const Color(0xFF013281);
}