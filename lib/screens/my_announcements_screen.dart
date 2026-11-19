import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../models/my_activity.dart';
import '../utils/spacing.dart';
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
      DemoAccount.created--; // keeps the Profile count in sync
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
                ),
                _AnnouncementList(
                  items: joined,
                  actionLabel: 'Leave',
                  onAction: _leave,
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
/// Tapping a card opens Details.
class _AnnouncementList extends StatelessWidget {
  final List<Announcement> items;
  final String actionLabel;
  final void Function(Announcement) onAction;

  const _AnnouncementList({
    required this.items,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
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