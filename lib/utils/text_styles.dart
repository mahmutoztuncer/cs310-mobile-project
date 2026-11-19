// Custom font family is set once in ThemeData (main.dart), so these
// styles inherit it automatically.
import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyles {
  static const appTitle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary);
  static const cardTitle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const body = TextStyle(fontSize: 14, color: AppColors.textSecondary);
  static const caption =
      TextStyle(fontSize: 12, color: AppColors.textSecondary);
  static const tag = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      color: AppColors.textPrimary);
  static const chip = TextStyle(fontSize: 13, color: AppColors.textPrimary);
}
