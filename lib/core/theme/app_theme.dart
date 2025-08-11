import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'base_theme_data.dart';

// ========================== 🔥 Types 🔥 ==========================

enum ThemeModeType {
  lightBlue,

}

// ========================== 🔥 themes 🔥 ==========================

final ThemeData lightDeepBlueTheme = generateBaseThemeData(dark: false, myColors: ThemeModeType.lightBlue.getColors());



// ========================== 🔥 ThemeModeExtension 🔥 ==========================
final _themeModeKeysMap = Map.fromEntries(ThemeModeType.values.map((e) => MapEntry(e.getThemeKey(), e)));

ThemeModeType? getThemeModeFromKey(String? key) => _themeModeKeysMap[key];

extension ThemeModeExtension on ThemeModeType? {
  String getThemeKey() {
    return switch (this) {
      ThemeModeType.lightBlue || null => 'lightDeepBlue',

    };
  }

  ThemeData getTheme() => switch (this) {
        ThemeModeType.lightBlue || null => lightDeepBlueTheme,

      };

  AppColorsBase getColors() => switch (this) {
        ThemeModeType.lightBlue || null => colorsManagerNormal,
      };
}
