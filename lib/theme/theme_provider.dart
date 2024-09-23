import 'package:flutter/material.dart';
import 'package:todo_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = false;

  ThemeData get themeData => isDarkMode ? darkMode : lightMode;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
