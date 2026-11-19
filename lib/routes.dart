import 'package:flutter/material.dart';

import 'screens/create_announcement_screen.dart';
import 'screens/details_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_shell.dart';
import 'screens/sign_up_screen.dart';

/// All named routes in one place.
class AppRoutes {
  static const login = '/login';
  static const signUp = '/signup';
  static const main = '/main'; // shell with bottom navigation (Home, My Announcements, Profile)
  static const details = '/details';
  static const create = '/create';

  static Map<String, WidgetBuilder> get routes => {
        login: (_) => const LoginScreen(),
        signUp: (_) => const SignUpScreen(),
        main: (_) => const MainShell(),
        details: (_) => const DetailsScreen(),
        create: (_) => const CreateAnnouncementScreen(),
      };
}
