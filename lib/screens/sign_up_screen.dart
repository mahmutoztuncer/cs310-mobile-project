import 'package:flutter/material.dart';

import 'account_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _studentId = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();

  @override
  void dispose() {
    for (final controller in [
      _name,
      _studentId,
      _email,
      _password,
      _confirmation,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _backToLogin() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _signUp() {
    if (!_formKey.currentState!.validate()) return;
    // In-memory UI demo only; passwords are never stored in profile data.
    DemoAccount.fullName = _name.text.trim();
    DemoAccount.studentId = _studentId.text.trim();
    DemoAccount.email = _email.text.trim().toLowerCase();
    DemoAccount.created = 0;
    DemoAccount.joined = 0;
    FocusScope.of(context).unfocus();
    Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Sign Up'),
      leading: BackButton(onPressed: _backToLogin),
    ),
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
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
                  Text(
                    'Create an account with your university email.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  AccountField(
                    label: 'Full Name',
                    hint: 'e.g. Ayşe Yılmaz',
                    controller: _name,
                    validator: AccountValidation.requiredText,
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                  ),
                  AccountField(
                    label: 'Student ID',
                    hint: 'e.g. 12345',
                    controller: _studentId,
                    validator: AccountValidation.studentId,
                    keyboardType: TextInputType.number,
                  ),
                  AccountField(
                    label: 'University Email',
                    hint: 'e.g. name@sabanciuniv.edu',
                    controller: _email,
                    validator: AccountValidation.email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                  AccountField(
                    label: 'Password',
                    hint: 'At least 6 characters',
                    controller: _password,
                    validator: AccountValidation.password,
                    password: true,
                    autofillHints: const [AutofillHints.newPassword],
                  ),
                  AccountField(
                    label: 'Confirm Password',
                    hint: 'Re-enter your password',
                    controller: _confirmation,
                    password: true,
                    onSubmitted: _signUp,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Confirm your password.'
                        : value != _password.text
                        ? 'Passwords do not match.'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  AccountButton(label: 'Sign Up', onPressed: _signUp),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: _backToLogin,
                        child: const Text('Log In'),
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
