import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get theme {
    const primaryColor = Color(0xff04A9F5);

    return ThemeData(
      useMaterial3: true,
      iconTheme: const IconThemeData(color: primaryColor),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: primaryColor),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        onPrimary: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      scaffoldBackgroundColor: Colors.white,
      hintColor: const Color(0xff595959),
      disabledColor: const Color(0xff595959),
      unselectedWidgetColor: const Color(0xffC7C8DA),
      cardColor: const Color(0xffF4F4F4),
      fontFamily: 'OpenSans',
      dividerTheme: const DividerThemeData(color: Color(0xffE6E6E6)),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 57),
        displayMedium: TextStyle(fontSize: 45),
        displaySmall: TextStyle(fontSize: 36),
        headlineLarge: TextStyle(fontSize: 32),
        headlineMedium: TextStyle(fontSize: 28),
        headlineSmall: TextStyle(fontSize: 24),
        titleLarge: TextStyle(fontSize: 56, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontSize: 48, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 40),
        bodyMedium: TextStyle(fontSize: 36),
        bodySmall: TextStyle(fontSize: 32),
        labelLarge: TextStyle(fontSize: 14),
        labelMedium: TextStyle(fontSize: 12),
        labelSmall: TextStyle(fontSize: 11),
      ),
    );
  }
}
