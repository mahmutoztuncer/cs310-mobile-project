// Custom font family is set once in ThemeData (main.dart), so these
// styles inherit it automatically.
// Colors are not fixed here: text takes its color from the current theme,
// or the screen adds one with copyWith(color: ...).
import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyles {
  static const appTitle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  static const cardTitle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const body = TextStyle(fontSize: 14);
  static const caption = TextStyle(fontSize: 12);
  static const chip = TextStyle(fontSize: 13);
  static const tag = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      color: AppColors.tagText);
}
