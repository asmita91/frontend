import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getApplicationTheme(bool isDark) {
    return ThemeData(
      useMaterial3:
          true, // or false depending on your preference for Material 3
      primarySwatch: Colors
          .blueGrey, // Common for both themes unless you want to differentiate
      scaffoldBackgroundColor:
          isDark ? Colors.black : Colors.white, // Background color
      colorScheme: isDark
          ? ColorScheme.dark(
              primary: Colors.blueGrey, // Adjust primary color for dark theme
              background: Colors.black,
              onBackground: Colors.white, // Text color on background
              surface: Colors.grey[850]!, // Adjust surface color for dark theme
              onSurface: Colors.white, // Text color on surface
            )
          : const ColorScheme.light(
              primary: Colors.blueGrey, // Adjust primary color for light theme
              background: Colors.white,
              onBackground: Colors.black, // Text color on background
              surface: Colors.white, // Adjust surface color for light theme
              onSurface: Colors.black, // Text color on surface
            ),
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: 'Montserrat',

      // Customize other theme attributes as needed
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor:
            isDark ? Colors.grey[900] : Colors.blueGrey, // AppBar background
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : Colors.white, // AppBar text color
          fontSize: 20,
        ),
      ),

      // You can adjust ElevatedButton, InputDecorationTheme, etc., similarly
      // based on isDark flag to match your dark and light theme preferences
    );
  }
}
