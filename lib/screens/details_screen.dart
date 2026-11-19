import 'package:flutter/material.dart';

import '../models/announcement.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}