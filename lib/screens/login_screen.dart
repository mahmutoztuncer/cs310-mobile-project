import 'package:flutter/material.dart';

import 'account_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    // Step 2 demonstrates navigation only; no credentials are authenticated.
    DemoAccount.reset();
    DemoAccount.email = _email.text.trim().toLowerCase();
    FocusScope.of(context).unfocus();
    Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.school_outlined, size: 48),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'CoSUtudy',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Find study partners and project\nteammates on your campus.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      'Log In',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    AccountField(
                      label: 'University Email',
                      hint: 'e.g. name@sabanciuniv.edu',
                      controller: _email,
                      validator: AccountValidation.email,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.username],
                    ),
                    AccountField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _password,
                      password: true,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your password.'
                          : null,
                      autofillHints: const [AutofillHints.password],
                      onSubmitted: _login,
                    ),
                    const SizedBox(height: 12),
                    AccountButton(label: 'Log In', onPressed: _login),
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/signup'),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
