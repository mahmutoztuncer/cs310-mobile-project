import 'package:flutter/material.dart';

// PLACEHOLDER — Gence will implement this screen.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/main'),
              child: const Text('Log In'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
