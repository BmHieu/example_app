import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/theme/theme_provider.dart';

const themeModeConst = 'THEME_MODE';
const userData = 'USER_DATA';
const languageData = 'LANGUAGE_DATA';
const answer = 'ANSWER';

class Storage {
  SharedPreferences? _prefs;
  Storage._internal();
  static final Storage _singleton = Storage._internal();

  factory Storage() {
    return _singleton;
  }

  registerTestPreference(SharedPreferences sharedPreferences) {
    _prefs = sharedPreferences;
  }

  ThemeMode getThemeMode() {
    if (_prefs == null) {
      return ThemeMode.system;
    }
    if (!_prefs!.containsKey(themeModeConst)) {
      return ThemeMode.system;
    }
    ThemeEnum themeEnum =
        ThemeEnum.getThemeByThemeMode(_prefs!.getString(themeModeConst)!);
    return themeEnum.themeMode;
  }

  setThemeMode({
    required ThemeMode themeMode,
  }) {
    _prefs!.setString(themeModeConst, themeMode.toString());
  }

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveBoolean({
    required String key,
    required bool value,
  }) async {
    await _prefs!.setBool(key, value);
  }

  Future<bool> getBoolean({
    required String key,
  }) async {
    return _prefs!.getBool(key) ?? false;
  }

  Future<void> saveString({
    required String key,
    required String value,
  }) async {
    await _prefs!.setString(key, value);
  }

  Future<void> remove({
    required String key,
  }) async {
    await _prefs!.remove(key);
  }

  String getString({
    required String key,
  }) {
    return _prefs!.getString(key) ?? '';
  }

  Future<void> saveInt({
    required String key,
    required int value,
  }) async {
    await _prefs!.setInt(key, value);
  }

  Future<int> getInt({
    required String key,
  }) async {
    return _prefs!.getInt(key) ?? -1;
  }

  Future<void> saveDouble({
    required String key,
    required double value,
  }) async {
    await _prefs!.setDouble(key, value);
  }

  Future<double> getDouble({
    required String key,
  }) async {
    return _prefs!.getDouble(key) ?? 0;
  }

  void saveLanguage(String languageCode) {
    _prefs!.setString(languageData, languageCode);
  }

  Future<String> getLanguage() async {
    var languageCode = _prefs!.getString(languageData);
    if (languageCode != null) return languageCode;
    var currentLocale = await Devicelocale.currentAsLocale;
    saveLanguage(currentLocale?.languageCode ?? 'vi');
    return currentLocale?.languageCode ?? 'vi';
  }
}

final storage = Storage();
