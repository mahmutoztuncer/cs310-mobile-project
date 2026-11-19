import 'package:flutter/material.dart';

import '../utils/date_utils.dart';
import '../utils/spacing.dart';
import '../utils/text_styles.dart';
import 'labeled_text_field.dart';

/// Tap-to-pick date and time field with inline validation.
class DateTimeFormField extends FormField<DateTime> {
  DateTimeFormField({
    super.key,
    super.initialValue,
  }) : super(
          validator: (value) {
            if (value == null) return 'Please select a date and time';
            if (value.isBefore(DateTime.now())) {
              return 'Date and time must be in the future';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (state) {
            final context = state.context;
            final colors = Theme.of(context).colorScheme;

            Future<void> pick() async {
              final now = DateTime.now();
              final date = await showDatePicker(
                context: context,
                initialDate: state.value ?? now,
                firstDate: now,
                lastDate: now.add(const Duration(days: 365)),
              );
              if (date == null || !context.mounted) return;
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(state.value ?? now),
              );
              if (time == null) return;
              state.didChange(DateTime(
                  date.year, date.month, date.day, time.hour, time.minute));
            }

            final hasValue = state.value != null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date & Time',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: pick,
                  child: InputDecorator(
                    isEmpty: !hasValue,
                    decoration: formFieldDecoration(
                      context,
                      '',
                      errorText: state.errorText,
                      suffixIcon: Icon(Icons.calendar_today_outlined,
                          size: 20, color: colors.onSurfaceVariant),
                    ),
                    child: Text(
                      hasValue
                          ? AppDateUtils.formatDateTime(state.value!)
                          : 'Select date and time',
                      style: AppTextStyles.body.copyWith(
                        color: hasValue
                            ? colors.onSurface
                            : colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
}
