import 'package:flutter/material.dart';

import 'routes.dart';
import 'utils/theme_controller.dart';

void main() {
  runApp(const CoSUtudyApp());
}

class CoSUtudyApp extends StatelessWidget {
  const CoSUtudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Rebuilds MaterialApp whenever the user switches between light and dark mode.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.mode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'CoSUtudy',
          debugShowCheckedModeBanner: false,
          theme: ThemeController.buildTheme(Brightness.light),
          darkTheme: ThemeController.buildTheme(Brightness.dark),
          themeMode: mode,
          initialRoute: AppRoutes.login,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
