import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 57.sp),
        displayMedium: TextStyle(fontSize: 45.sp),
        displaySmall: TextStyle(fontSize: 36.sp),
        headlineLarge: TextStyle(fontSize: 32.sp),
        headlineMedium: TextStyle(fontSize: 28.sp),
        headlineSmall: TextStyle(fontSize: 24.sp),
        titleLarge: TextStyle(fontSize: 56.sp, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 40.sp),
        bodyMedium: TextStyle(fontSize: 36.sp),
        bodySmall: TextStyle(fontSize: 32.sp),
        labelLarge: TextStyle(fontSize: 14.sp),
        labelMedium: TextStyle(fontSize: 12.sp),
        labelSmall: TextStyle(fontSize: 11.sp),
      ),
    );
  }
}
