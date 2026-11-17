import 'package:flutter/material.dart';

import 'colors.dart';

/// Holds the current theme mode for the whole app.
/// MaterialApp listens to [mode] and rebuilds when it changes.
class ThemeController {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.light);

  static bool get isDark => mode.value == ThemeMode.dark;

  static void toggle() {
    mode.value = isDark ? ThemeMode.light : ThemeMode.dark;
  }

  static ThemeData buildTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
      ),
      // fontFamily: 'Poppins', // custom font: enable after adding it to pubspec.yaml
    );
  }
}
