import 'package:flutter/material.dart';
import 'theme_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData theme) async {
    _themeData = theme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', _themeToString(theme));
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? saved = prefs.getString('theme');
    _themeData = _stringToTheme(saved);
    notifyListeners();
  }

  // Helpers
  String _themeToString(ThemeData theme) {
    if (theme == ThemeClass.darkTheme) return 'dark';
    if (theme == ThemeClass.pinkTheme) return 'pink';
    if (theme == ThemeClass.greenTheme) return 'green';
    return 'light';
  }

  ThemeData _stringToTheme(String? theme) {
    switch (theme) {
      case 'dark':
        return ThemeClass.darkTheme;
      case 'pink':
        return ThemeClass.pinkTheme;
      case 'green':
        return ThemeClass.greenTheme;
      default:
        return ThemeClass.lightTheme;
    }
  }
}
