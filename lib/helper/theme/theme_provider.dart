import 'package:flutter/material.dart';

import '../../core/storage/storage.dart';
import 'themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode? themeMode;

  ThemeProvider() {
    themeMode ??= storage.getThemeMode();
  }

  Themes getTheme(BuildContext context) =>
      getBrightness(context) == Brightness.dark ? darkTheme : lightTheme;

  Brightness getBrightness(BuildContext context) {
    switch (themeMode) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      default: // system
        return MediaQuery.of(context).platformBrightness;
    }
  }

  setThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    storage.setThemeMode(
      themeMode: themeMode,
    );
    notifyListeners();
  }
}

class ThemeEnum {
  final String name, title;
  final String? description;
  final ThemeMode themeMode;
  final int index;

  const ThemeEnum._internal(
    this.name,
    this.title,
    this.themeMode,
    this.index, {
    this.description,
  });

  @override
  toString() => name;

  static const lightTheme = ThemeEnum._internal(
    'Light',
    'Light Theme',
    ThemeMode.light,
    0,
    description: '',
  );
  static const darkTheme = ThemeEnum._internal(
    'Dark',
    'Dark Theme',
    ThemeMode.dark,
    1,
    description: '',
  );
  static const system = ThemeEnum._internal(
    'Auto',
    'Adapt to System Setting',
    ThemeMode.system,
    2,
    description:
        '''Adapt automatically to the device’s system setting between dark and light themes.''',
  );

  static getTitleList() => [lightTheme.title, darkTheme.title, system.title];

  static getDescriptionList() =>
      [lightTheme.description, darkTheme.description, system.description];

  static getTheme(int index) {
    if (index == lightTheme.index) {
      return lightTheme;
    } else if (index == darkTheme.index) {
      return darkTheme;
    } else {
      return system;
    }
  }

  static getThemeByThemeMode(String themeMode) {
    if (themeMode == lightTheme.themeMode.toString()) {
      return lightTheme;
    } else if (themeMode == darkTheme.themeMode.toString()) {
      return darkTheme;
    } else {
      return system;
    }
  }
}
