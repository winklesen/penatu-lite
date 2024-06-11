import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Use this for caching.
class SharedPrefHelper {
  final SharedPreferences preferences;

  SharedPrefHelper({required this.preferences});

  static const _THEME = "theme";
  static const _KILO_PRICE = "kiloPrice";

  Future setDarkTheme(bool value) async {
    preferences.setBool(_THEME, value);
  }

  Future<bool> getValueDarkTheme() async {
    return preferences.getBool(_THEME) ?? false;
  }

  Future setKiloPrice(double value) async {
    preferences.setDouble(_KILO_PRICE, value);
  }

  Future<double> getValueKiloPrice() async {
    return preferences.getDouble(_KILO_PRICE) ?? 0;
  }
}
