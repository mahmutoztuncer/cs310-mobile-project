import 'package:flutter/material.dart';

/// Brand colors that stay the same in light and dark mode.
/// For backgrounds, text and borders use Theme.of(context).colorScheme
/// (surface, onSurface, onSurfaceVariant, outlineVariant ...) so they adapt to the theme.
class AppColors {
  static const primary = Color(0xFF1E3A8A); // seed color for both themes
  static const studyTag = Color(0xFFDCE8FF);
  static const projectTag = Color(0xFFFFE9D6);
  static const tagText = Color(0xFF1A1A1A); // tags keep a light background in both themes
}
