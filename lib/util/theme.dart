import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFFF7F6F6),
    scaffoldBackgroundColor: const Color(0xFFF7F6F6),
    colorScheme: ColorScheme.light(
      primary:  Colors.orange.shade700,
      onPrimary:  const Color(0xFFFFFFFF),
      secondary: Colors.orange.shade700,
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFFF7F6F6),
        elevation: 0,
        iconTheme: IconThemeData(
            color: Color(0xFF000000)
        ),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000))),
    cardTheme: const CardTheme(
      color: Color(0xFFFFFFFF),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange.shade700,
          ),
          borderRadius: BorderRadius.circular(12.0),
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
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFffa470)
    ),
    bottomAppBarColor: const Color(0xFFF7F6F6),
    accentTextTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.orange.shade700,
      ),
      headline2: const TextStyle(
        color: Color(0xFF8a4500),
      ),
    ),
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Colors.orange.shade700),
      selectedLabelStyle: TextStyle(color: Colors.orange.shade700),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: const Color(0xFFF7F6F6),
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFFF7F6F6)));

ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1C1C1D),
    scaffoldBackgroundColor: const Color(0xFF1C1C1D),
    colorScheme: const ColorScheme.dark(
      primary:  Color(0xFFFF965b),
      onPrimary:  Color(0xFF542100),
      secondary: Color(0xFFd97c41),
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFF1C1C1D),
        elevation: 0,
        iconTheme: IconThemeData(
            color: Color(0xFFFFFFFF)
        ),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFFFFFFFF))),
    cardTheme: const CardTheme(
      elevation: 0,
      color: Color(0xFF2C2C2D),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF2C2C2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFFF965b),
          ),
          borderRadius: BorderRadius.circular(12.0),
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
    accentTextTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFFFF965b),
      ),
      headline2: TextStyle(
        color: Color(0xFFffceb3),
      ),
    ),
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

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  late SharedPreferences prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
