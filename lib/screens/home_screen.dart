import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../utils/colors.dart';
import '../utils/spacing.dart';
import '../utils/text_styles.dart';
import '../widgets/announcement_card.dart';

/// Home: lists all open announcements, with search by course code
/// and filtering by type. Tap a card -> Details, tap + -> Create.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  AnnouncementType? _selectedType; // null = All

  static const Map<String, AnnouncementType?> _filters = {
    'All': null,
    'Study Session': AnnouncementType.studySession,
    'Project Team': AnnouncementType.projectTeam,
  };

  List<Announcement> get _filtered {
    final q = _query.trim().toLowerCase();
    return sampleAnnouncements.where((a) {
      final matchesType = _selectedType == null || a.type == _selectedType;
      final matchesQuery = q.isEmpty || a.courseCode.toLowerCase().contains(q);
      return matchesType && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('CoSUtudy', style: AppTextStyles.appTitle),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Search by course code…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      ),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radius),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radius),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),

          // Filter chips (horizontally scrollable -> no overflow on small screens)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: _filters.entries.map((entry) {
                final selected = _selectedType == entry.value;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: ChoiceChip(
                    label: Text(entry.key),
                    selected: selected,
                    selectedColor: AppColors.primary,
                    labelStyle: selected
                        ? AppTextStyles.chip.copyWith(color: Colors.white)
                        : AppTextStyles.chip,
                    onSelected: (_) =>
                        setState(() => _selectedType = entry.value),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Announcement list
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text('No announcements found',
                        style: AppTextStyles.body),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80), // room for FAB
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final a = items[index];
                      return AnnouncementCard(
                        key: ValueKey(a.id),
                        announcement: a,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: a,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.pushNamed(context, '/create'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
