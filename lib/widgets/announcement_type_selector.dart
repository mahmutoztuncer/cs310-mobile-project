import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../utils/spacing.dart';
import '../utils/text_styles.dart';

/// "Study Session / Project Team" chip selector.
/// Built as a FormField so it can show an inline validation error.
class AnnouncementTypeSelector extends FormField<AnnouncementType> {
  AnnouncementTypeSelector({
    super.key,
    super.initialValue,
    required ValueChanged<AnnouncementType> onChanged,
  }) : super(
          validator: (value) =>
              value == null ? 'Please choose an announcement type' : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (state) {
            final colors = Theme.of(state.context).colorScheme;

            String labelOf(AnnouncementType t) =>
                t == AnnouncementType.studySession
                    ? 'Study Session'
                    : 'Project Team';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Announcement Type',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final type in AnnouncementType.values)
                      ChoiceChip(
                        label: Text(labelOf(type)),
                        selected: state.value == type,
                        showCheckmark: false,
                        selectedColor: colors.primary,
                        side: BorderSide(color: colors.outline),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        labelStyle: AppTextStyles.body.copyWith(
                          fontSize: 13,
                          color: state.value == type
                              ? colors.onPrimary
                              : colors.onSurface,
                        ),
                        onSelected: (_) {
                          state.didChange(type);
                          onChanged(type);
                        },
                      ),
                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      state.errorText!,
                      style: AppTextStyles.caption
                          .copyWith(color: colors.error),
                    ),
                  ),
              ],
            );
          },
        );
}
