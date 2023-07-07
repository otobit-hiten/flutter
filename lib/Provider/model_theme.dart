import 'package:flutter/material.dart';
import 'package:flutter_login/sharedPreference/SharedPref.dart';

class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  late MyPref _preferences;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = true;
    _preferences = MyPref();
    getPreferences();
  }
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}