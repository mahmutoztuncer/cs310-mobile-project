import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../models/my_activity.dart';
import '../utils/spacing.dart';
import '../utils/text_styles.dart';
import '../widgets/announcement_card.dart';
import 'account_widgets.dart';

/// Lists the announcements the demo user created and joined, in two tabs.
/// Created cards can be removed; joined cards can be left.
class MyAnnouncementsScreen extends StatefulWidget {
  const MyAnnouncementsScreen({super.key});

  @override
  State<MyAnnouncementsScreen> createState() => _MyAnnouncementsScreenState();
}

class _MyAnnouncementsScreenState extends State<MyAnnouncementsScreen> {
  /// Shows a confirmation dialog and returns true only if the user confirms.
  Future<bool> _confirm({
    required String title,
    required String message,
    required String action,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(action),
          ),
        ],
      ),
    );
    return result ?? false; // tapping outside the dialog returns null
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _remove(Announcement a) async {
    final confirmed = await _confirm(
      title: 'Remove announcement?',
      message: '"${a.courseCode} · ${a.title}" will be deleted for everyone.',
      action: 'Remove',
    );
    if (!confirmed || !mounted) return;
    setState(() {
      sampleAnnouncements.removeWhere((x) => x.id == a.id);
    });
    _showMessage('Announcement removed.');
  }

  Future<void> _leave(Announcement a) async {
    final confirmed = await _confirm(
      title: 'Leave announcement?',
      message: 'You will be removed from "${a.courseCode} · ${a.title}".',
      action: 'Leave',
    );
    if (!confirmed || !mounted) return;
    MyActivity.leave(a.id); // the ValueListenableBuilder rebuilds the lists
    _showMessage('You left this announcement.');
  }

  @override
  Widget build(BuildContext context) {
    // Rebuilds whenever the user joins or leaves an announcement.
    return ValueListenableBuilder<Set<String>>(
      valueListenable: MyActivity.joinedIds,
      builder: (context, joinedIds, _) {
        final created = sampleAnnouncements
            .where((a) => a.creatorName == DemoAccount.fullName)
            .toList();
        final joined = sampleAnnouncements
            .where((a) => joinedIds.contains(a.id))
            .toList();

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('My Announcements'),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Created (${created.length})'),
                  Tab(text: 'Joined (${joined.length})'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _AnnouncementList(
                  items: created,
                  actionLabel: 'Remove',
                  onAction: _remove,
                  emptyMessage: 'You haven\'t created any announcements yet.\n'
                      'Tap + on Home to create one.',
                ),
                _AnnouncementList(
                  items: joined,
                  actionLabel: 'Leave',
                  onAction: _leave,
                  emptyMessage: 'You haven\'t joined any announcements yet.\n'
                      'Browse Home to find a study session or team.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Scrollable list of announcement cards with one action button per card.
/// Shows a message instead when the list is empty.
class _AnnouncementList extends StatelessWidget {
  final List<Announcement> items;
  final String actionLabel;
  final void Function(Announcement) onAction;
  final String emptyMessage;

  const _AnnouncementList({
    required this.items,
    required this.actionLabel,
    required this.onAction,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 48,
                color: colors.onSurfaceVariant,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                emptyMessage,
                textAlign: TextAlign.center,
                style: AppTextStyles.body
                    .copyWith(color: colors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final a = items[i];
        return AnnouncementCard(
          announcement: a,
          onTap: () => Navigator.pushNamed(context, '/details', arguments: a),
          trailing: TextButton(
            onPressed: () => onAction(a),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(actionLabel),
          ),
        );
      },
    );
  }
}