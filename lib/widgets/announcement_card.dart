import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../utils/colors.dart';
import '../utils/date_utils.dart';
import '../utils/spacing.dart';
import '../utils/text_styles.dart';

/// Reusable card that shows one announcement.
/// Used on Home; can also be reused on My Announcements.
class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback? onTap;

  /// Optional trailing action (e.g. a remove button on My Announcements).
  final Widget? trailing;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final a = announcement;
    final colors = Theme.of(context).colorScheme;
    final secondary = colors.onSurfaceVariant;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        side: BorderSide(color: colors.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: type tag + capacity
              Row(
                children: [
                  AnnouncementTypeTag(type: a.type),
                  const Spacer(),
                  Text(
                    '${a.joinedCount}/${a.capacity} joined',
                    style: AppTextStyles.caption.copyWith(color: secondary),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: AppSpacing.xs),
                    trailing!,
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.sm),

              // Course code + title
              Text(
                '${a.courseCode} · ${a.title}',
                style: AppTextStyles.cardTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // Location and time only for study sessions
              if (a.type == AnnouncementType.studySession &&
                  a.location != null &&
                  a.dateTime != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 16, color: secondary),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        '${a.location} · ${AppDateUtils.formatDateTime(a.dateTime!)}',
                        style: AppTextStyles.body.copyWith(color: secondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.sm),

              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: colors.surfaceContainerHighest,
                    child: ClipOval(
                      child: Image.network(
                        a.creatorPhotoUrl,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person_outline,
                          size: 16,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      a.creatorName,
                      style: AppTextStyles.caption.copyWith(color: secondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnnouncementTypeTag extends StatelessWidget {
  final AnnouncementType type;
  const AnnouncementTypeTag({required this.type});

  @override
  Widget build(BuildContext context) {
    final isStudy = type == AnnouncementType.studySession;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs / 2,
      ),
      decoration: BoxDecoration(
        color: isStudy ? AppColors.studyTag : AppColors.projectTag,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
      child: Text(
        isStudy ? 'STUDY SESSION' : 'PROJECT TEAM',
        style: AppTextStyles.tag,
      ),
    );
  }
}
