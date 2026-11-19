import 'package:flutter/material.dart';

import 'routes.dart';
import 'utils/colors.dart';

void main() {
  runApp(const CoSUtudyApp());
}

class CoSUtudyApp extends StatelessWidget {
  const CoSUtudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoSUtudy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        // fontFamily: 'Poppins', // custom font: enable after adding it to pubspec.yaml
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
