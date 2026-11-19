import 'package:flutter/material.dart';

// PLACEHOLDER — Gence will implement this screen.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false),
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
