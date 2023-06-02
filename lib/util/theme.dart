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
        surfaceTintColor: Color(0xFFFAF6F9),
        color: Color(0xFFFAF6F9),
        elevation: 1),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),
      surfaceTintColor:  Color(0xFFFFFFFF),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFFfffbff),
      surfaceTintColor: Color(0xFFfffbff),
    ),
    listTileTheme: const ListTileThemeData(iconColor: Color(0xFF454546)),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange.shade700,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.8),
          ),
        )),
    dividerTheme: const DividerThemeData(color:  Color(0xFFB2B2B2)),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Color(0xfff69056)),
    bottomAppBarColor: const Color(0xFFfffbff),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Colors.orange.shade700),
      selectedLabelStyle: TextStyle(color: Colors.orange.shade700),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: const Color(0xFFfffbff),
    ),
  );

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    listTileTheme: const ListTileThemeData(iconColor: Color(0xFFE2E2E9)),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1C1A19),
    scaffoldBackgroundColor: const Color(0xFF1C1A19),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFF965b),
      onPrimary: Color(0xFF542100),
      secondary: Color(0xFFd97c41),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1C1A19),
      surfaceTintColor: Color(0xFF1C1A19),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1C1A19),
      surfaceTintColor: Color(0xFF1C1A19),
    ),
    cardTheme: const CardTheme(
      elevation: 0,
      color: Color(0xFF2C2A29),
      surfaceTintColor: Color(0xFF2C2A29),
    ),
    dialogTheme: const DialogTheme(
      surfaceTintColor:  Color(0xFF2C2A29),
      backgroundColor: Color(0xFF2C2A29),
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFF965b),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.8),
          ),
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Color(0xFFFF965b)),
      selectedLabelStyle: TextStyle(color: Color(0xFFFF965b)),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFF1C1A19),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFfca36f),
    ),
    dividerTheme: const DividerThemeData(color:  Color(0xFF424242)),
    bottomAppBarColor: const Color(0xFF1C1A19),
);
