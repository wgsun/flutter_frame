import 'dart:convert';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

///本地存储
class SpUtil {
  static final SpUtil instance = SpUtil.privateConstructor();

  factory SpUtil() => instance;

  SpUtil.privateConstructor() {
    init();
  }

  static SharedPreferences _prefs;

  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setBool(String key, bool val) {
    return _prefs.setBool(key, val);
  }

  bool getBool(String key) {
    bool val = _prefs.getBool(key);
    return val == null ? false : val;
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  String getString(String key, {String defValue = ''}) {
    return _prefs.getString(key) ?? defValue;
  }

  Future<bool> putString(String key, String value) {
    return _prefs.setString(key, value);
  }
}
