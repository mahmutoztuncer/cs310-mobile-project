import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../utils/date_utils.dart';
import '../utils/spacing.dart';
import '../utils/text_styles.dart';
import '../widgets/announcement_card.dart';

/// Shows the full information of one announcement.
/// Home opens it with:
/// Navigator.pushNamed(context, '/details', arguments: announcement)
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The announcement that was tapped on Home.
    final a = ModalRoute.of(context)!.settings.arguments as Announcement;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Announcement Details')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnnouncementTypeTag(type: a.type),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${a.courseCode} · ${a.title}',
                style: AppTextStyles.appTitle,
              ),
              const SizedBox(height: AppSpacing.md),

              // Creator row: network image with a fallback icon
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: colors.surfaceContainerHighest,
                    child: ClipOval(
                      child: Image.network(
                        a.creatorPhotoUrl,
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person_outline,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Posted by',
                          style: AppTextStyles.caption
                              .copyWith(color: colors.onSurfaceVariant),
                        ),
                        Text(
                          a.creatorName,
                          style: AppTextStyles.cardTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _InfoCard(
                rows: [
                  _InfoRow(label: 'Course Code', value: a.courseCode),
                  if (a.location != null)
                    _InfoRow(label: 'Location', value: a.location!),
                  if (a.dateTime != null)
                    _InfoRow(
                      label: 'Date & Time',
                      value: AppDateUtils.formatDateTime(a.dateTime!),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text('Description', style: AppTextStyles.cardTitle),
              const SizedBox(height: AppSpacing.sm),
              Text(
                a.description,
                style: AppTextStyles.body
                    .copyWith(color: colors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// One label/value pair shown in the info card.
class _InfoRow {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});
}

/// Bordered card that lists label/value rows separated by dividers.
class _InfoCard extends StatelessWidget {
  final List<_InfoRow> rows;
  const _InfoCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) Divider(height: 1, color: colors.outlineVariant),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm + AppSpacing.xs,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rows[i].label,
                    style: AppTextStyles.caption
                        .copyWith(color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 2),
                  Text(rows[i].value, style: AppTextStyles.cardTitle),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}