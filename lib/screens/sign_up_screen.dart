import 'package:flutter/material.dart';

// PLACEHOLDER — Gence will implement this screen.
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/main'),
          child: const Text('Sign Up'),
        ),
      ),
    );
  }
}
