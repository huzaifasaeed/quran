import 'package:fabrikod_quran/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension EThemeModesExtension on EThemeModes {
  /// Get Theme Data for EThemeModes
  ThemeData get getThemeData {
    switch (this) {
      case EThemeModes.light:
        return themeLight;
      case EThemeModes.dark:
        return themeDark;
      case EThemeModes.quran:
        return themeQuran;
      case EThemeModes.green:
        return themeGreen;
    }
  }
  /// Get Name Of EThemeModes
  String name(BuildContext context) {
    switch (this) {
      case EThemeModes.light:
        return context.translate.lightMode;
      case EThemeModes.dark:
        return context.translate.darkMode;
      case EThemeModes.quran:
        return context.translate.quranMode;
      case EThemeModes.green:
        return context.translate.greenMode;
    }
  }
}

extension BuildContextExtension on BuildContext {
  /// Helping function to translate the text
  AppLocalizations get translate {
    return AppLocalizations.of(this)!;
  }

  /// Helping function to get the theme
  ThemeData get theme {
    return Theme.of(this);
  }
}