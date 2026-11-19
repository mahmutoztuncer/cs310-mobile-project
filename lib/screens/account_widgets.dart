import 'package:flutter/material.dart';

/// Step 2 in-memory demo data. Replace with Firebase in the backend step.
/// Passwords are never stored in this profile model.
class DemoAccount {
  static String fullName = 'Ayşe Yılmaz';
  static String studentId = '12345';
  static String email = 'ayse.yilmaz@sabanciuniv.edu';
  static int created = 3;
  static int joined = 5;

  static void reset() {
    fullName = 'Ayşe Yılmaz';
    studentId = '12345';
    email = 'ayse.yilmaz@sabanciuniv.edu';
    created = 3;
    joined = 5;
  }
}

class AccountValidation {
  static String? requiredText(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required.' : null;

  static String? email(String? value) =>
      RegExp(
        r'^[^\s@]+@sabanciuniv\.edu$',
        caseSensitive: false,
      ).hasMatch(value?.trim() ?? '')
      ? null
      : 'Enter your Sabancı University email.';

  static String? studentId(String? value) =>
      RegExp(r'^\d+$').hasMatch(value?.trim() ?? '')
      ? null
      : 'Enter a numeric student ID.';

  static String? password(String? value) =>
      (value?.length ?? 0) < 6 ? 'Use at least 6 characters.' : null;
}

/// Reusable wireframe field with theme-aware colors and password visibility.
class AccountField extends StatefulWidget {
  const AccountField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.password = false,
    this.keyboardType,
    this.autofillHints,
    this.onSubmitted,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool password;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final VoidCallback? onSubmitted;

  @override
  State<AccountField> createState() => _AccountFieldState();
}

class _AccountFieldState extends State<AccountField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          obscureText: widget.password && _hidden,
          autocorrect: false,
          enableSuggestions: !widget.password,
          textCapitalization: widget.label == 'Full Name'
              ? TextCapitalization.words
              : TextCapitalization.none,
          textInputAction: widget.onSubmitted == null
              ? TextInputAction.next
              : TextInputAction.done,
          onFieldSubmitted: (_) => widget.onSubmitted?.call(),
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            suffixIcon: widget.password
                ? IconButton(
                    tooltip:
                        '${_hidden ? 'Show' : 'Hide'} ${widget.label.toLowerCase()}',
                    onPressed: () => setState(() => _hidden = !_hidden),
                    icon: Icon(
                      _hidden
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  )
                : null,
          ),
        ),
      ],
    ),
  );
}

class AccountButton extends StatelessWidget {
  const AccountButton({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}
