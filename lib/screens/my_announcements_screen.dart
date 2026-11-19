import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../models/my_activity.dart';
import '../utils/spacing.dart';
import '../widgets/announcement_card.dart';
import 'account_widgets.dart';

/// Lists the announcements the demo user created and joined, in two tabs.
class MyAnnouncementsScreen extends StatelessWidget {
  const MyAnnouncementsScreen({super.key});

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
                _AnnouncementList(items: created),
                _AnnouncementList(items: joined),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Scrollable list of announcement cards; tapping a card opens Details.
class _AnnouncementList extends StatelessWidget {
  final List<Announcement> items;
  const _AnnouncementList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: items.length,
      itemBuilder: (context, i) => AnnouncementCard(
        announcement: items[i],
        onTap: () => Navigator.pushNamed(
          context,
          '/details',
          arguments: items[i],
        ),
      ),
    );
  }
}