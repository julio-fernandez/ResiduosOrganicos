import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  static Future getPreferenceOf(String key) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return (sharedPrefs.get(key) ?? false);
  }

  static setPreference(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    } else {
      print("Guardado como JSON");
      sharedPrefs.setString(key, json.encode(value));
    }
  }

  static getPreferenceJsonOf(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }
}
