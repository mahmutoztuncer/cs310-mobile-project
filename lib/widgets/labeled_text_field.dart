import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/spacing.dart';
import '../utils/text_styles.dart';

/// Filled, theme-aware input decoration shared by the Create Announcement form.
InputDecoration formFieldDecoration(
  BuildContext context,
  String hint, {
  String? errorText,
  Widget? suffixIcon,
}) {
  final colors = Theme.of(context).colorScheme;

  OutlineInputBorder border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color),
      );

  return InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyles.body.copyWith(color: colors.onSurfaceVariant),
    errorText: errorText,
    errorMaxLines: 2,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: colors.surfaceContainerHighest,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: 13,
    ),
    border: border(Colors.transparent),
    enabledBorder: border(Colors.transparent),
    focusedBorder: border(colors.primary),
    errorBorder: border(colors.error),
    focusedErrorBorder: border(colors.error),
  );
}

/// Label on top + text field with inline validation.
class LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          minLines: maxLines > 1 ? 4 : 1,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: AppTextStyles.body.copyWith(color: colors.onSurface),
          decoration: formFieldDecoration(context, hint),
        ),
      ],
    );
  }
}
