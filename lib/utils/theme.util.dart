import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemesUtil {
  ThemeMode currentTheme = ThemeMode.light;
  getTheme() => currentTheme;
  setTheme(ThemeMode themeMode) {
    currentTheme = themeMode;
    Get.changeThemeMode(themeMode);
  }

  switchTheme() {
    if (Get.isDarkMode) {
      currentTheme = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    } else {
      currentTheme = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    }
  }

  static final light = ThemeData(
    useMaterial3: true,
    fontFamily: "Acumin Pro",
    colorScheme: const ColorScheme.light(
      surface: Color(0xFF0E0D24),
      onSurface: Color(0xFFFFFFFF),
      onSecondaryFixedVariant: Color(0xFFe4b9ff),
      surfaceContainerLow: Color(0xFF540B81),
      surfaceContainerHigh: Color(0xFFB600FF),
      primaryFixed: Color(0xFFFFCE1B),
      secondaryFixed: Color(0xFFFF6812),
      onSurfaceVariant: Color(0xFF808080),
      scrim: Color(0xFF4CBB17),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Color(0xFF0F1011),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF8F8F9),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Color(0xFFA4AAB1),
      unselectedItemColor: Color(0xFFA4AAB1),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      headerForegroundColor: Color(0xFF0F1011),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      yearForegroundColor: MaterialStatePropertyAll(Color(0xFF0F1011)),
      dividerColor: Color(0xFFA4AAB1),
    ),
  );
}
