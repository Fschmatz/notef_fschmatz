import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFfffbff),
    scaffoldBackgroundColor: const Color(0xFFfffbff),
    colorScheme: ColorScheme.light(
      primary: Colors.orange.shade700,
      onPrimary: const Color(0xFFFFFFFF),
      secondary: Colors.orange.shade700,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFFfffbff),
      color: Color(0xFFfffbff),
    ),
    cardTheme: const CardTheme(
        surfaceTintColor:  Color(0xFFFAF6F9),
        color: Color(0xFFFAF6F9),
        elevation: 1),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange.shade700,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(12.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(12.0))),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Color(0xFFffa470)),
    bottomAppBarColor: const Color(0xFFfffbff),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Colors.orange.shade700),
      selectedLabelStyle: TextStyle(color: Colors.orange.shade700),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: const Color(0xFFfffbff),
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFFfffbff)));

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1C1C1D),
    scaffoldBackgroundColor: const Color(0xFF1C1C1D),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFF965b),
      onPrimary: Color(0xFF542100),
      secondary: Color(0xFFd97c41),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1C1C1D),
      surfaceTintColor: Color(0xFF1C1C1D),
    ),
    cardTheme: const CardTheme(
      elevation: 0,
      color: Color(0xFF2C2C2D),
      surfaceTintColor: Color(0xFF2C2C2D),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF2C2C2D),
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFFF965b),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(12.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(12.0))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Color(0xFFFF965b)),
      selectedLabelStyle: TextStyle(color: Color(0xFFFF965b)),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFF1C1C1D),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFfca36f),
    ),
    bottomAppBarColor: const Color(0xFF1C1C1D),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFF1C1C1D)));
